//
//  LanguageTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LanguageTable: NSObject {

    class func getEntity(_ languageId: Int) -> LanguageEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_language WHERE id = ? ", withArgumentsIn: [languageId])
        let entity: LanguageEntity = LanguageEntity()

        if resultSet.next() {

            entity.languageId = languageId
            entity.countryId = Utility.toInt(resultSet.string(forColumn: "country_id"))

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])
            entity.name = Utility.toStr(json["name"])
            entity.colorballMainFlg = Utility.toInt(json["colorball_main_flg"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }

    class func getFirstEntity() -> LanguageEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_language LIMIT 1 ", withArgumentsIn: nil)
        let entity: LanguageEntity = LanguageEntity()

        if resultSet.next() {

            entity.languageId = Utility.toInt(resultSet.string(forColumn: "id"))
            entity.countryId = Utility.toInt(resultSet.string(forColumn: "country_id"))

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])
            entity.name = Utility.toStr(json["name"])
            entity.colorballMainFlg = Utility.toInt(json["colorball_main_flg"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }

    class func getEntities(countryId: Int) -> [LanguageEntity] {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_language WHERE country_id = ? ", withArgumentsIn: [countryId])
        var entities = [LanguageEntity]()
        while resultSet.next() {
            let entity: LanguageEntity = LanguageEntity()
            entity.languageId = Utility.toInt(resultSet.string(forColumn: "id"))
            entity.countryId = countryId

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])
            entity.name = Utility.toStr(json["name"])
            entity.colorballMainFlg = Utility.toInt(json["colorball_main_flg"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))

            entities.append(entity)
        }

        database.close()
        return entities
    }
}
