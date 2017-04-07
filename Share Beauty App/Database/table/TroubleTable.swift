//
//  TroubleTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TroubleTable: NSObject {

    class func getEntity(_ troubleId: Int) -> TroubleEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT  * FROM m_trouble WHERE id = ? ", withArgumentsIn: [troubleId])
        let entity: TroubleEntity = TroubleEntity()

        if resultSet.next() {

            entity.troubleId = troubleId

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
