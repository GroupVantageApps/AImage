//
//  StepUpperTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class BeautySecondTable: NSObject {

    class func getEntity(_ beautySecondId: Int) -> BeautySecondEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_beauty_second WHERE id = ? ", withArgumentsIn: [beautySecondId])
        let entity: BeautySecondEntity = BeautySecondEntity()

        if resultSet.next() {

            entity.beautySecondId = beautySecondId
            entity.beautyFirstId = Utility.toInt(resultSet.string(forColumn: "beauty_first_id"))

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
