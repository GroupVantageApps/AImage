//
//  LineTranslateEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LineTranslateEntity: NSObject {
    var lineTranslateId: Int? = 0
    var lineId: Int? = 0
    var languageId: Int? = 0

    //content
    var name: String = String()
    var subTitle: String = String()
    var feature: String = String()
    var target: String = String()
    var lineStepFlg: Int? = 0
    var movie: Int? = 0                     //m_file.id
    var technologyImage: [Int] = []			//m_file.id 配列
    var technologyMovie: Int? = 0			//m_file.id
    var lineMainImage: Int? = 0
    var lineStep: [DBStructLineStep] = []

    var displayOrder: Int? = 0
    var lastUpdateTs: String = String()
    var useFlg: Int? = 0
    var displayFlg: Int? = 0
}

struct DBStructLineStep {
    var stepId: Int                     //stepLowerId
    var stepName: String                //LineDetailDataで使用
    var product: [Int]
    var productData: [ProductData]       //LineDetailDataで使用
    init() {
        stepId = 0
        stepName = ""
        product = []
        productData = []
    }
}
