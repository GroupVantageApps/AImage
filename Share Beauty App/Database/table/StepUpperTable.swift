//
//  StepUpperTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class StepUpperTable: NSObject {

    class func getEntity(_ stepUpperId: Int) -> StepUpperEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_step_upper WHERE id = ? ", withArgumentsIn: [stepUpperId])
        let entity: StepUpperEntity = StepUpperEntity()

        if resultSet.next() {

            entity.stepUpperId = stepUpperId

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
