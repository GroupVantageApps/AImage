//
//  ProductDetailData.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/27.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductDetailData: NSObject {

    var productId: Int = 0
    var lineId: Int = 0
    var beautySecondId: Int = 0

    var productEntity: ProductEntity
    var productTranslateEntity: ProductTranslateEntity

    var beautySecondEntity: BeautySecondEntity
    var beautySecondTranslateEntity: BeautySecondTranslateEntity

    var lineEntity: LineEntity
    var lineTranslateEntity: LineTranslateEntity

    var image: Int = 0
    var lineName: String = String()         //m_line_translate.content.name
    var productName: String = String()      //m_product_translate.content.name
    var beautyName: String = String()       //m_beauty_second_translate.content.name
    var feature: String = String()
    var howToUse: String = String()
    var troubles: [DataStructTrouble] = []
    var relationProduct: [Int] = []

    var movie: Int = 0

    var technologyImage: [Int] = []
    var usageImage: [Int] = []
    var effectImage: [Int] = []

    var day: Int = 0
    var night: Int = 0

    var brush: Int = 0

    var unitName: String = String()

    var productList: [DataStructProductList] = []
    var colorballs: [DataStructColorball] = []

    var recommend: Int = 0

    var backImage: Int?

    var spMovies = [Int]()

    var spec: String = String()

    //簡易イニシャライザ
    convenience init(productId: Int, screenId: String) {
        self.init(productId: productId)
        self.createListByScreenId(screenId)
    }

    //簡易イニシャライザ
    convenience init(productId: Int, productListData: ProductListData) {
        self.init(productId: productId)
        self.createListByProductListData(productListData)
    }

    //指定イニシャライザ
    init(productId: Int) {
        Utility.log("ProductDetailData :" + productId.description)
        self.productId = productId

        self.productEntity = ProductTable.getEntity(productId)
        self.productTranslateEntity = ProductTranslateTable.getEntity(productId)

        self.beautySecondEntity = BeautySecondTable.getEntity(self.productEntity.beautyId!)
        self.beautySecondTranslateEntity = BeautySecondTranslateTable.getEntity(self.productEntity.beautyId!)

        self.lineId = self.productEntity.lineId!
        self.beautySecondId = self.beautySecondEntity.beautySecondId!

        self.lineEntity = LineTable.getEntity(self.lineId)
        self.lineTranslateEntity = LineTranslateTable.getEntity(self.lineId)

        self.image = self.productTranslateEntity.image!
        self.lineName = self.lineTranslateEntity.name
        self.productName = self.productTranslateEntity.name
        self.beautyName = self.beautySecondTranslateEntity.name

        self.feature = self.productTranslateEntity.feature
        self.howToUse = self.productTranslateEntity.howToUse

        self.backImage = self.productEntity.backImage

        self.spMovies = self.productEntity.spMovies

        //concernソート
        let sort = [Const.troubleDisplayStrong, Const.troubleDisplayNormal, Const.troubleDisplayHide]
        var concern: [DBStructConcern] = []
        for display in sort {
            for value in productEntity.concern {
                if display == value.displayType {
                    concern.append(value)
                }
            }
        }
        productEntity.concern = concern

        for value in productEntity.concern {
            let data: DBStructConcern = value as DBStructConcern
            let entity: TroubleTranslateEntity = TroubleTranslateTable.getEntity(data.troubleId)

            var trouble: DataStructTrouble = DataStructTrouble()
            trouble.troubleId = data.troubleId
            trouble.troubleName = entity.name
            trouble.image = entity.image!

            //displayフラグは、 アジアのみ以下のように制御する
            // 3: 強調
            // 2: 通常
            // 1: 非表示
            let regionId: Int? = LanguageConfigure.regionId

            //Asia/Oceania
            if regionId == Const.regionIdAsia {
                trouble.displayFlg = value.displayType
                if trouble.displayFlg == Const.troubleDisplayStrong || trouble.displayFlg == Const.troubleDisplayNormal {
                    self.troubles.append(trouble)
                }

            } else {
                //アジア以外の場合は、悩みフラグを無視して通常表示とする
                trouble.displayFlg = Const.troubleDisplayNormal
                self.troubles.append(trouble)
            }
        }

        self.movie = self.productTranslateEntity.movie!

        self.technologyImage = productTranslateEntity.technologyImage
        self.usageImage = productTranslateEntity.usageImage
        self.effectImage = productTranslateEntity.effectImage

        if self.productEntity.opportunity.dayNight == 1 {
            self.day = 1
            self.night = 1
        } else {
            self.day = self.productEntity.opportunity.day
            self.night = self.productEntity.opportunity.night
        }

        let unitId: Int = GcodeTable.getUnitIdByProductId(productId)
        let unitTranslateEntity: UnitTranslateEntity = UnitTranslateTable.getEntity(unitId)
        self.unitName = unitTranslateEntity.name
        let durationTitle = AppItemTable.getNameByItemId(itemId: 90)

        var duration = productTranslateEntity.duration
        if durationTitle != nil && duration != "" {
            duration = "\(durationTitle!) \(duration)"
        }

        let specs =  [self.unitName,
                      productTranslateEntity.paInfo,
                      productTranslateEntity.spf,
                      productTranslateEntity.uva,
                      duration,
                      ].filter {$0 != ""}
        self.spec = specs.joined(separator: ", ")
        //ブラシ
        let items = AppItemTable.getItems(screenId: Const.screenIdProductDetail)
        if let item = items["13"],
            let json = Utility.parseJson(item),
            let brushValidSecondBeautyIds = json["brush"].arrayObject as? [Int] {

            for targetId in brushValidSecondBeautyIds {
                if self.productEntity.beautyId == targetId {
                    brush = 1
                }
            }
        }
        //色玉
        var colorballIds: [Int] = []
        //m_product_translate.select_gcodeから、colorballId配列を作成
        for gcodeId in self.productTranslateEntity.selectGcode {
            let gcodeEntity = GcodeTable.getEntity(gcodeId)
            colorballIds.append(gcodeEntity.colorball!)
        }

        //colorballId配列をlanguage_id, use_flgで絞込、display_orderでソート
        colorballIds = ColorballTranslateTable.sortIds(colorballIds)

        for colorballId in colorballIds {
            let colorBallEntity = ColorballTable.getEntity(colorballId)

            var data = DataStructColorball()
            data.colorballId = colorballId
            data.name = colorBallEntity.name
            data.imageId = colorBallEntity.colorballImage!
            self.colorballs.append(data)
        }
        self.recommend = RecommendTable.check(self.productId)
    }

    //遷移元の画面IDから、下部に表示する商品一覧（self.productList）を作成する
    func createListByScreenId(_ screenId: String) {
    }

    //遷移元から渡されたProductListDataより、下部に表示する商品一覧（self.productList）を作成する
    func createListByProductListData(_ productListData: ProductListData) {

        //[ProductData]から、[DataStructProductList]への変換を行う
        for productData in productListData.products {
            var data = DataStructProductList()
            data.productId = productData.productId
            data.imageId = productData.image
            self.productList.append(data)
        }
    }
}

struct DataStructProductList {
    var productId: Int
    var imageId: Int
    init() {
        productId = 0
        imageId = 0
    }
}
struct DataStructColorball {
    var colorballId: Int
    var name: String
    var imageId: Int
    init() {
        colorballId = 0
        name = ""
        imageId = 0
    }
}
