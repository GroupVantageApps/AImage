//
//  StepUpperTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class AppScreenTranslateTable: NSObject {

    class func getEntity(_ appScreenId: Int) -> AppScreenTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_app_screen_translate WHERE app_screen_id = ? AND language_id = ?", withArgumentsIn: [appScreenId, languageId!])
        let entity: AppScreenTranslateEntity = AppScreenTranslateEntity()

        if resultSet.next() {

            entity.appScreenId = appScreenId
            entity.languageId = languageId

            entity.appScreenTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

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
