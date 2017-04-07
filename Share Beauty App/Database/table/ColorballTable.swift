//
//  ColorballTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/10/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ColorballTable: NSObject {

    class func getEntity(_ colorballId: Int) -> ColorballEntity {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_colorball WHERE id = ? ", withArgumentsIn: [colorballId])
        let entity: ColorballEntity = ColorballEntity()

        if resultSet.next() {

            entity.colorballId = colorballId

            //content
            let json = Utility.parseContent(resultSet)
            entity.code = Utility.toStr(json["code"])
            entity.name = Utility.toStr(json["name"])
            entity.categoryOne = Utility.toStr(json["category_one"])
            entity.categoryTwo = Utility.toStr(json["category_two"])
            entity.colorballImage = Utility.toInt(json["colorball_image"])

            entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
            entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
        }

        database.close()
        return entity
    }
}
