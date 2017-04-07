//
//  ProductTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ProductTranslateTable: NSObject {

    class func getEntity(_ productId: Int) -> ProductTranslateEntity {
        let database = ModelDatabase.getDatabase()
        let languageId: Int? = LanguageConfigure.languageId
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_product_translate WHERE product_id = ? AND language_id = ?", withArgumentsIn: [productId, languageId!])
        let entity: ProductTranslateEntity = ProductTranslateEntity()

        if resultSet.next() {

            entity.productId = productId
            entity.languageId = languageId

            entity.productTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            let json = Utility.parseContent(resultSet)

            entity.name = Utility.toStr(json["name"])
            entity.image = Utility.toInt(json["image"])
            entity.feature = Utility.toStr(json["feature"])
            entity.paInfo = Utility.toStr(json["pa"])
            entity.spf = Utility.toStr(json["spf"])
            entity.uva = Utility.toStr(json["uva"])
            entity.howToUse = Utility.toStr(json["how_to_use"])
            entity.defaultDisplay = Utility.toInt(json["default_display"])
            entity.duration = Utility.toStr(json["duration"])
            entity.price = Utility.toStr(json["price"])
            entity.awardIcon = Utility.toInt(json["award_icon"])

            let usageImage: NSArray = json["usage_image"] as! NSArray
            for value in usageImage {
                entity.usageImage.append(value as! Int)
            }

            let effectImage: NSArray = json["effect_image"] as! NSArray
            for value in effectImage {
                entity.effectImage.append(value as! Int)
            }

            let technologyImage: NSArray = json["technology_image"] as! NSArray
            for value in technologyImage {
                entity.technologyImage.append(value as! Int)
            }

//確認            entity.recommendItem = Utility.toInt(json["recommend_item"])
            entity.movie = Utility.toInt(json["movie"])

            let utmImage: NSArray = json["utm_image"] as! NSArray
            for value in utmImage {
                entity.utmImage.append(value as! Int)
            }

            let selectGcode: NSArray = json["select_gcode"] as! NSArray
            for value in selectGcode {
                entity.selectGcode.append(value as! Int)
            }

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }

    class func sortIds(_ ids: [Int]) -> [Int] {
        let database = ModelDatabase.getDatabase()
        let languageId: Int? = LanguageConfigure.languageId
        database.open()

        let sql: String = "SELECT product_id FROM m_product_translate WHERE language_id = ? AND product_id IN (" +
            ids.map({String($0)}).joined(separator: ", ") +
            ") ORDER BY  display_order "

        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [languageId!])

        var sortIds: [Int] = []

        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "product_id"))
            sortIds.append(productId)
        }

        return sortIds
    }

    class func changeDefaultDisplay(_ productId: Int, isDisplay: Int) {
        let database = ModelDatabase.getDatabase()
        let languageId: Int? = LanguageConfigure.languageId
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_product_translate WHERE product_id = ? AND language_id = ?", withArgumentsIn: [productId, languageId!])
        if resultSet.next() {
            if var json = Utility.getJsonContent(resultSet) {
                json["default_display"].int = isDisplay
                let jsonString = json.rawString()!
                    .replacingOccurrences(of: ":0,", with: ":null,")
                    .replacingOccurrences(of: ":0}", with: ":null}")
                database.executeUpdate("UPDATE m_product_translate SET content = ? WHERE product_id = ? AND language_id = ?", withArgumentsIn: [jsonString, productId, languageId!])
            }
        }
        database.close()
    }
}
