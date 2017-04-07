//
//  TroubleTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TroubleTranslateTable: NSObject {

    class func getEntity(_ troubleId: Int) -> TroubleTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_trouble_translate WHERE trouble_id = ? AND language_id = ?", withArgumentsIn: [troubleId, languageId!])
        let entity: TroubleTranslateEntity = TroubleTranslateEntity()

        if resultSet.next() {

            entity.troubleId = troubleId
            entity.languageId = languageId

            entity.troubleTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            let json = Utility.parseContent(resultSet)
            entity.name = Utility.toStr(json["name"])
            entity.image = Utility.toInt(json["image"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }

    class func getName(_ troubleId: Int) -> String {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT content FROM m_trouble_translate WHERE trouble_id = ? AND language_id = ?", withArgumentsIn: [troubleId, languageId!])

        var name: String = ""

        if resultSet.next() {
            let json = Utility.parseContent(resultSet)
            name = Utility.toStr(json["name"])
        }

        database.close()

        return name
    }
}
