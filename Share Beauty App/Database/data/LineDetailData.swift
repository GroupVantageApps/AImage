//
//  LineDetailData.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/09.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LineDetailData: NSObject {

    var lineId: Int = 0

    var lineEntity: LineEntity
    var lineTranslateEntity: LineTranslateEntity

    var lineName: String = String()
    var subTitle: String = String()
    var feature: String = String()

    var image: Int = 0
    var movie: Int = 0
    var lineStepFlg: Int = 0

    var step: [DBStructStep] = []

    //指定イニシャライザ
    init(lineId: Int) {
        Utility.log("LineDetailData :" + lineId.description)
        self.lineId = lineId

        self.lineEntity = LineTable.getEntity(lineId)
        self.lineTranslateEntity = LineTranslateTable.getEntity(lineId)

        self.lineName = self.lineTranslateEntity.name
        self.subTitle = self.lineTranslateEntity.subTitle
        self.feature = self.lineTranslateEntity.feature

        self.image = self.lineTranslateEntity.lineMainImage!
        self.movie = self.lineTranslateEntity.movie!

        var currentUpperId: Int = 0
        var upperStep: DBStructStep? = nil
        for var lineStep in self.lineTranslateEntity.lineStep {
            let stepLower: StepLowerEntity = StepLowerTable.getEntity(lineStep.stepId)
            let stepLowerTranslate: StepLowerTranslateEntity = StepLowerTranslateTable.getEntity(lineStep.stepId)
            lineStep.stepName = stepLowerTranslate.name

            for productId in lineStep.product {
                let data: ProductData = ProductData(productId: productId)
                if data.defaultDisplay == 1 && LineTranslateTable.getEntity(lineId).useFlg == 1 {
                    lineStep.productData.append(data)
                }
            }

            if currentUpperId != stepLower.stepUpperId {

                if upperStep != nil {
                    self.step.append(upperStep!)
                }

                currentUpperId = stepLower.stepUpperId!
                let stepUpperTranslate: StepUpperTranslateEntity = StepUpperTranslateTable.getEntity(currentUpperId)

                upperStep = DBStructStep()
                upperStep!.stepUpperId = currentUpperId
                upperStep!.stepUpperName = stepUpperTranslate.name
            }

            if upperStep != nil {
                upperStep!.lineStep.append(lineStep)
            }
        }
        if upperStep != nil {
            self.step.append(upperStep!)
        }
        //print(self.step)

        self.lineStepFlg = self.lineTranslateEntity.lineStepFlg!
    }
}

struct DBStructStep {
    var stepUpperId: Int
    var stepUpperName: String
    var lineStep: [DBStructLineStep]
    init() {
        stepUpperId = 0
        stepUpperName = ""
        lineStep = []
    }
}
