//
//  IdealBeautyLinesData.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/27.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class IdealBeautyLinesData: NSObject {

    //var productId: Int
    var lines: [DataStructLine]?

    override init() {
//        Utility.log("IdealBeautyLines.init :" + lines.description)

        let items = AppItemTable.getItems(screenId: Const.screenIdIdealBeauty1)
        guard let item = items["02"] else {
            return
        }

        let idealBeautyLines = Utility.parseArrayString(item)
        if idealBeautyLines.count != 0 {
            lines = []
        }
        for lineId in idealBeautyLines {
            let entity: LineTranslateEntity = LineTranslateTable.getEntity(lineId)
            if entity.lineId != 0 && entity.useFlg == 1 {
                var data: DataStructLine = DataStructLine()
                data.lineId = entity.lineId!
                data.name = entity.name
                data.target = entity.target

                self.lines?.append(data)
            }
        }
    }
}

struct DataStructLine {
    var lineId: Int
    var name: String
    var target: String
    init() {
        lineId = 0
        name = ""
        target = ""
    }
}
