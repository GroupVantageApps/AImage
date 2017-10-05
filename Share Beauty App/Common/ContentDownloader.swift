import Alamofire
import SwiftSpinner
import SwiftyJSON
import Zip

enum ContentDownloadError: Error {
    case dbError(Error?)
    case apiRequest(Error?)
    case downloadKey
    case downloadMaster
    case downloadCheck
    case downloadFile
    case downloadUpdateStatus
    case sendComplete
    case sendFailure

    var desctiption: String {
        switch self {
        case .dbError(let error):
            if let message = error?.localizedDescription {
                return message
            } else {
                return "db error"
            }
        case .apiRequest(let error):
            if let message = error?.localizedDescription {
                return message
            } else {
                return "api request error"
            }
        case .downloadKey:
            return "download key error"
        case .downloadMaster:
            return "download master error"
        case .downloadCheck:
            return "download check error"
        case .downloadFile:
            return "download file error"
        case .downloadUpdateStatus:
            return "download update status error"
        case .sendComplete:
            return "senf complete error"
        case .sendFailure:
            return "senf failure error"
        }
    }
}

enum ContentDownloadResult {
    case success
    case failure(ContentDownloadError)
}

class ContentDownloader: NSObject {

    static let `default` = ContentDownloader()

    private override init() {
        super.init()
    }
    private let requestCount = 2000
    private var completion: ((ContentDownloadResult) -> ())?
    private var fileCount: Int!
    private var partFileCount: Int!
    private var downloadedCount = 0
    private var partDownloadedCount = 0
    private var logInfos: [[String:Int]]!
    private var downloadFileInfos: [(fileId: String, fileUrl: URL)]!
    private var chunkedDownloadFileInfos: [[(fileId: String, fileUrl: URL)]]!

    func download(completion: ((ContentDownloadResult) -> ())?) {
        Utility.log("ContentDownloader.download")
        SwiftSpinner.show("")
        self.completion = completion
        if DownloadConfigure.apiKey == nil {
            downloadKey()
        } else {
            downloadMaster()
        }
    }

