//
//  IdealBeautySecondsData.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/27.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class IdealBeautySecondsData: NSObject {

    //var productId: Int
    var stepLowers: [DataStructStepLower] = []

    init(lineIds: [Int]) {
        Utility.log("IdealBeautySecondsData")

        let items = AppItemTable.getItems(screenId: Const.screenIdIdealBeauty2)
        let idealBeautyStepLowers = Utility.parseArrayString(items["02"]!)

        for stepLowerId in idealBeautyStepLowers {
            let entity: StepLowerTranslateEntity = StepLowerTranslateTable.getEntity(stepLowerId)

            var data: DataStructStepLower = DataStructStepLower()
            data.stepLowerId = stepLowerId
            data.name = entity.name

            if data.name == "For Eye" {
                data.name = "Eye care"
            }

            //lineIdとstepLowerIdから、それに対応する商品があるか確認する
            //lineIdLXはEXCELシート（1007ideal の補足2.xlsx）を参考にプロダクトの有無を決定する
            //lineIdUTMはチェックしない
            var num: Int = 0
            for lineId in lineIds {
                if LineTranslateTable.getEntity(lineId).displayFlg == 0 { continue }
                if lineId != Const.lineIdLX{// && lineId != Const.lineIdUTM {
                    let line: LineTranslateEntity = LineTranslateTable.getEntity(lineId)
                    guard let targetLineStep = line.lineStep.filter({$0.stepId == stepLowerId})[safe: 0] else {
                        continue
                    }
                    let products = ProductListData(productIds: targetLineStep.product).products
                    products.forEach({ product in
                        if product.defaultDisplay == 1 {
                            num += 1
                        }
                    })
                } else if lineId == Const.lineIdLX {
                    //2:[Remove off makeup]
                    //11:[Special care]
                    //はLXに対応するプロダクトなし
                    if stepLowerId != 2 && stepLowerId != 11 {
                        num += 1
                    }
                }
            }
            if num == 0 {
                data.valid = 0
            }

            if stepLowerId == 6 && lineIds.count == 1 && lineIds.first == Const.lineIdLX {
                data.valid = 0
            }

            stepLowers.append(data)
        }
    }
}

struct DataStructStepLower {
    var stepLowerId: Int
    var name: String
    var valid: Int
    init() {
        stepLowerId = 0
        name = ""
        valid = 1
    }
}
