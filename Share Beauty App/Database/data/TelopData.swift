//
//  TelopData.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/04/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TelopData: NSObject {
	
	var movieId: Int = 0
	
	var datas = [DataStructTerop]()

	/// 動画IDからのテロップ検索
	convenience init(movieId: Int) {
		
		self.init()
		
		self.movieId = movieId
		
		let telopTranslateEntities = TelopTranslateTable.getEntity(movieId: movieId)
		telopTranslateEntities.forEach() {
			let telopEntitiy = TelopTable.getEntity($0.telopId!)
			var data = DataStructTerop()
			data.startTime = telopEntitiy.startTime!
			data.endTime = telopEntitiy.endTime!
			data.content = $0.telopContent
			self.datas.append(data)
		}
	}
}

// MARK: telop information struct
extension TelopData {
	/// テロップ情報構造体
	struct DataStructTerop {
		var startTime: TimeInterval = 0.0
		var endTime: TimeInterval = 0.0
		var content = ""
	}
}
