//
//  ColorballEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/10/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ColorballEntity: NSObject {

    var colorballId: Int? = 0

    //content
    var code: String = String()
    var name: String = String()
    var categoryOne: String = String()
    var categoryTwo: String = String()
    var colorballImage: Int? = 0

    var lastUpdateTs: String = String()
    var deleteFlg: Int? = 0
}
