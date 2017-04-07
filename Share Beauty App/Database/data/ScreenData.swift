//
//  ProductData.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/09.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

/*
 各リストで表示する商品の汎用データクラス
 */
class ScreenData: NSObject {

    var screenId: Int!
    var code: String = String()
    var name: String = String()

    required override init() {
    }

    convenience init(screenId: Int) {
        self.init()
        let entitiy = AppScreenTable.getEntity(screenId)
        self.screenId = entitiy.appScreenId
        self.code = entitiy.code

        let translateEntitiy = AppScreenTranslateTable.getEntity(self.screenId)
        self.name = translateEntitiy.name
    }
}
