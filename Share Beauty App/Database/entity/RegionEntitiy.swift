//
//  LanguageEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class RegionEntity: NSObject {

    var regionId: Int!

    //content
    var code: String!
    var name: String!

    var displayOrder: Int?
    var lastUpdateTs: String?
    var deleteFlg: Int?
}
