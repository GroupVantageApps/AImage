//
//  AppScreenTranslateEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class AppScreenTranslateEntity: NSObject {

    var appScreenTranslateId: Int? = 0
    var appScreenId: Int? = 0
    var languageId: Int? = 0

    //content
    var name: String = String()

    var displayOrder: Int? = 0
    var lastUpdateTs: String = String()
    var useFlg: Int? = 0
}
