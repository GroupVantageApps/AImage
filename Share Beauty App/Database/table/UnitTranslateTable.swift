//
//  UnitTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class UnitTranslateTable: NSObject {

    class func getEntity(_ unitId: Int) -> UnitTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_unit_translate WHERE unit_id = ? AND language_id = ?", withArgumentsIn: [unitId, languageId!])
        let entity: UnitTranslateEntity = UnitTranslateEntity()

        if resultSet.next() {

            entity.unitId = unitId
            entity.languageId = languageId

            entity.unitTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            let json = Utility.parseContent(resultSet)
            entity.name = Utility.toStr(json["name"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }
}
