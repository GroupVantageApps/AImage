//
//  TelopTranslateEntity.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/04/12.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TelopTranslateEntity: NSObject {
	
	var telopTranslateId: Int? = 0
	var telopId: Int? = 0
	var languageId: Int? = 0
	
	// content
	var movie: Int? = 0
	var telopContent: String = String()
	
	var displayOrder: Int? = 0
	var lastUpdateTs: String = String()
	var useFlg: Int? = 0
}
