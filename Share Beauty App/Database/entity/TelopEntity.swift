//
//  TelopEntity.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/04/12.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TelopEntity: NSObject {
	
	var telopId: Int? = 0
	
	// content
	var endTime: TimeInterval? = 0.0
	var startTime: TimeInterval? = 0.0
	
	var lastUpdateTs: String = String()
	var deleteFlg: Int? = 0
}
