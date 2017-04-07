//
//  StepUpperTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class StepUpperTranslateTable: NSObject {

    class func getEntity(_ stepUpperId: Int) -> StepUpperTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_step_upper_translate WHERE step_upper_id = ? AND language_id = ?", withArgumentsIn: [stepUpperId, languageId!])
        let entity: StepUpperTranslateEntity = StepUpperTranslateEntity()

        if resultSet.next() {

            entity.stepUpperId = stepUpperId
            entity.languageId = languageId

            entity.stepUpperTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

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
