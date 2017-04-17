//
//  LogTable.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LogTable: NSObject {

    class func insert(_ value: DBInsertValueLog) {
        let regionId: Int = LanguageConfigure.regionId
        let languageId: Int = LanguageConfigure.languageId

        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "INSERT INTO m_log (region, language, screen, action, item, product, log_date_time) VALUES (?, ?, ?, ?, ?, ?, datetime('now')) "
        database.executeUpdate(sql, withArgumentsIn: [regionId, languageId, value.screen, value.action, value.item, value.product])

        database.close()
    }

    //1週間分のログを集計する
    class func total() -> [String:Any] {
        let database = ModelDatabase.getDatabase()
        database.open()

        let sql: String = "SELECT strftime('%Y%m%d', datetime( log_date_time, 'localtime')) AS ymd FROM m_log "
                        + " WHERE strftime('%Y%m%d', datetime( log_date_time, 'localtime')) >= strftime('%Y%m%d', datetime('now', 'localtime','-7 days')) "
                        + "   AND strftime('%Y%m%d', datetime( log_date_time, 'localtime')) <= strftime('%Y%m%d', datetime('now', 'localtime','-1 days')) "
                        + " GROUP BY ymd ORDER BY ymd"
        let resultSet1: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])

        var log: [String:Any] = [:]

        while resultSet1.next() {
            let ymd = Utility.toStr(resultSet1.string(forColumn: "ymd"))

            let sql: String = "SELECT strftime('%Y%m%d', datetime( log_date_time, 'localtime')) AS ymd, screen, item, product, count(*) AS cnt FROM m_log WHERE ymd = '" + ymd
                            + "' GROUP BY ymd, screen, item, product ORDER BY screen, item, product"
            let resultSet2: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])

            var dailyLog: [Any] = []

            while resultSet2.next() {
                let screen = Utility.toStr(resultSet2.string(forColumn: "screen"))
                let item = Utility.toStr(resultSet2.string(forColumn: "item"))
                let product = Utility.toInt(resultSet2.string(forColumn: "product"))
                let cnt = Utility.toInt(resultSet2.string(forColumn: "cnt"))

                var itemLog: [String: Any] = [:]
                itemLog["app_screen"] = screen
                itemLog["app_item"] = item
                itemLog["product_id"] = product
                itemLog["count"] = cnt

                dailyLog.append(itemLog)
            }

            log[ymd] = dailyLog
        }

        database.close()
        return log
    }

    //Log start
    class func insertProductLog(_ value: DBInsertValueProductLog) {
        let countryId: Int = LanguageConfigure.countryId
        let languageId: Int = LanguageConfigure.languageId
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        let database = ModelDatabase.getDatabase()
        database.open()
        
        let sql: String = "INSERT OR REPLACE INTO m_log_product (country, language, product, buy_flg, log_date_time) VALUES (?, ?, ?, ?, ?)"
        database.executeUpdate(sql, withArgumentsIn: [ countryId, languageId, value.product, value.buyFlg, date])
        database.close()
    }
    class func totalProductLog() -> [Any] {
        let database = ModelDatabase.getDatabase()
        database.open()
        
        let sql: String = "SELECT * FROM m_log_product"
        let resultSet1: FMResultSet! = database.executeQuery(sql, withArgumentsIn: [])
        
        var log: [Any] = []
        while resultSet1.next() {
            
            let country = Utility.toStr(resultSet1.string(forColumn: "country"))
            let language = Utility.toInt(resultSet1.string(forColumn: "language"))
            let product = Utility.toInt(resultSet1.string(forColumn: "product"))
            let buy_flg = Utility.toInt(resultSet1.string(forColumn: "buy_flg"))
            let date = Utility.toStr(resultSet1.string(forColumn: "log_date_time"))
            
            var itemLog: [String: Any] = [:]
            itemLog["country"] = country
            itemLog["language"] = language
            itemLog["product"] = product
            itemLog["buyFlg"] = buy_flg
            itemLog["date"] = date
            
            log.append(itemLog)
        }
        
        database.close()
        return log
    }
    class func delete_all() {
        let database = ModelDatabase.getDatabase()
        database.open()
        let sql: String = "DELETE FROM m_log_product"
        database.executeUpdate(sql, withArgumentsIn: [])
        database.close()
    }
    //Log end
}

struct DBInsertValueLog {
    var screen: String
    var item: String
    var action: Int
    var product: Int
    init() {
        screen = ""
        item = ""
        action = 0
        product = 0
    }
}

//Log start
struct DBInsertValueProductLog {
    var product: Int
    var buyFlg: Int
    init() {
        product = 0
        buyFlg = 0
    }
}
//Log end
