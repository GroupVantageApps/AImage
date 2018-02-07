//
//  StepLowerTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class StepLowerTranslateTable: NSObject {

    class func getEntity(_ stepLowerId: Int) -> StepLowerTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_step_lower_translate WHERE step_lower_id = ? AND language_id = ?", withArgumentsIn: [stepLowerId, languageId!])
        let entity: StepLowerTranslateEntity = StepLowerTranslateEntity()

        if resultSet.next() {

            entity.stepLowerId = stepLowerId
            entity.languageId = languageId

            entity.stepLowerTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            let json = Utility.parseContent(resultSet)
            entity.name = Utility.toStr(json["name"])
            entity.stepFlg = Utility.toInt(json["step_flg"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }
}
