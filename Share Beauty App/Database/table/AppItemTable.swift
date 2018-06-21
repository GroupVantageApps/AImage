//
//  StepUpperTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class AppItemTable: NSObject {

    class func getEntity(_ appItemId: Int) -> AppItemEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_app_item WHERE id = ? ", withArgumentsIn: [appItemId])
        let entity: AppItemEntity = AppItemEntity()

        if resultSet.next() {

            entity.appItemId = appItemId
            entity.appScreenId = Utility.toInt(resultSet.string(forColumn: "app_screen_id"))

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])
            entity.itemName = Utility.toStr(json["item_name"])

            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }

    //画面ID（4桁文字列）から、項目毎のテキストを返す
    class func getItemsByScreenCode(_ screenCode: String) -> [String: String] {
        let sql: String =
            "SELECT " +
                "t1.content AS content1 " +
                ",t2.content AS content2 " +
                "FROM m_app_item AS t1,  m_app_item_translate AS t2 " +
                "WHERE " +
                "t1.id = t2.app_item_id " +
                "AND t2.language_id = ? " +
                "AND t1.content LIKE '%\"code\":\"" + screenCode + "%' "

        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [languageId!])

        var items: [String: String] = [:]

        while resultSet.next() {
            let json1 = Utility.parseContent(resultSet, key: "content1")
            let code: String = Utility.toStr(json1["code"])

            let json2 = Utility.parseContent(resultSet, key: "content2")
            var name: String = Utility.toStr(json2["name"])
            name = name.replacingOccurrences(of: "&lt;", with: "<")
                .replacingOccurrences(of: "&gt;", with: ">")
                .replacingOccurrences(of: "\\&quot;", with: "\"")

            var indexStr: String = code.replacingOccurrences(of: screenCode, with: "")
            //let index: Int = Int(indexStr)!
            if indexStr == "" {
                indexStr = "0"
            }
            items[indexStr] = name
        }

        return items
    }

    //画面IDから、項目毎のテキストを返す
    class func getItems(screenId: Int) -> [String: String] {
        let sql: String =
            "SELECT " +
                "t1.content AS content1 " +
                ",t2.content AS content2 " +
                "FROM m_app_item AS t1,  m_app_item_translate AS t2 " +
                "WHERE " +
                "t1.id = t2.app_item_id " +
                "AND t1.app_screen_id = ? " +
        "AND t2.language_id = ? "

        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [screenId, languageId!])

        var items: [String: String] = [:]

        while resultSet.next() {
            let json1 = Utility.parseContent(resultSet, key: "content1")
            let code: String = Utility.toStr(json1["code"])

            let json2 = Utility.parseContent(resultSet, key: "content2")
            var name: String = Utility.toStr(json2["name"])
            name = name.replacingOccurrences(of: "&lt;", with: "<")
                .replacingOccurrences(of: "&gt;", with: ">")
                .replacingOccurrences(of: "\\&quot;", with: "\"")

            let indexStr: String = code.substring(from: code.index(code.endIndex, offsetBy: -2))
            //let index: Int = Int(indexStr)!
            items[indexStr] = name
        }
        return items
    }


    class func getJsonByItemCode(itemCode: String) -> JSON? {
        return getJsonByItemId(itemId: self.getIdByItemCode(itemCode))
    }

    class func getJsonByItemId(itemId: Int) -> JSON? {
        let sql: String =
        "SELECT t1.content AS content1 ,t2.content AS content2 FROM m_app_item AS t1, m_app_item_translate AS t2 WHERE t1.id = t2.app_item_id AND t2.language_id = ? AND t2.app_item_id = ?"

        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [languageId!, itemId])

        while resultSet.next() {
            let json = resultSet.string(forColumn: "content2")
            return Utility.parseJson(json!)!
        }
        return nil
    }

    class func getNameByItemId(itemId: Int) -> String? {
        let sql: String =
        "SELECT t1.content AS content1 ,t2.content AS content2 FROM m_app_item AS t1, m_app_item_translate AS t2 WHERE t1.id = t2.app_item_id AND t2.language_id = ? AND t2.app_item_id = ?"

        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [languageId!, itemId])

        while resultSet.next() {
            let json = resultSet.string(forColumn: "content2")            
            return Utility.parseJson(json!)?.dictionary?["name"]?.string
        }
        return nil
    }

    class func getMainImageByItemId(itemId: Int) -> [Int] {
        let sql: String =
        "SELECT t1.content AS content1 ,t2.content AS content2 FROM m_app_item AS t1, m_app_item_translate AS t2 WHERE t1.id = t2.app_item_id AND t2.language_id = ? AND t2.app_item_id = ?"

        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [languageId!, itemId])

        while resultSet.next() {
            let json = resultSet.string(forColumn: "content2")
            if let mainImages = Utility.parseJson(json!)?.dictionary?["image"]?.array?.first?["main_image"].arrayObject as? [Int] {
                return mainImages
            }
        }
        return []
    }

    class func getSeekByItemId(itemId: Int) -> Float64 {
        let sql: String = "SELECT content FROM m_app_item WHERE id = ?"
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [itemId])

        while resultSet.next() {
            let json = resultSet.string(forColumn: "content")
            guard let str = Utility.parseJson(json!)?.dictionary?["item_name"]?.string else {
                return 0
            }
            return Float64(str.pregReplace(pattern: "STEP\\d.seek:", with: ""))!
        }
        return 0
    }

    //項目ID（6桁文字列）から、m_app_item.id を返す
    class func getIdByItemCode(_ itemCode: String) -> Int {
        let database = ModelDatabase.getDatabase()
        database.open()
        let sql: String = "SELECT id FROM m_app_item WHERE content LIKE '%\"code\":\"\(itemCode)\"%'"
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])
        
        var id: Int = 0
        
        while resultSet.next() {
            id = Utility.toInt(resultSet.string(forColumn: "id"))
        }
        
        return id
    }
}
