//
//  RegionTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class RegionTable: NSObject {

    class func getEntity(_ regionId: Int) -> RegionEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_region WHERE id = ? ", withArgumentsIn: [regionId])
        let entity: RegionEntity = RegionEntity()

        if resultSet.next() {

            entity.regionId = regionId

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

    class func getAllEntities() -> [RegionEntity] {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_region", withArgumentsIn: nil)

        var entities = [RegionEntity]()

        while resultSet.next() {
            let entity: RegionEntity = RegionEntity()

            entity.regionId = Utility.toInt(resultSet.string(forColumn: "id"))
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
