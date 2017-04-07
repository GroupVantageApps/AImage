//
//  StepUpperTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class BeautySecondTranslateTable: NSObject {

    class func getEntity(_ beautySecondId: Int) -> BeautySecondTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_beauty_second_translate WHERE beauty_second_id = ? AND language_id = ?", withArgumentsIn: [beautySecondId, languageId!])
        let entity: BeautySecondTranslateEntity = BeautySecondTranslateEntity()

        if resultSet.next() {

            entity.beautySecondId = beautySecondId
            entity.languageId = languageId

            entity.beautySecondTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            let json = Utility.parseContent(resultSet)
            entity.name = Utility.toStr(json["name"])

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }
/*
    class func getIdealBeauty() -> [DataStructBeautySecond] {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_beauty_second_translate WHERE language_id = ? ORDER BY display_order ", withArgumentsInArray: [languageId!])

        var beautySeconds: [DataStructBeautySecond] = []

        while resultSet.next() {
            var data: DataStructBeautySecond = DataStructBeautySecond()

            data.beautySecondId = Utility.toInt(resultSet.stringForColumn("beauty_second_id"))

            let json = Utility.parseContent(resultSet)
            data.name = Utility.toStr(json["name"])

            beautySeconds.append(data)
        }

        return beautySeconds
    }*/
}
