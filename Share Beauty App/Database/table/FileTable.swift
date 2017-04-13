//
//  StepUpperTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import APNGKit

class FileTable: NSObject {

    static let imageDirPath = NSHomeDirectory() + "/Library/Caches/images/"

    class func getEntity(_ fileId: Int) -> FileEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_file WHERE id = ? ", withArgumentsIn: [fileId])
        let entity: FileEntity = FileEntity()

        if resultSet.next() {

            entity.fileId = fileId

            //content
            let json = Utility.parseContent(resultSet)
            entity.fileName = Utility.toStr(json["file_name"])

            let relationLanguage: NSArray = json["relation_language"] as! NSArray
            for value in relationLanguage {
                entity.relationLanguage.append(value as! Int)
            }

            let relationMaster: NSArray = json["relation_master"] as! NSArray
            for value in relationMaster {
                entity.relationMaster.append(value as! Int)
            }

            entity.remarks = Utility.toStr(json["remarks"])

            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }
    //指定されたファイル(リソース内)をDocumentにコピーする
    class func getPath(_ fileId: Int) -> URL {
        return getPath(fileId: String(fileId), fileName: self.getEntity(fileId).fileName)
    }

    class func getPath(fileId: String, fileName: String) -> URL {
        let path = imageDirPath + "\(fileId)/\(fileName)"
        return URL(fileURLWithPath: path)
    }

    class func getImage(_ fileId: Int?) -> UIImage? {
        if fileId == nil {
            return nil
        }
        if let data = try? Data(contentsOf: self.getPath(fileId!)) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }

    class func getVideoUrl(_ fileId: Int?) -> URL? {
        if fileId == nil { return nil }
        return self.getPath(fileId!)
    }

    class func getAImage(_ fileId: Int?) -> APNGImage? {
        if fileId == nil {
            return nil
        }
        if let data = try? Data(contentsOf: self.getPath(fileId!)) {
            return APNGImage(data: data, progressive: true)
        } else {
            return nil
        }
    }

    class func getCsv(fileId: Int) -> NSMutableArray? {
        let fm = FileManager.default
        let url = self.getPath(fileId)

        if !fm.fileExists(atPath: url.path), !(url.pathExtension == "csv") { return nil }
        do {
            let csv = try String(contentsOf: url, encoding: .utf8)
            let array = csv.components(separatedBy: "\n")

            var isTextEnded = true
            var result = [String]()
            array.forEach({ strLine in
                var edited = strLine.pregReplace(pattern: "^\\d+.", with: "")

                let before = edited
                edited = edited.replacingOccurrences(of: "\"", with: "")

                let hasOneQuate = before.count - edited.count == 1
                if isTextEnded {
                    result.append(edited)
                    isTextEnded = !hasOneQuate
                } else {
                    result[result.endIndex-1] += "\n" + edited
                    isTextEnded = hasOneQuate
                }
            })
            return NSMutableArray(array: result)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    class func makeImageDirIfNeeded(fileId: String) {
        let fm = FileManager.default
        let path = imageDirPath + fileId
        if !fm.fileExists(atPath: path) {
            do {
                try fm.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    class func getLXFileImage(_ fileName: String?) -> UIImage? {
        if fileName == nil {
            return nil
        }
        let filePath: URL = URL.init(string: String(format: "file://%@/Documents/lx_app/lx_app/%@", NSHomeDirectory(), fileName!))!
        print("\(filePath)")
        if let data = try? Data(contentsOf: filePath) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
    class func getLXFileAImage(_ fileName: String?) -> APNGImage? {
        if fileName == nil {
            return nil
        }
        let filePath: URL = URL.init(string: String(format: "file://%@/Documents/lx_app/lx_app/%@", NSHomeDirectory(), fileName!))!
        print("\(filePath)")
        if let data = try? Data(contentsOf: filePath) {
            return APNGImage(data: data, progressive: true)
        } else {
            return nil
        }
    }
}
