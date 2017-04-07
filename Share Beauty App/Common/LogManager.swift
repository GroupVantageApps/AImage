//
//  LogManager.swift
//  Share Beauty App
//
//  Created by koji on 2016/11/19.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LogManager: NSObject {

    enum LogRouter: URLRequestConvertible {
        case apifile(json: String)

        static let baseURLString = "https://nscp-ga.heteml.jp/sab"
        static let timeOut: TimeInterval = 30

        var method: HTTPMethod {
            switch self {
            case .apifile:
                return .post
            }
        }

        var path: String {
            switch self {
            case .apifile:
                return "/appdebuglog.php"
            }
        }

        // MARK: URLRequestConvertible
        func asURLRequest() throws -> URLRequest {
            let url = try LogRouter.baseURLString.asURL()

            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
            urlRequest.timeoutInterval = LogRouter.timeOut

            let uuid = UIDevice.current.identifierForVendor?.uuidString

            switch self {
            case .apifile(let json):
                //                let params = ["uuid": uuid, "type": "apiFile", "json": json]
                let str = "uuid=" + uuid! + "&type=" + "apiFile" + "&json=" + json
                let strData = str.data(using: String.Encoding.utf8)
                urlRequest.httpBody = strData
                break
            }

            return urlRequest
        }
    }

    class func tapItem(screenCode: String, itemId: String) {

        var value: DBInsertValueLog = DBInsertValueLog()
        value.screen = screenCode
        value.action = Const.logActionTapItem
        value.item = itemId

        LogTable.insert(value)
    }

    class func tapProduct(screenCode: String, productId: Int) {
        var value: DBInsertValueLog = DBInsertValueLog()
        value.screen = screenCode
        value.action = Const.logActionTapProduct
        value.product = productId
        LogTable.insert(value)
    }

    class func sendLog() {

        let log = LogTable.total()
        var json: String = ""

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: log, options: [])
            json = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        } catch {
            print("Error!: \(error)")
        }

        let uuid = UIDevice.current.identifierForVendor?.uuidString

        let str = "uuid=" + uuid! + "&json=" + json
        let strData = str.data(using: String.Encoding.utf8)

        let url = NSURL(string: Const.apiSendLog)
        let request = NSMutableURLRequest(url: url! as URL)

        request.httpMethod = "POST"
        request.httpBody = strData
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 30.0

        var response: URLResponse?

        do {
            let data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
            let myData: NSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
            print(myData)

        } catch (let e) {
            print(e)

        }
    }

    class func sendApiFileLog(fileInfos: [[String:Int]]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: Date())

        let dic = [
            "date": date,
            "apiKey": DownloadConfigure.apiKey!,
            "target": DownloadConfigure.target.name,
            "countryId": LanguageConfigure.countryId,
            "file": fileInfos,
            ] as [String : Any]
        var json: String = ""

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
            json = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        } catch {
            print("Error!: \(error)")
        }
        Alamofire.request(LogRouter.apifile(json: json)).responseString {response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
}
