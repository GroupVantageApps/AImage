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
class ProductData: NSObject {

    var productId: Int = 0
    var lineId: Int = 0

    var image: Int = 0
    var lineName: String = String()         //m_line_translate.content.name
    var productName: String = String()      //m_product_translate.content.name
    var beautyName: String = String()       //m_beauty_second_translate.content.name

    var troubles: [DataStructTrouble] = []

    var day: Int = 0
    var night: Int = 0

    var feature: String = String()
    var whyNeed: String = String()

    var recommend: Int = 0
    var beautySecondId: Int = 0
    var reward: Int = 0
    var defaultDisplay: Int = 0

    var awardIcon: Int?
    var newItemFlg: Int = 0

    //IdealBeauty用
    var idealBeautyType: Int = Const.idealBeautyTypeProduct
    var displayOrder: Int = 0
    var lineFeature: String = String()
    var lineTarget: String = String()

    var lineOpened = false

    var uiImage: UIImage?

    required override init() {
    }

    convenience init(productId: Int) {
        //Utility.log("ProductData :" + productId.description)

        self.init()

        self.productId = productId

        let productEntity: ProductEntity = ProductTable.getEntity(productId)
        let productTranslateEntity: ProductTranslateEntity = ProductTranslateTable.getEntity(productId)

        self.lineId = productEntity.lineId!

        self.newItemFlg = productEntity.newItemFlg

        self.image = productTranslateEntity.image!
        self.productName = productTranslateEntity.name
        self.awardIcon = productTranslateEntity.awardIcon

        let lineTranslateEntity: LineTranslateEntity = LineTranslateTable.getEntity(self.lineId)
        let beautySecondTranslateEntity: BeautySecondTranslateEntity = BeautySecondTranslateTable.getEntity(productEntity.beautyId!)
        self.lineName = lineTranslateEntity.name
        self.beautyName = beautySecondTranslateEntity.name
        self.beautySecondId = beautySecondTranslateEntity.beautySecondId!

        //troublesプロパティは、IdealBeautyの手鏡モーダルで使用
        //productEntity.concernから、displatType:3のみを抽出する
        for value in productEntity.concern {
            let data: DBStructConcern = value as DBStructConcern

            if data.displayType == Const.troubleDisplayStrong || data.displayType == Const.troubleDisplayNormal {
                let entity: TroubleTranslateEntity = TroubleTranslateTable.getEntity(data.troubleId)
                var trouble: DataStructTrouble = DataStructTrouble()
                trouble.troubleId = data.troubleId
                trouble.troubleName = entity.name
                trouble.image = entity.image!

                self.troubles.append(trouble)
            }
        }

        if productEntity.opportunity.dayNight == 1 {
            self.day = 1
            self.night = 1
        } else {
            self.day = productEntity.opportunity.day
            self.night = productEntity.opportunity.night
        }

        self.feature = productTranslateEntity.feature
        self.whyNeed = ""
        self.defaultDisplay = productTranslateEntity.defaultDisplay!
        self.recommend = RecommendTable.check(self.productId)
    }

    convenience init(lineId: Int) {
        self.init()

        self.idealBeautyType = Const.idealBeautyTypeLine

        self.lineId = lineId

        let lineTranslateEntity: LineTranslateEntity = LineTranslateTable.getEntity(self.lineId)
        self.lineName = lineTranslateEntity.name
        self.lineFeature = lineTranslateEntity.feature
        self.lineTarget = lineTranslateEntity.target
        self.displayOrder = lineTranslateEntity.displayOrder!
    }
}

struct DataStructTrouble {
    var troubleId: Int
    var troubleName: String
    var displayFlg: Int
    var image: Int
    init() {
        troubleId = 0
        troubleName = ""
        displayFlg = 0
        image = 0
    }
}
