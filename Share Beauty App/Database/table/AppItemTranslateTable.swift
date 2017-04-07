//
//  StepUpperTranslateTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class AppItemTranslateTable: NSObject {

    class func getEntity(_ appItemId: Int) -> AppItemTranslateEntity {
        let languageId: Int? = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_app_item_translate WHERE app_item_id = ? AND language_id = ?", withArgumentsIn: [appItemId, languageId!])
        let entity: AppItemTranslateEntity = AppItemTranslateEntity()

        if resultSet.next() {

            entity.appItemId = appItemId
            entity.languageId = languageId

            entity.appItemTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))

            let json = Utility.parseContent(resultSet)
            entity.name = Utility.toStr(json["name"])

            let movie: NSArray = json["movie"] as! NSArray
            for value in movie {
                entity.movie.append(value as! Int)
            }

            let tmp: NSArray = json["image"] as! NSArray        //これはDBの作成ミスかも
            let image: NSDictionary = tmp[0] as! NSDictionary

            let mainImage: NSArray = image["main_image"] as! NSArray
            for value in mainImage {
                entity.mainImage.append(value as! Int)
            }

            let thumbnailImage: NSArray = image["thumbnail_image"] as! NSArray
            for value in thumbnailImage {
                entity.thumbnailImage.append(value as! Int)
            }

            entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
        }

        database.close()
        return entity
    }
}
