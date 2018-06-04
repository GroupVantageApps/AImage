//
//  ProductEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ProductEntity: NSObject {

    var productId: Int? = 0
    var lineId: Int? = 0
    var season: String = String()
    var beautyId: Int? = 0
    var region: String = String()
    var amountImageId: Int? = 0
    var colorballPoolCode: String = String()
    var finderDisplayFlg: Int? = 0

    var finish: DBStructFinish = DBStructFinish()
    var cover: DBStructCover = DBStructCover()
    var pointOfUse: DBStructPointOfUse = DBStructPointOfUse()
    var opportunity: DBStructOpportunity = DBStructOpportunity()
    var condition: DBStructCondition = DBStructCondition()
    var concern: [DBStructConcern] = []

    var lastUpdateTs: String = String()
    var deleteFlg: Int? = 0
    var backImage: Int?
	var backImage2: Int? = nil

    var newItemFlg: Int = 0

    var spMovies = [Int]()
	var makeupLook: Bool = false
	var makeupLookImages = [Int]()
    
    var texture: String = String()
}

struct DBStructFinish {
    var matteFlg: Int
    var mediumFlg: Int
    var lustrousFlg: Int
    init() {
        matteFlg = 0
        mediumFlg = 0
        lustrousFlg = 0
    }
}

struct DBStructCover {
    var lightFlg: Int
    var mediumFlg: Int
    var fullFlg: Int
    init() {
        lightFlg = 0
        mediumFlg = 0
        fullFlg = 0
    }
}

struct DBStructPointOfUse {
    var forFace: Int
    var forEyes: Int
    var forLips: Int
    var forNeckDecolletage: Int
    var forBody: Int
    var forHand: Int
    var forHair: Int
    var others: Int
    init() {
        forFace = 0
        forEyes = 0
        forLips = 0
        forNeckDecolletage = 0
        forBody = 0
        forHand = 0
        forHair = 0
        others = 0
    }
}

struct DBStructOpportunity {
    var dayNight: Int
    var day: Int
    var night: Int
    init() {
        dayNight = 0
        day = 0
        night = 0
    }
}

struct DBStructCondition {
    var oily: Int
    var normal: Int
    var dry: Int
    var oilyWithDrySurface: Int
    init() {
        oily = 0
        normal = 0
        dry = 0
        oilyWithDrySurface = 0
    }
}

struct DBStructConcern {
    var troubleId: Int
    var displayType: Int
    init() {
        troubleId = 0
        displayType = 0
    }
}
