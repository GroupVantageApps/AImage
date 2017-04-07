//
//  ProductTranslateEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ProductTranslateEntity: NSObject {

    var productTranslateId: Int? = 0
    var productId: Int? = 0
    var languageId: Int? = 0

    //content
    var name: String = String()
    var image: Int? = 0					//m_file.id
    var feature: String = String()
    var paInfo: String = String()
    var spf: String = String()
    var uva: String = String()
    var howToUse: String = String()
    var defaultDisplay: Int? = 0
    var duration: String = String()
    var price: String = String()
    var usageImage: [Int] = []			//m_file.id 配列
    var effectImage: [Int] = []			//m_file.id 配列
    var technologyImage: [Int] = []		//m_file.id 配列
    var recommendItem: Int? = 0			//m_product.id
    var movie: Int? = 0					//m_file.id
    var utmImage: [Int] = []			//m_file.id 配列
    var selectGcode: [Int] = []

    var displayOrder: Int? = 0
    var lastUpdateTs: String = String()
    var useFlg: Int? = 0

    var awardIcon: Int?
}
