//
//  LineTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LineTranslateTable: NSObject {

    class func getEntity(_ lineId: Int) -> LineTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_line_translate WHERE line_id = ? AND language_id = ?", withArgumentsIn: [lineId, languageId!])
        let entity: LineTranslateEntity = LineTranslateEntity()

        if resultSet.next() {

            entity.lineId = lineId
            entity.languageId = languageId

            entity.lineTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            //Utility.log(resultSet.string(forColumn: "content"))
            let json = Utility.parseContent(resultSet)
            entity.name = Utility.toStr(json["name"])
            entity.subTitle = Utility.toStr(json["sub_title"])
            entity.feature = Utility.toStr(json["feature"])
            entity.target = Utility.toStr(json["target"])
            entity.lineStepFlg = Utility.toInt(json["line_step_flg"])
            entity.movie = Utility.toInt(json["movie"])

            let technologyImage: NSArray = json["technology_image"] as! NSArray
            for value in technologyImage {
                entity.technologyImage.append(value as! Int)
            }

            entity.technologyMovie = Utility.toInt(json["technology_movie"])
            entity.lineMainImage = Utility.toInt(json["line_main_image"])

            let lineStep: NSArray = json["line_step"] as! NSArray
            for value in lineStep {
                let data: NSDictionary = value as! NSDictionary
                var lineStepData = DBStructLineStep()
                lineStepData.stepId = Utility.toInt(data["step"])
                lineStepData.product = data["product"] as! [Int]
                entity.lineStep.append(lineStepData)
            }

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }

    class func getEntities(isOnlyUseFlg: Bool = false) -> [LineTranslateEntity] {
        let database = ModelDatabase.getDatabase()
        database.open()

        let languageId = LanguageConfigure.languageId
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_line_translate WHERE language_id = ? AND use_flg = 1 ", withArgumentsIn: [languageId])

        var entities = [LineTranslateEntity]()

        while resultSet.next() {
            let entity = LineTranslateEntity()
            entity.lineId = Int(resultSet.int(forColumn: "line_id"))
            entity.languageId = languageId
            entity.lineTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))
            //content
            let json = Utility.parseContent(resultSet)
            entity.name = Utility.toStr(json["name"])
            entity.subTitle = Utility.toStr(json["sub_title"])
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
            if isOnlyUseFlg {
                if entity.useFlg == 1{
                    entities.append(entity)
                }
            } else {
                entities.append(entity)
            }

        }

        database.close()
        return entities
    }

    class func changeUseFlg(lineId: Int, isUse: Bool) {
        let database = ModelDatabase.getDatabase()
        let languageId: Int? = LanguageConfigure.languageId
        let use_flg = Int(isUse as NSNumber)
        database.open()
        database.executeUpdate("UPDATE m_line_translate SET use_flg = ? WHERE line_id = ? AND language_id = ?", withArgumentsIn: [use_flg, lineId, languageId!])
        database.close()
    }
}
