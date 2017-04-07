//
//  AppScreenEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class AppScreenEntity: NSObject {

    var appScreenId: Int? = 0

    //content
    var code: String = String()
    var screenName: String = String()

    var lastUpdateTs: String = String()
    var deleteFlg: Int? = 0
}
