//
//  StepLowerTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class StepLowerTable: NSObject {

    class func getEntity(_ stepLowerId: Int) -> StepLowerEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_step_lower WHERE id = ? ", withArgumentsIn: [stepLowerId])
        let entity: StepLowerEntity = StepLowerEntity()

        if resultSet.next() {

            entity.stepLowerId = stepLowerId
            entity.stepUpperId = Utility.toInt(resultSet.string(forColumn: "step_upper_id"))

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
