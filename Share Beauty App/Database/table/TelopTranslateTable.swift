//
//  TelopTranslateTable.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/04/12.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TelopTranslateTable: NSObject {
	
	/// movieIdによる検索
	class func getEntity(movieId: Int) -> [TelopTranslateEntity] {
		let database = ModelDatabase.getDatabase()
		database.open()
		
		// content内のmovie値は「"」ありとなしの両パターン存在するので注意
		let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_telop_translate WHERE language_id = \(LanguageConfigure.languageId) AND use_flg = 1 AND content LIKE '%\"movie\":%\(movieId)%' ORDER BY display_order", withArgumentsIn: nil)
		
		var entities = [TelopTranslateEntity]()
		while let entitiy = self.createEntitiy(from: resultSet) {
			entities.append(entitiy)
		}
		
		database.close()
		return entities
	}
}

// MARK: - private functions
private extension TelopTranslateTable {
	
	class func createEntitiy(from resultSet: FMResultSet!) -> TelopTranslateEntity? {
		
		var entity: TelopTranslateEntity? = nil
		if resultSet.next() {
			
			entity = TelopTranslateEntity()
			guard let entity = entity else {
				return nil
			}
			
			entity.telopTranslateId = Utility.toInt(resultSet.string(forColumn: "id"))
			entity.telopId = Utility.toInt(resultSet.string(forColumn: "telop_id"))
			entity.languageId = Utility.toInt(resultSet.string(forColumn: "language_id"))
			
			// content
			let json = Utility.parseContent(resultSet)
			entity.movie = Utility.toInt(json["movie"])
			entity.telopContent = Utility.toStr(json["telop_content"])
			
			entity.displayOrder = Utility.toInt(resultSet.string(forColumn: "display_order"))
			entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
			entity.useFlg = Utility.toInt(resultSet.string(forColumn: "use_flg"))
		}
		
		return entity
	}
}
