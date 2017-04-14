//
//  TelopTable.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/04/12.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TelopTable: NSObject {

	class func getEntity(_ telopId: Int) -> TelopEntity {
		let database = ModelDatabase.getDatabase()
		database.open()
		let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_telop WHERE id = ? ", withArgumentsIn: [telopId])
		
		var entity = self.createEntitiy(from: resultSet)
		if entity == nil {
			entity = TelopEntity()
		}
		
		database.close()
		return entity!
	}

	class func getAllEntities() -> [TelopEntity] {
		let database = ModelDatabase.getDatabase()
		database.open()
		let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_telop", withArgumentsIn: nil)
		
		var entities = [TelopEntity]()
		while let entitiy = self.createEntitiy(from: resultSet) {
			entities.append(entitiy)
		}
		
		database.close()
		return entities
	}
}

// MARK: - private functions
private extension TelopTable {
	
	class func createEntitiy(from resultSet: FMResultSet!) -> TelopEntity? {
		
		var entity: TelopEntity? = nil
		if resultSet.next() {
			
			entity = TelopEntity()
			guard let entity = entity else {
				return nil
			}
			
			entity.telopId = Utility.toInt(resultSet.string(forColumn: "id"))
			
			// content
			let json = Utility.parseContent(resultSet)
			entity.endTime = Utility.toDouble(json["end_time"])
			entity.startTime = Utility.toDouble(json["start_time"])
			
			entity.lastUpdateTs = Utility.toStr(resultSet.string(forColumn: "last_update_ts"))
			entity.deleteFlg = Utility.toInt(resultSet.string(forColumn: "delete_flg"))
		}
		
		return entity
	}
}
