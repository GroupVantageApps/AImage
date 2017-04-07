//
//  UnitTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class UnitTable: NSObject {

    class func getEntity(_ unitId: Int) -> UnitEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_unit WHERE id = ? ", withArgumentsIn: [unitId])
        let entity: UnitEntity = UnitEntity()

        if resultSet.next() {

            entity.unitId = unitId

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])

            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }
}
