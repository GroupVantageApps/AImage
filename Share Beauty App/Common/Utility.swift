//
//  Utility.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/08.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import SystemConfiguration
import SwiftyJSON

class Utility: NSObject {

    //指定されたファイル名のフルパスを取得する（Document内）
    class func getDocumentPath(_ fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)

        return fileURL.path
    }

    /*
    //レコメンド配列の取得
    class func getRecommend() -> [Int]? {
        let userDefault = UserDefaults.standard
        var recommend = userDefault.object(forKey: "recommend") as? [Int]
        if recommend == nil {
            recommend = []
            userDefault.set(recommend, forKey:"recommend")
            userDefault.synchronize()
        }
        return recommend!
    }
    //指定商品IDをレコメンド配列に追加
    class func setRecommend(_ productId: Int) {
        let userDefault = UserDefaults.standard
        var recommend = self.getRecommend()

        var hitFlg = 0
        for recommendId in recommend! {
            if recommendId == productId {
                hitFlg = 1
            }
        }
        if hitFlg == 0 {
            recommend?.append(productId)
            userDefault.set(recommend, forKey:"recommend")
            userDefault.synchronize()
        }
    }
    //指定商品IDをレコメンド配列から削除
    class func removeRecommend(_ productId: Int) {
        let userDefault = UserDefaults.standard
        let recommend = self.getRecommend()
        var newRecommend: [Int] = []

        var hitFlg = 0
        for recommendId in recommend! {
            if recommendId == productId {
                hitFlg = 1
            } else {
                newRecommend.append(recommendId)
            }
        }
        if hitFlg == 1 {
            userDefault.set(newRecommend, forKey:"recommend")
            userDefault.synchronize()
        }
    }
    //全商品IDをレコメンド配列から削除
    class func clearRecommend() {
        let userDefault = UserDefaults.standard
        userDefault.set([], forKey:"recommend")
        userDefault.synchronize()
    }*/

    //resultSet内のcontentのJSONのパース結果を返す
    class func parseContent(_ resultSet: FMResultSet, key: String = "content") -> NSDictionary {
        let jsonString = resultSet.string(forColumn: key).replacingOccurrences(of: ":null,", with: ":0,").replacingOccurrences(of: ":null}", with: ":0}")
        return Utility.jsonObject(jsonString: jsonString)!
    }

    class func getJsonContent(_ resultSet: FMResultSet) -> JSON? {
        let jsonString = resultSet.string(forColumn: "content").replacingOccurrences(of: ":null,", with: ":0,").replacingOccurrences(of: ":null}", with: ":0}")
        if let data = jsonString.data(using: String.Encoding.utf8) {
            return JSON(data: data)
        } else {
            return nil
        }
    }

    class func jsonObject(jsonString: String) -> NSDictionary? {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }

        do {
            return try JSONSerialization
              .jsonObject(with: data, options: .allowFragments) as? NSDictionary
        } catch {
            print("error serializing JSON: \(error)")
        }
        return nil
    }

    //OnTrendのitems["03"]で使用
    class func parseJson(_ item: String) -> JSON? {
        let string = item.replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "&quot;", with: "\"")

        if let data = string.data(using: String.Encoding.utf8) {
            return JSON(data: data)
        } else {
            return nil
        }
    }

    //JSONのパース結果の値をIntに変換する
    static func toInt(_ value: Any?) -> Int {
        var num: Int = 0
        if value is Int {
            num = value as! Int
        } else {
            let str: String = value as! String
            if str != "" {
				if let strValue = Int(str) {
					num = strValue
				}
            }
        }
        return num
    }
    //JSONのパース結果の値をIntに変換する
    static func toStr(_ value: Any?) -> String {
        return value as! String
    }
	//JSONのパース結果の値をDoubleに変換する
	static func toDouble(_ value: Any?) -> Double {
		if let value = value as? Double {
			return value
		} else if let value = value as? String {
			return atof(value)
		} else {
			return 0.0
		}
	}

    //オンラインチェック
    static func checkOnline() -> Bool {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "google.com")!
        var flags = SCNetworkReachabilityFlags.connectionAutomatic
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    //ログ出力
    static func log(_ message: Any?) {
        #if DEBUG
            print(message!)
        #endif
    }
    static func debugInfo(_ message: AnyObject, function: String = #function, file: String = #file, line: Int = #line) {
        #if DEBUG
            var str = "\(message)\n-- FileName: \(file)\n-- Method: \(function)\n-- Line: \(line)"
            str = str.replacingOccurrences(of: "\n", with: "\n  ")
            print("\n*** \(str)\n", terminator: "")
        #endif
    }

    class func isIconicProduct(productId: Int) -> Bool {
        let iconicProducts = ProductListData(screenId: Const.screenIdIconicBeauty).products
        let iconicProductIds = iconicProducts.map {$0.productId}
        return iconicProductIds.contains(productId)
    }

    class func isOnTrendProduct(productId: Int) -> Bool {
        let onTrendProducts = ProductListData(screenId: Const.screenIdOnTrendBeauty).products
        let onTrendProductIds = onTrendProducts.map {$0.productId}
        return onTrendProductIds.contains(productId)
    }

    class func getLifeStyleScreenIds(productId: Int) -> [Int]? {
        var results = [Int]()
        var tuples = [(screenId: Int, productIds: [Int])]()

        let lifeStyleProductsA = ProductListData(screenId: Const.screenIdLifeStyleBeautyA).products
        let lifeStyleProductsB = ProductListData(screenId: Const.screenIdLifeStyleBeautyB).products
        let lifeStyleProductsC = ProductListData(screenId: Const.screenIdLifeStyleBeautyC).products
        let lifeStyleProductsD = ProductListData(screenId: Const.screenIdLifeStyleBeautyD).products

        tuples.append((screenId: Const.screenIdLifeStyleBeautyA, productIds: lifeStyleProductsA.map {$0.productId}))
        tuples.append((screenId: Const.screenIdLifeStyleBeautyB, productIds: lifeStyleProductsB.map {$0.productId}))
        tuples.append((screenId: Const.screenIdLifeStyleBeautyC, productIds: lifeStyleProductsC.map {$0.productId}))
        tuples.append((screenId: Const.screenIdLifeStyleBeautyD, productIds: lifeStyleProductsD.map {$0.productId}))

        for tuple in tuples {
            if tuple.productIds.contains(productId) {
                results.append(tuple.screenId)
            }
        }

        if results.count != 0 {
            return results
        } else {
            return nil
        }
    }

    class func parseArrayString(_ item: String) -> [Int] {
        var strItems = item.components(separatedBy: CharacterSet(charactersIn: "[, ]"))
        strItems = strItems.filter {$0 != ""}
        return strItems.map {Int($0)!}
    }
    class func csvToArray (file: String ) -> [String : String]{
        var result: [String : String] = [:]
        let filePath: URL = URL.init(string: file)!
        if let data = try? Data(contentsOf: filePath) {
                let csvStr = String(data: data, encoding: .utf8)
                var index = ""
                var value = ""
                var isStartDC = true
                csvStr?.enumerateLines { (line, stop) -> () in
                    let count = Utility.numberOfOccurrences(of: "\"", string: line)
                    
                    if count == 2 {
                        let string = NSString(string: line)
                        let range = string.range(of: ",")
                        index = string.substring(to: range.location)
                        value = string.substring(from: range.location + 1)
                        value = value.replacingOccurrences(of: "\"", with: "")
                        
                    } else if count == 1 {
                        if isStartDC {
                            let string = NSString(string: line)
                            let range = string.range(of: ",") 
                            index = string.substring(to: range.location)
                            value = string.substring(from: range.location + 1)
                            value = value.replacingOccurrences(of: "\"", with: "")
                            isStartDC = false
                        } else {
                            let replacedLine = line.replacingOccurrences(of: "\"", with: "")
                            value = String(format: "%@\n%@",value,replacedLine)
                            isStartDC = true
                        }
                    } else if count == 0 {
                        if isStartDC {
                            let string = NSString(string: line)
                            let range = string.range(of: ",")
                            print("range.location \(range.location)")
                            if string.length >= range.location {
                                index = string.substring(to: range.location)
                                value = string.substring(from: range.location + 1)
                                value = value.replacingOccurrences(of: "\"", with: "")
                            }
                        } else {
                            value = String(format: "%@\n%@",value,line)
                        }
                    }
                    
                    if isStartDC {
                        print("-----------------")
                        print("No." + index)
                        print(value)
                        result[index] = value
                    }
                }
                
                print(result.count)

        }
        
        return result
    }
    class func numberOfOccurrences(of word: String, string: String) -> Int {
        var count = 0
        var nextRange = string.startIndex..<string.endIndex
        while let range = string.range(of: word, options: .caseInsensitive, range: nextRange) {
            count += 1
            nextRange = range.upperBound..<string.endIndex
        }
        return count
    }
    class func checkReachability()->Bool{
        
        let reachability = SCNetworkReachabilityCreateWithName(nil, "google.com")!
        var flags = SCNetworkReachabilityFlags.connectionAutomatic
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