    func downloadUpdateStatus(completion: ((ContentDownloadResult) -> ())?) {
        Alamofire.request(Router.downloadCheck()).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["result"].intValue == 0 {
                    DownloadConfigure.isNeedUpdate = (json["modified"].intValue > 0)
                    completion?(.success)
                } else {
                    completion?(.failure(ContentDownloadError.downloadUpdateStatus))
                }
            case .failure(let error):
                completion?(.failure(ContentDownloadError.apiRequest(error)))
            }
        }
    }

    func downloadComplete(completion: @escaping (ContentDownloadResult) -> ()) {
        Alamofire.request(Router.downloadComplete()).responseJSON { response in
            switch response.result {
            case .success(let value):
                if JSON(value)["result"].string == "0" {
                    completion(.success)
                    self.unzipLXFile()
                } else {
                    completion(.failure(ContentDownloadError.sendComplete))
                }
            case .failure(let error):
                self.completion?(.failure(ContentDownloadError.apiRequest(error)))
            }
        }
    }

    func downloadError(completion: @escaping (ContentDownloadResult) -> ()) {
        Alamofire.request(Router.downloadError()).responseJSON { response in
            switch response.result {
            case .success(let value):
                if JSON(value)["result"].string == "0" {
                    completion(.success)
                } else {
                    completion(.failure(ContentDownloadError.sendFailure))
                }
            case .failure: break
            }
        }
    }

    private func downloadKey() {
        Alamofire.request(Router.downloadKey()).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let key = JSON(value)["key"].string {
                    DownloadConfigure.apiKey = key
                    self.downloadMaster()
                } else {
                    self.completion?(.failure(ContentDownloadError.downloadKey))
                }
            case .failure(let error):
                self.completion?(.failure(ContentDownloadError.apiRequest(error)))
            }
        }
    }

    private func downloadMaster() {
        Utility.log("ContentDownloader.downloadMaster")
        Alamofire.request(Router.downloadMaster()).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["result"].intValue == 0 {
                    self.saveMasterData(json: json)
                } else {
                    self.completion?(.failure(ContentDownloadError.downloadMaster))
                }

            case .failure(let error):
                self.completion?(.failure(ContentDownloadError.apiRequest(error)))
            }
        }
    }

    // マスタデータをSQLiteに保存
    private func saveMasterData(json: JSON) {
        Utility.log("ContentDownloader.saveMasterData")
        let db = ModelDatabase.getDatabase()
        if !(db.open() && db.beginTransaction()) {
            self.completion?(.failure(ContentDownloadError.dbError(db.lastError())))
            return
        }
        downloadFileInfos = []
        do {
            for (table, values) in json {
                if !table.hasPrefix("m_") {
                    continue
                }
                for (_, data) in values {
                    try insert(database: db, table: table, data: data)
                }
            }
            modifyData(database: db)
            if !db.commit() {
                throw ContentDownloadError.dbError(db.lastError())
            }
            db.close()
            self.requestContent()
        } catch {
            print("[DB Error] \(error)")
            db.rollback()
            db.close()
            completion?(.failure(ContentDownloadError.dbError(error)))
        }

    }

    private func insert(database: FMDatabase, table: String, data: JSON) throws {
        for (_, v) in data {
            var id: String?
            var content: String?
            var columns = [String]()
            var values = [String]()
            for (column, value) in v {
                columns.append(column)
                values.append(value.stringValue)
                if column == "id" {
                    id = value.string
                }
                if column == "content" {
                    content = value.string
                }
            }
            if let tid = id,
               ["m_region", "m_country", "m_master_item"].contains(table) {
                delete(database: database, table: table, tid: tid)
            }
            let c = columns.joined(separator: ", ")
            let v = columns.map { (_) -> String in "?" }.joined(separator: ", ")
            let sql = "REPLACE INTO \(table) (\(c)) VALUES (\(v))"
            if database.executeUpdate(sql, withArgumentsIn: values) {
                if let fileId = id,
                    let data = content?.data(using: String.Encoding.utf8),
                    let fileName = JSON(data: data)["file_name"].string,
                    table == "m_file" {
                    let url = FileTable.getPath(fileId: fileId, fileName: fileName)
                    let downloadFileInfo = (fileId: fileId, fileUrl: url)
                    downloadFileInfos.append(downloadFileInfo)
                }
            } else {
                throw ContentDownloadError.dbError(database.lastError())
            }
        }
    }

    private func delete(database: FMDatabase, table: String, tid: String) {
        let sql: String = "DELETE FROM \(table) WHERE id = \(tid)"
        database.executeUpdate(sql, withArgumentsIn: nil)
    }

    private func modifyData(database: FMDatabase) {
        var sql = "SELECT id, content FROM m_product"
        if let r = database.executeQuery(sql, withArgumentsIn: []) {
            while r.next() {
                let productId: Int = Utility.toInt(r.string(forColumn: "id"))

                let json = Utility.parseContent(r)
                let beautySecondId: Int = Utility.toInt(json["beauty"])
                let lineId: Int = Utility.toInt(json["line"])

                sql = "UPDATE m_product SET beauty_second_id = ?, " +
                      " line_id = ? WHERE id = ?"
                database.executeUpdate(sql, withArgumentsIn:
                                       [beautySecondId, lineId, productId])
            }
        }
    }



    private func requestContent() {
        fileCount = downloadFileInfos.count
        downloadedCount = 0
        if fileCount == 0 {
            self.completion?(.success)
            return
        }
        logInfos = [[:]]
        chunkedDownloadFileInfos = downloadFileInfos.chunk(self.requestCount)
        downloadFileInfos = nil
        self.updateDownloadPart()
    }

    private func updateDownloadPart() {
        guard let downloadFileInfos = chunkedDownloadFileInfos.first else {
            if let first = self.logInfos.first, first.isEmpty {
                self.logInfos.removeFirst()
            }
            LogManager.sendApiFileLog(fileInfos: self.logInfos)
            self.completion?(.success)
            return
        }

        partFileCount = downloadFileInfos.count
        partDownloadedCount = 0

        downloadFileInfos.forEach { (fileId: String, fileUrl: URL) in
            self.downloadFile(fileId: fileId, fileUrl: fileUrl)
        }
    }

    private func downloadFile(fileId: String, fileUrl: URL) {
        Alamofire.request(Router.downloadFile(fileId: fileId)).responseData { response in
            let closure: (_ logInfo: [String:Int]) -> () = { logInfo in
                self.downloadedCount += 1
                self.partDownloadedCount += 1

                let progress = Double(self.downloadedCount) / Double(self.fileCount)
                let ceiled = Double(Int(progress * 100.0)) / 100.0
                SwiftSpinner.show(progress: ceiled, title: "DownloadFile...\n\(Int(ceiled * 100))%")

                print("fileId: \(logInfo["fileId"]) is Complete")
                self.logInfos.append(logInfo)

                if self.partDownloadedCount == self.partFileCount {
                    self.chunkedDownloadFileInfos.removeFirst()
                    self.updateDownloadPart()
                }
            }

            var logInfo = [String:Int]()
            logInfo["fileId"] = Int(fileId)
            logInfo["status"] = 1
            logInfo["length"] = 0
            logInfo["httpStatus"] = response.response!.statusCode

            if response.result.isFailure {
                closure(logInfo)
                return
            }
            do {
                //BOMを取り除く
                let bomLength = 3
                guard let data = response.result.value else {
                    closure(logInfo)
                    return
                }

                logInfo["length"] = data.count

                if data.count == bomLength {
                    closure(logInfo)
                    return
                }

                let refinedData = data.subdata(in: bomLength..<data.count)

                FileTable.makeImageDirIfNeeded(fileId: fileId)
                try refinedData.write(to: fileUrl, options: .atomic)
                logInfo["status"] = 0
                closure(logInfo)
            } catch let error as NSError {
                // エラー処理
                print(error.localizedDescription)
                closure(logInfo)
            }
        }
    }
    private func unzipLXFile() {
        
        let movieFilePathStr = NSHomeDirectory() + "/Documents/lx_movie"
        let manager = FileManager()
        if manager.fileExists(atPath: movieFilePathStr) {
            do {
                let filePath: URL = URL.init(string: movieFilePathStr)!
                print(filePath)
                try manager.removeItem(at: filePath)
            } catch let e {
                print(e)
            }
        }

        let movieFileUrl: URL = FileTable.getPath(6073)
        print(movieFileUrl)
        do {
            let destinationURL = try Zip.quickUnzipFile(movieFileUrl)
            print(destinationURL)
        } catch let e {
            print(e)
        }
        
        let gscMovieFileUrl: URL = FileTable.getPath(6260)
        print(gscMovieFileUrl)
        do {
            let destinationURL = try Zip.quickUnzipFile(gscMovieFileUrl)
            print(destinationURL)
        } catch let e {
            print(e)
        }
        
        let imageFilePathStr = NSHomeDirectory() + "/Documents/lx_app"
        if manager.fileExists(atPath: imageFilePathStr) {
            do {
                let filePath: URL = URL.init(string: imageFilePathStr)!
                print(filePath)
                try manager.removeItem(at: filePath)
            } catch let e {
                print(e)
            }
        }
        
        let imageFileUrl: URL = FileTable.getPath(6074)
        print(imageFileUrl)
        do {
            let destinationURL = try Zip.quickUnzipFile(imageFileUrl)
            print(destinationURL)
        } catch let e {
            print(e)
        }
        
        let csvFilePathStr = NSHomeDirectory() + "/Documents/lx_csv"
        if manager.fileExists(atPath: csvFilePathStr) {
            do {
                let filePath: URL = URL.init(string: csvFilePathStr)!
                print(filePath)
                try manager.removeItem(at: filePath)
            } catch let e {
                print(e)
            }
        }
        
        let csvFileUrl: URL = FileTable.getPath(6092)
        print(csvFileUrl)
        do {
            let destinationURL = try Zip.quickUnzipFile(csvFileUrl)
            print(destinationURL)
            let languageCode = LanguageTable.getEntity(LanguageConfigure.languageId)
            let filePath = String(format: "file://%@/Documents/lx_csv/lx_csv/%@lx.csv", NSHomeDirectory(), languageCode.code)
            let csv = Utility.csvToArray(file: filePath)
            LanguageConfigure.lxcsv = csv
            
        } catch let e {
            print(e)
        }
        
        let gscCsvFileUrl: URL = FileTable.getPath(6275)
        print(csvFileUrl)
        do {
            let destinationURL = try Zip.quickUnzipFile(gscCsvFileUrl)
            print(destinationURL)
            let languageCode = LanguageTable.getEntity(LanguageConfigure.languageId)
            let filePath = String(format: "file://%@/Documents/gsc_csv/gsc_csv/%@gsc.csv", NSHomeDirectory(), languageCode.code)
            
//              let filePath = String(format: "file://%@/Documents/gsc_csv/gsc_csv/000000gsc.csv", NSHomeDirectory())
            let csv = Utility.csvToArray(file: filePath)
            LanguageConfigure.gsccsv = csv
            
        } catch let e {
            print(e)
        }
        
        let gscPlistFileUrl: URL = FileTable.getPath(6299)
        print(csvFileUrl)
        do {
            let destinationURL = try Zip.quickUnzipFile(gscPlistFileUrl)
            print(destinationURL)
            
            let gscGroupingPlistPath = String(format: "%@/Documents/gsc_plist/gsc_plist/s_grouping.plist", NSHomeDirectory())
            
            let countryCode = CountryTable.getEntity(LanguageConfigure.countryId)
            
            if let groupingDic = NSDictionary.init(contentsOfFile: gscGroupingPlistPath) as? Dictionary<String, AnyObject> {
                let group = groupingDic[String(countryCode.code)] as? String ?? "A"
                LanguageConfigure.gscgroup = group
            } else {
                LanguageConfigure.gscgroup = "A"
            }
            
            print(LanguageConfigure.gscgroup)
            let gscFilePath = String(format: "%@/Documents/gsc_plist/gsc_plist/suncare_%@.plist", NSHomeDirectory(), LanguageConfigure.gscgroup)
            print(gscFilePath)

            if let dataDic = NSDictionary(contentsOfFile: gscFilePath) as? Dictionary<String, AnyObject> {
                print(dataDic)
                LanguageConfigure.gscplist = dataDic
            }
            
        } catch let e {
            print(e)
        }
        
    }
}
