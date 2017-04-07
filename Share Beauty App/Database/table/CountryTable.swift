//
//  CountryTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class CountryTable: NSObject {

    class func getEntity(_ countryId: Int) -> CountryEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_country WHERE id = ? ", withArgumentsIn: [countryId])
        let entity: CountryEntity = CountryEntity()

        if resultSet.next() {

            entity.countryId = countryId
            entity.regionId = Utility.toInt(resultSet.string(forColumn: "region_id"))

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])
            entity.name = Utility.toStr(json["name"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }

    class func getEntities(regionId: Int) -> [CountryEntity] {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_country WHERE region_id = ? ", withArgumentsIn: [regionId])

        var entities = [CountryEntity]()

        while resultSet.next() {
            let entity: CountryEntity = CountryEntity()
            entity.countryId = Utility.toInt(resultSet.string(forColumn: "id"))
            entity.regionId = regionId

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])
            entity.name = Utility.toStr(json["name"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))

            entities.append(entity)
        }

        database.close()
        return entities
    }
}
