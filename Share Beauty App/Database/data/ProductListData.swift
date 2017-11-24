//
//  ProductListData.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/27.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ProductListData: NSObject {

    //var productId: Int
    var products: [ProductData] = []
    var productIdsLX: [Int] = []

    var flgLX: Int = 0
    var flgUTM: Int = 0
    var flgOther: Int = 0
    var otherLineIds: [Int] = []
    var stepLowerIds: [Int] = []

    var pattern: Int = 0
    private var mNoAddFlg = false

    required override init() {
    }

    //IdealBeautyの抽出
    //(1)で選択した複数ラインと、(3)で選択した複数美類から、一覧を作成する
    //一覧は、ProductDataの配列を保持する
    convenience init(lineIdsOrigin: [Int], stepLowerIdsOrigin: [Int], noAddFlg: Bool = false) {
        Utility.log("ProductListData.init :" + lineIdsOrigin.description + " stepLowerIdsOrigin:" + stepLowerIdsOrigin.description)
        self.init()

        mNoAddFlg = noAddFlg

        //lineIdの振り分け
        for lineId in lineIdsOrigin {
            if lineId == Const.lineIdLX {
                self.flgLX = 1
            } else if lineId == Const.lineIdUTM {
                self.flgUTM = 1
            } else {
                self.flgOther = 1
                self.otherLineIds.append(lineId)
            }
        }

        self.otherLineIds = self.sortLineId(self.otherLineIds)
        self.stepLowerIds = self.sortStepLowerId(stepLowerIdsOrigin)
        self.productIdsLX = self.getLXProductIds(self.stepLowerIds)   //L, L

        self.pattern = self.checkPattern()

        if stepLowerIds.count == 1 && stepLowerIds.first == 6 {
            self.pattern = 4
        }

        //パターン3: L       --> L,L
        if self.pattern == 3 {
            self.addLX()
            //Ultimune
            if stepLowerIdsOrigin.contains(6) {
                self.addUTM()
            }
        //パターン4: U       --> U,U
        } else if self.pattern == 4 {
            self.addUTM()

        //パターン5: L,U     --> L,L, U,U
        } else if self.pattern == 5 {
            self.addLX()
            self.addUTM()

        } else {
            createDataStructIdeal()
        }
    }

    func createDataStructIdeal() {

        //otherLineIdsのlineId毎に、DataStructIdealを作成し、DataStructIdeal配列を作成
        var idealsOrigin: [DataStructIdeal] = []
        for lineId in self.otherLineIds {
            var ideal: DataStructIdeal = DataStructIdeal()
            ideal.line = ProductData(lineId: lineId)

            let targetProducts = self.getProductIdsByLineAndStep(lineId, stepLowerIds: self.stepLowerIds)
            for product in targetProducts {
                if product.defaultDisplay == 1 && LineTranslateTable.getEntity(lineId).displayFlg == 1 {
                    ideal.products.append(product)
                }
            }
            idealsOrigin.append(ideal)
        }
        //print(idealsOrigin)

        //idealsOrigin配列からSHISEIDOの商品を抽出する
        var idealsRaw: [DataStructIdeal] = []
        var productsSHISEIDO: [ProductData] = []    //SHISEIDOライン商品
        var productsMAKEUP: [ProductData] = []      //MAKEUPライン商品
        for idealOrigin in idealsOrigin {
            var productsOther: [ProductData] = []
            for product in idealOrigin.products {
                if product.lineId == Const.lineIdSHISEIDO {
                    productsSHISEIDO.append(product)
                } else if product.lineId == Const.lineIdMAKEUP {
                    productsMAKEUP.append(product)
                } else {
                    productsOther.append(product)
                }
            }
            var ideal: DataStructIdeal = DataStructIdeal()
            ideal.line = idealOrigin.line
            ideal.products = productsOther

            idealsRaw.append(ideal)
        }

        //productsSHISEIDO から同一商品を削除

        //SHISEIDO構造体の追加
        var ideal: DataStructIdeal = DataStructIdeal()
        ideal.line = ProductData(lineId: Const.lineIdSHISEIDO)
        ideal.products = distinctProducts(productsSHISEIDO)
        idealsRaw.append(ideal)

        //MAKEUP構造体の追加
        ideal = DataStructIdeal()
        ideal.line = ProductData(lineId: Const.lineIdMAKEUP)
        ideal.products = distinctProducts(productsMAKEUP)
        idealsRaw.append(ideal)

        prepareDataStructIdeal(idealsRaw)
    }

    //[ProductData]から重複を省く
    func distinctProducts(_ productsOrigin: [ProductData]) -> [ProductData] {

        var productsResult: [ProductData] = []
        for productTarget in productsOrigin {
            //既に存在するか
            var hitFlg = 0
            for product in productsResult {
                if productTarget.productId == product.productId {
                    hitFlg = 1
                }
            }
            if hitFlg == 0 {
                productsResult.append(productTarget)
            }
        }

        return productsResult
    }

    func prepareDataStructIdeal(_ idealsRaw: [DataStructIdeal]) {

        var ideals: [DataStructIdeal] = []

        //ideals を displayOrder で並び替える

        //ideals から商品のない構造体を削除
        for ideal in ideals {
            print ("------ " + ideal.line.lineName + ": products.count:" + ideal.products.count.description)
        }
        var idealsTemporary: [DataStructIdeal] = []
        for ideal in idealsRaw {
            if ideal.products.count > 0 {
                idealsTemporary.append(ideal)
            }
        }
        ideals = idealsTemporary
        for ideal in ideals {
            print ("====== " + ideal.line.lineName + ": products.count:" + ideal.products.count.description)
        }

        setProductData(ideals)
    }

    func setProductData(_ ideals: [DataStructIdeal]) {
        //ideals から products を作成
        for ideal in ideals {

                if self.pattern == 6 {
                    self.addLX()

                } else if self.pattern == 7 {
                    self.addUTM()

                } else if self.pattern == 8 {
                    self.addLX()
                    //self.addUTM()
                }

            self.products.append(ideal.line)
            for product in ideal.products {
                self.products.append(product)
            }

                if self.pattern == 6 {
                    self.addUTM()

                } else if self.pattern == 7 {
                    self.addLX()
                    
                }
            }
            if self.pattern == 2 {
                self.addUTM()
                self.addLX()
            }

        //パターン2: A,B     --> A,A,A,B,B, U,U,L,L
        //パターン6: A,B,L   --> L,L,A,A,A,U,U, L,L,B,B,U,U
        //パターン7: A,B,U   --> U,U,A,A,A,L,L, U,U,B,B,L,L
        //パターン8: A,B,L,U --> L,L,U,U,A,A,A, L,L,U,U,B,B
        if ideals.count == 0 {
            //その他ラインに選択した類に対応する商品がない場合
            //LXを選ばれている場合、パターン3
            //UTMを選ばれている場合、パターン4
            //LX・UTMを選ばれている場合、パターン5に準拠させる
            if self.flgLX == 1 {
                //productIds = productIdsLX
                self.addLX()
            }
            if self.flgUTM == 1 {
                //productIds += Const.productIdsUTM
                self.addUTM()
            }
        }
    }

    func sortLineId(_ selectedLineIds: [Int]) -> [Int] {
        //Const.idealBeautyLines の並び順にソートする
        var sortedIds: [Int] = []

        let items = AppItemTable.getItems(screenId: Const.screenIdIdealBeauty1)
        let idealBeautyLines = Utility.parseArrayString(items["02"]!)

        for lineId in idealBeautyLines {
            for selectedLineId in selectedLineIds {
                if selectedLineId == lineId {
                    sortedIds.append(selectedLineId)
                }
            }
        }
        return sortedIds
    }

    func sortStepLowerId(_ selectedStepLowerIds: [Int]) -> [Int] {
        //Const.idealBeautyStepLowers の並び順にソートする
        var sortedIds: [Int] = []

        let items = AppItemTable.getItems(screenId: Const.screenIdIdealBeauty2)
        let idealBeautyStepLowers = Utility.parseArrayString(items["02"]!)

        for stepLowerId in idealBeautyStepLowers {
            for selectedStepLowerId in selectedStepLowerIds {
                if selectedStepLowerId == stepLowerId {
                    sortedIds.append(selectedStepLowerId)
                }
            }
        }
        return sortedIds
    }

    func checkPattern() -> Int {
        var pattern: Int = 0

        //パターン1: A,A,A,U,U, B,B,U,U (現在未使用)
        //パターン2: A,B     --> A,A,A,B,B, U,U,L,L
        //パターン3: L       --> L,L
        //パターン4: U       --> U,U
        //パターン5: L,U     --> L,L, U,U
        //パターン6: A,B,L   --> L,L,A,A,A,U,U, L,L,B,B,U,U
        //パターン7: A,B,U   --> U,U,A,A,A,L,L, U,U,B,B,L,L
        //パターン8: A,B,L,U --> L,L,U,U,A,A,A, L,L,U,U,B,B

        if self.flgLX == 1 && self.flgUTM == 0 && self.flgOther == 0 {
            pattern = 3
        } else if self.flgLX == 0 && self.flgUTM == 1 && self.flgOther == 0 {
            pattern = 4
        } else if self.flgLX == 0 && self.flgUTM == 0 && self.flgOther == 1 {
            pattern = 2
        } else if self.flgLX == 1 && self.flgUTM == 1 && self.flgOther == 0 {
            pattern = 5
        } else if self.flgLX == 1 && self.flgUTM == 0 && self.flgOther == 1 {
            pattern = 6
        } else if self.flgLX == 0 && self.flgUTM == 1 && self.flgOther == 1 {
            pattern = 7
        } else if self.flgLX == 1 && self.flgUTM == 1 && self.flgOther == 1 {
            pattern = 8
        }

        return pattern
    }
    func addLX() {
        if mNoAddFlg {return}
        if self.productIdsLX.count > 0 {
            self.appendLineByArray(Const.lineIdLX)
            self.appendProductByArray(self.productIdsLX)
        }
    }
    func addUTM() {
        if mNoAddFlg {return}
        self.appendLineByArray(Const.lineIdUTM)
        self.appendProductByArray(Const.productIdsUTM)
    }

    func getProductIdsByLineAndStep(_ lineId: Int, stepLowerIds: [Int]) -> [ProductData] {
        var products: [ProductData] = []

        let entity: LineTranslateEntity = LineTranslateTable.getEntity(lineId)
        for stepLowerId in stepLowerIds {
            for step in entity.lineStep {
                if step.stepId == 6 {   //#2182
                    continue
                }
                if step.stepId == stepLowerId {
                    let tempProducts = step.product.map { ProductData(productId: $0) }
                    let newProducts = tempProducts.filter { $0.newItemFlg == 1 }
                    let oldProducts = tempProducts.filter { $0.newItemFlg == 0 }
                    products += (newProducts + oldProducts)
                }
            }
        }

        return products
    }

    private func sortedProductByNew(productIds: [Int]) {

    }

    func getLXProductIds(_ stepLowerIds: [Int]) -> [Int] {

        var productIds: [Int] = []

        for stepLowerId in stepLowerIds {
            if stepLowerId == 2 {
                //Remove off makeup

            } else if stepLowerId == 3 {
                //Cleanser
                productIds += [318, 516]

            } else if stepLowerId == 4 {
                //Softener
                productIds += [224, 517]

            } else if stepLowerId == 6 {
                //Ultimune

            } else if stepLowerId == 8 {
                //Serum
                productIds += [523, 390, 39]

            } else if stepLowerId == 9 {
                //Moisturizer
                productIds += [307, 227, 23, 146, 519, 520, 521]

            } else if stepLowerId == 10 {
                //Eye care
                productIds += [387, 522]

            } else if stepLowerId == 11 {
                //Special care
                productIds += []

            } else if stepLowerId == 13 {
                //OTHERS
                productIds += [66, 365, 292, 51, 32, 524, 525]
            }
        }
        return productIds
    }

    //商品ID・画面IDからのリスト作成
    //Life Style Beautyから、詳細画面に渡すためのリストを作成
    convenience init(productId: Int, screenId: Int) {
        Utility.log("ProductListData.init productId:" + productId.description + ", screenId:" + screenId.description)

        self.init()

        let productEntity: ProductEntity = ProductTable.getEntity(productId)

        //LifeStyleBeautyの場合
        //商品の美類がMoisturizerの場合：全MoisturizerがBPの順に並ぶ
        //それ以外は、その商品のみ
        if screenId == Const.screenIdLifeStyleBeautyA ||
            screenId == Const.screenIdLifeStyleBeautyB ||
            screenId == Const.screenIdLifeStyleBeautyC ||
            screenId == Const.screenIdLifeStyleBeautyD ||
            screenId == Const.screenIdLifeStyleBeautyF ||
            screenId == Const.screenIdLifeStyleBeautyG ||
            screenId == Const.screenIdLifeStyleBeautyH ||
            screenId == Const.screenIdLifeStyleBeautyI {

            if productEntity.beautyId == Const.beautySecondIdMoisturizer {
                //全MoisturizerBP順
                let regionId: Int? = LanguageConfigure.regionId

                //Americas
                if regionId == Const.regionIdAmericas {
                    self.appendProductByArray(Const.bpMoisturizerAmericas)

                //Asia/Oceania
                } else if regionId == Const.regionIdAsia {
                    self.appendProductByArray(Const.bpMoisturizerAsia)
                }

            } else {
                let data: ProductData = ProductData(productId: productId)
                if data.defaultDisplay == 1 && LineTranslateTable.getEntity(data.lineId).displayFlg == 1 {
                    self.products.append(data)
                }
            }
        }
    }

    //画面IDからのリスト作成
    convenience init(screenId: Int) {
        Utility.log("ProductListData.init screenId:" + screenId.description)

        self.init()

        //Life Style Beauty A
        if screenId == Const.screenIdLifeStyleBeautyA {
            self.appendProductByArray(Const.lifeStyleBeautyListA)

        //Life Style Beauty B
        } else if screenId == Const.screenIdLifeStyleBeautyB {
            self.appendProductByArray(Const.lifeStyleBeautyListB)

        //Life Style Beauty C
        } else if screenId == Const.screenIdLifeStyleBeautyC {
            self.appendProductByArray(Const.lifeStyleBeautyListC)

        //Life Style Beauty D
        } else if screenId == Const.screenIdLifeStyleBeautyD {
            self.appendProductByArray(Const.lifeStyleBeautyListD)

        //Life Style Beauty F
        } else if screenId == Const.screenIdLifeStyleBeautyF {
            self.appendProductByArray(Const.lifeStyleBeautyListF)
        //On Trend Beauty
        } else if screenId == Const.screenIdLifeStyleBeautyG {
            self.appendProductByArray(Const.lifeStyleBeautyListG)
            //On Trend Beauty
        } else if screenId == Const.screenIdLifeStyleBeautyH {
            self.appendProductByArray(Const.lifeStyleBeautyListH)
            //On Trend Beauty
        } else if screenId == Const.screenIdLifeStyleBeautyI {
            self.appendProductByArray(Const.lifeStyleBeautyListI)
            //On Trend Beauty
        } else if screenId == Const.screenIdOnTrendBeauty {
            let items: [String: String] = AppItemTable.getItems(screenId: Const.screenIdOnTrendBeauty)
            guard let item = items["03"],
                let json = Utility.parseJson(item),
                let products = json["products"].arrayObject as? [Int] else {
                    return
            }
            print(json["products"])
            print(products)
            self.appendProductByArrayForonTrendBeauty(products)
           // self.appendProductByArray(products)
        //Iconic Beauty
        } else if screenId == Const.screenIdIconicBeauty {
            let items: [String: String] = AppItemTable.getItems(screenId: Const.screenIdIconicBeauty)
            guard let item = items["06"],
                let json = Utility.parseJson(item),
                let products = json["products"].arrayObject as? [Int] else {
                    return
            }
            print(json["products"])
            print(products)
            self.appendProductByArrayForIconicBeauty(products)
            
        }
    }

    //ラインIDからのリスト作成
    convenience init(productIds: [Int]) {
        self.init()

        productIds.forEach { productId in
            products.append(ProductData(productId: productId))
        }
    }

    //ラインIDからのリスト作成
    convenience init(lineId: Int, isIgnoreDisplayFlg: Bool = false) {
        Utility.log("ProductListData.init lineId:" + lineId.description)

        self.init()

        var productIds: [Int] = []
        if lineId == Const.lineIdSUNCARE || lineId == Const.lineIdMAKEUP {
            productIds = ProductTable.getProductIdsByLineIdOrderByDisplayOrder(lineId)
        }else{
            productIds = ProductTable.getProductIdsByLineId(lineId)
        }
        //let productIdsSorted = ProductTable.sortIdsByBeautySecond(productIds)   //美類ソート

        self.appendProductByArray(productIds, isIgnoreDisplayFlg: isIgnoreDisplayFlg)
    }

    //レコメンドリスト作成
    convenience init(lineId: Int, beautySecondId: Int) {
        self.init()

        let productIds = RecommendTable.select(lineId: lineId, beautySecondId: beautySecondId)

        self.appendProductByArray(productIds)
    }

    convenience init(productIds: String?, beautyIds: String?, lineIds: String?) {
        self.init()
        let productIds = ProductTable.getProductIdsBy(productIds: productIds, beautyIds: beautyIds, lineIds: lineIds)

        let products = productIds.map {ProductData(productId: $0)}
        var dicProducts = [Int:[ProductData]]()
        for product in products {
            if product.defaultDisplay == 0 || LineTranslateTable.getEntity(product.lineId).displayFlg == 0 {continue}
            if dicProducts[product.lineId] == nil {
                dicProducts[product.lineId] = [product]
            } else {
                dicProducts[product.lineId]?.append(product)
            }
        }

        dicProducts.keys.sorted {$0 < $1}.forEach { lineId in
            if(lineId != 38){
                self.appendLineByArray(lineId)
                self.appendProductByArray(dicProducts[lineId]!.map {$0.productId})
            }
        }
    }

    //productIdの配列から、ProductData配列を作成する
    func appendProductByArray(_ productIds: [Int], isIgnoreDisplayFlg: Bool = false) {
        var secondsProducts = [Int:[ProductData]]()
        for productId in productIds {
            let data: ProductData = ProductData(productId: productId)
            
            if isIgnoreDisplayFlg {
                if secondsProducts[data.beautySecondId] == nil {
                    secondsProducts[data.beautySecondId] = [data]
                } else {
                    secondsProducts[data.beautySecondId]?.append(data)
                }
            } else {
                if data.defaultDisplay == 1 && LineTranslateTable.getEntity(data.lineId).displayFlg == 1 {
                    if secondsProducts[data.beautySecondId] == nil {
                        secondsProducts[data.beautySecondId] = [data]
                    } else {
                        secondsProducts[data.beautySecondId]?.append(data) 
                    }
                }
            }
        }

        var tempProducts = [ProductData]()
        secondsProducts.keys.sorted().forEach({ key in
            let secondProduct = secondsProducts[key]!
            let new = secondProduct.filter {$0.newItemFlg == 1}
            let old = secondProduct.filter {$0.newItemFlg == 0}
            tempProducts += (new + old)
        })
        self.products += tempProducts
    }

    func appendLineByArray(_ lineId: Int) {
        let data: ProductData = ProductData(lineId: lineId)
        self.products.append(data)
    }
    //【IconicBeauty用】productIdの配列から、ProductData配列を作成する
    func appendProductByArrayForIconicBeauty(_ productIds: [Int]) {
        var secondsProducts = [Int:[ProductData]]()
        var i = 0
        for productId in productIds {
            let data: ProductData = ProductData(productId: productId)
            if data.defaultDisplay == 1 && LineTranslateTable.getEntity(data.lineId).displayFlg == 1 {
                let data: ProductData = ProductData(productId: productId)
                secondsProducts[i] = [data]
                i += 1
            }
        }
        var tempProducts = [ProductData]()
        secondsProducts.keys.sorted().forEach({ key in
            let secondProduct = secondsProducts[key]!
            let new = secondProduct.filter {$0.newItemFlg == 1}
            let old = secondProduct.filter {$0.newItemFlg == 0}
            tempProducts += (new + old)
        })
        self.products += tempProducts
    }
    //【LatestBeauty用】productIdの配列から、ProductData配列を作成する
    func appendProductByArrayForonTrendBeauty(_ productIds: [Int]) {
        var secondsProducts = [Int:[ProductData]]()
        var i = 0
        for productId in productIds {
            let data: ProductData = ProductData(productId: productId)
            if data.defaultDisplay == 1 && LineTranslateTable.getEntity(data.lineId).displayFlg == 1 {
                let data: ProductData = ProductData(productId: productId)
                secondsProducts[i] = [data]
                i += 1
            }
            //secondsProducts[i] = [data]
            //i += 1
        }
        var tempProducts = [ProductData]()
        secondsProducts.keys.sorted().forEach({ key in
            let secondProduct = secondsProducts[key]!
            let new = secondProduct.filter {$0.newItemFlg == 1}
            let old = secondProduct.filter {$0.newItemFlg == 0}
            tempProducts += (new + old)
        })
        self.products += tempProducts
    }

}

struct DataStructIdeal {
    var line: ProductData
    var products: [ProductData]
    init() {
        line = ProductData()
        products = []
    }
}




