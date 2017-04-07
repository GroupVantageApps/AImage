//
//  RecommendTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class RecommendTable: NSObject {

    class func insert(_ value: DBInsertValueRecommend) {
        //let regionId: Int = LanguageConfigure.regionId
        //let languageId: Int = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "INSERT INTO m_recommend (product, line, beauty_second) VALUES (?, ?, ?) "
        database.executeUpdate(sql, withArgumentsIn: [value.product, value.line, value.beautySecond])

        database.close()
    }

    class func delete(_ productId: Int) {
        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "DELETE FROM m_recommend WHERE product = ? "
        database.executeUpdate(sql, withArgumentsIn: [productId])

        database.close()
    }

    class func deleteAll() {
        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "DELETE FROM m_recommend"
        database.executeUpdate(sql, withArgumentsIn: [])

        database.close()
    }

    class func check(_ productId: Int) -> Int {
        let database = ModelDatabase.getDatabase()
        database.open()
        let resultSet: FMResultSet! = database.executeQuery("SELECT * FROM m_recommend WHERE product = ? ", withArgumentsIn: [productId])

        var count: Int = 0
        if resultSet.next() {
            count = count + 1
        }

        database.close()
        return count
    }

    class func selectAll() -> [Int] {
        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "SELECT product FROM m_recommend "
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])

        var ids: [Int] = []

        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "product"))
            ids.append(productId)
        }

        database.close()
        return ids
    }

    class func select(lineId: Int, beautySecondId: Int) -> [Int] {
        let database = ModelDatabase.getDatabase()
        database.open()

        var sql: String = "SELECT product FROM m_recommend WHERE 1 = 1"
        if lineId != 0 {
            sql = sql + " AND line = " + lineId.description
        }
        if beautySecondId != 0 {
            sql = sql + " AND beauty_second = " + beautySecondId.description
        }
        let resultSet: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])

        var ids: [Int] = []

        while resultSet.next() {
            let productId = Utility.toInt(resultSet.string(forColumn: "product"))
            ids.append(productId)
        }

        database.close()
        return ids
    }
}

struct DBInsertValueRecommend {
    var product: Int
    var line: Int
    var beautySecond: Int
    init() {
        product = 0
        line = 0
        beautySecond = 0
    }
}
