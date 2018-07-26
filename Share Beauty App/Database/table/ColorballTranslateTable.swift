//
//  ColorballTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/10/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ColorballTranslateTable: NSObject {

    class func getEntity(_ colorballId: Int) -> ColorballTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_colorball_translate WHERE colorball_id = ? AND language_id = ?", withArgumentsIn: [colorballId, languageId!])
        let entity: ColorballTranslateEntity = ColorballTranslateEntity()

        if resultSet.next() {

            entity.colorballId = colorballId
            entity.languageId = languageId

            entity.colorballTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            let json = Utility.parseContent(resultSet)
            if let nameLocal = json["name_local"] {
                entity.nameLocal = Utility.toStr(nameLocal)
            }

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }

    class func sortIds(_ ids: [Int]) -> [Int] {
        let database = ModelDatabase.getDatabase()
        let languageId: Int? = LanguageConfigure.languageId
        database.open()

        let sql: String = "SELECT colorball_id FROM m_colorball_translate WHERE language_id = ? AND colorball_id IN (" +
            ids.map({String($0)}).joined(separator: ", ") +
        ") AND use_flg = 1 ORDER BY  display_order "

        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [languageId!])

        var sortIds: [Int] = []

        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "colorball_id"))
            sortIds.append(productId)
        }

        return sortIds
    }
}
