//
//  ProductTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ProductTable: NSObject {

    class func getEntity(_ productId: Int) -> ProductEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_product WHERE id = ? ", withArgumentsIn: [productId])
        let entity: ProductEntity = ProductEntity()

        if resultSet.next() {

            entity.productId = productId

            let json = Utility.parseContent(resultSet)
            var element: NSDictionary

            entity.lineId = Utility.toInt(json["line"])
            entity.season = Utility.toStr(json["season"])
            entity.beautyId = Utility.toInt(json["beauty"])
            entity.region = Utility.toStr(json["region"])
            entity.amountImageId = Utility.toInt(json["amount_image"])
            entity.colorballPoolCode = Utility.toStr(json["colorball_pool_code"])
            entity.finderDisplayFlg = Utility.toInt(json["finder_display_flg"])
            if let backImage = (json["back_image"] as! [Int])[safe: 0] {
                entity.backImage = backImage
            }
			entity.backImage2 = Utility.toInt(json["back_image_2"])
            entity.newItemFlg = Utility.toInt(json["new_item"])
            if let spMovies = json["sp_movie"] as? [Int] {
                entity.spMovies = spMovies
            }
            element = json["finish"] as! NSDictionary
            entity.finish.matteFlg = Utility.toInt(element["finish_matte_flag"])
            entity.finish.mediumFlg = Utility.toInt(element["finish_medium_flag"])
            entity.finish.lustrousFlg = Utility.toInt(element["finish_lustrous_flag"])

            element = json["cover"] as! NSDictionary
            entity.cover.lightFlg = Utility.toInt(element["cover_light_flag"])
            entity.cover.mediumFlg = Utility.toInt(element["cover_medium_flag"])
            entity.cover.fullFlg = Utility.toInt(element["cover_full_flag"])

            element = json["point_of_use"] as! NSDictionary
            entity.pointOfUse.forFace = Utility.toInt(element["for_face"])
            entity.pointOfUse.forEyes = Utility.toInt(element["for_eyes"])
            entity.pointOfUse.forLips = Utility.toInt(element["for_lips"])
            entity.pointOfUse.forNeckDecolletage = Utility.toInt(element["for_neck_decolletage"])
            entity.pointOfUse.forBody = Utility.toInt(element["for_body"])
            entity.pointOfUse.forHand = Utility.toInt(element["for_hand"])
            entity.pointOfUse.forHair = Utility.toInt(element["for_hair"])
            entity.pointOfUse.others = Utility.toInt(element["others"])

            element = json["opportunity"] as! NSDictionary
            entity.opportunity.dayNight = Utility.toInt(element["day_night"])
            entity.opportunity.day = Utility.toInt(element["day"])
            entity.opportunity.night = Utility.toInt(element["night"])

            element = json["condition"] as! NSDictionary
            entity.condition.oily = Utility.toInt(element["oily"])
            entity.condition.normal = Utility.toInt(element["normal"])
            entity.condition.dry = Utility.toInt(element["dry"])
            entity.condition.oilyWithDrySurface = Utility.toInt(element["oily_with_dry_surface"])

            let concern: NSArray = json["concern"] as! NSArray
            for value in concern {
                let data: NSDictionary = value as! NSDictionary
                var concernData = DBStructConcern()
                concernData.troubleId = Utility.toInt(data["trouble"])
                concernData.displayType = Utility.toInt(data["display_type"])
                entity.concern.append(concernData)
            }
			
			entity.makeupLook = Utility.toInt(json["makeup_look"]) > 0
			if let makeupLookImages = json["makeup_look_image"] as? [Int] {
				entity.makeupLookImages = makeupLookImages
			}
            
            if let testure = json["testure"] as? String {
                entity.texture = Utility.toStr(testure)
            }
        }

        database.close()
        return entity
    }

    class func getSpecialItemList(_ specialItemLineId: Int) -> [Int] {
        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "SELECT id FROM m_product WHERE content LIKE '%\"line\":\"" + specialItemLineId.description + "\"%'"
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])

        var productIds: [Int] = []

        while resultSet.next() {
            productIds.append(Utility.toInt(resultSet.string(forColumn: "id")))
        }

        return productIds
    }

    class func getProductIdsByLineId(_ lineId: Int) -> [Int] {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT id FROM m_product WHERE line_id = ? ORDER BY beauty_second_id ", withArgumentsIn: [lineId])

        var productIds: [Int] = []

        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "id"))
            productIds.append(productId)
        }

        return productIds
    }
    class func getProductIdsByLineIdOrderByDisplayOrder(_ lineId: Int) -> [Int] {
        let database = ModelDatabase.getDatabase()
        let languageId: Int? = LanguageConfigure.languageId
        database.open()
        let resultSet: FMResultSet! = database.executeQuery(
            "SELECT t1.id FROM m_product AS t1, m_product_translate AS t2 " +
            " WHERE t1.line_id = ? AND t2.language_id = ? AND t1.id = t2.product_id " +
            " ORDER BY t2.display_order ",
            withArgumentsIn: [lineId, languageId!])
        
        var productIds: [Int] = []
        
        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "id"))
            productIds.append(productId)
        }
        
        return productIds
    }
    class func getProductIdsBy(productIds: String?, beautyIds: String?, lineIds: String?) -> [Int] {

        let database = ModelDatabase.getDatabase()
        database.open()

        var didApplyFilter = false
        var sql = "SELECT id FROM m_product "
        var arguments = [String]()

        if !(productIds == nil && beautyIds == nil && lineIds == nil) {
            sql += "WHERE "
        }

        if productIds != nil {
            let separated = productIds?.components(separatedBy: ",")
            sql += self.makeFliterQuery(key: "id", valueCount: separated!.count, hasAnd: didApplyFilter)
            didApplyFilter = true
            arguments += separated!
        }

        if beautyIds != nil {
            let separated = beautyIds?.components(separatedBy: ",")
            sql += self.makeFliterQuery(key: "beauty_second_id", valueCount: separated!.count, hasAnd: didApplyFilter)
            didApplyFilter = true
            arguments += separated!
        }

        if lineIds != nil {
            let separated = lineIds?.components(separatedBy: ",")
            sql += self.makeFliterQuery(key: "line_id", valueCount: separated!.count, hasAnd: didApplyFilter)
            didApplyFilter = true
            arguments += separated!
        }

        sql += "ORDER BY beauty_second_id "

        print("======================================================================")
        print(sql)
        print("======================================================================")


        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: arguments)
        var productIds: [Int] = []

        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "id"))
            productIds.append(productId)
        }

        return productIds
    }

    class func sortIdsByBeautySecond(_ ids: [Int]) -> [Int] {
        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "SELECT id FROM m_product WHERE id IN (" +
            ids.map({String($0)}).joined(separator: ", ") +
        ") ORDER BY  line_id, beauty_second_id "

        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])

        var sortIds: [Int] = []

        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "id"))
            sortIds.append(productId)
        }

        return sortIds
    }

    class private func makeFliterQuery(key: String, valueCount: Int, hasAnd: Bool) -> String {
        var resultSql = ""
        if hasAnd {
            resultSql += "AND "
        }
        resultSql += "\(key) IN ("
        (0..<valueCount).forEach { i in
            if i == 0 {
                resultSql += "?"
            } else {
                resultSql += ", ?"
            }
        }
        resultSql += ") "
        return resultSql
    }
    
}
