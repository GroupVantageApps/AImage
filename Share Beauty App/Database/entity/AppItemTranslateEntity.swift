//
//  AppItemTranslateEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class AppItemTranslateEntity: NSObject {

    var appItemTranslateId: Int? = 0
    var appItemId: Int? = 0
    var languageId: Int? = 0

    //content
    var name: String = String()
    var movie: [Int] = []
    var mainImage: [Int] = []           //image配下だが、ベタ置きとする
    var thumbnailImage: [Int] = []      //image配下だが、ベタ置きとする

    var displayOrder: Int? = 0
    var lastUpdateTs: String = String()
    var useFlg: Int? = 0
}
