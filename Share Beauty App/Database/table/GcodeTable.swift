//
//  GcodeTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class GcodeTable: NSObject {

    class func getEntity(_ gcodeId: Int) -> GcodeEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_gcode WHERE id = ? ", withArgumentsIn: [gcodeId])
        let entity: GcodeEntity = GcodeEntity()

        if resultSet.next() {

            entity.gcodeId = gcodeId

            entity.gcode = Utility.toStr(resultSet.string(forColumn: "gcode"))
            entity.productId = Utility.toInt(resultSet.string(forColumn: "product_id"))

            //content
            let json = Utility.parseContent(resultSet)
            entity.colorball = Utility.toInt(json["colorball"])
            entity.unitId = Utility.toInt(json["unit"])

            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }

    class func getUnitIdByProductId(_ productId: Int) -> Int {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_gcode WHERE product_id = ? AND content NOT LIKE '%\"unit\":\"\"%' LIMIT 1 ", withArgumentsIn: [productId])
        var unitId: Int = 0

        if resultSet.next() {
            let json = Utility.parseContent(resultSet)
            unitId = Utility.toInt(json["unit"])
        }

        database.close()
        return unitId
    }

    class func getColorballIdsByProductId(_ productId: Int) -> [Int] {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_gcode WHERE product_id = ? AND content NOT LIKE '%\"colorball\":\"\"%' ", withArgumentsIn: [productId])
        var colorballIds: [Int] = []

        while resultSet.next() {
            let json = Utility.parseContent(resultSet)
            colorballIds.append(Utility.toInt(json["colorball"]))
        }

        database.close()
        return colorballIds
    }
}
