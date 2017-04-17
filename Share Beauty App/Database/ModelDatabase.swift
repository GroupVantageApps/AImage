//
//  ModelDatabase.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/09.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

let sharedInstance = ModelDatabase()

class ModelDatabase: NSObject {

    class func getDatabase() -> FMDatabase {
        if self.database == nil {
            self.reloadDatabase()
        }
        return self.database!
    }

    class func switchDatabase() {
        let nextDbPath = dbFilePath()
        if nextDbPath != currentDbPath {
            beforeDbPath = currentDbPath
            currentDbPath = nextDbPath
            self.reloadDatabase()
            Utility.log(dbFilePath())
        }
    }

    class func reloadDatabase() {
        self.copyDBIfNeeded(filePath: currentDbPath)
        self.database = FMDatabase(path: currentDbPath)
        self.initDB()
    }

    static private var database: FMDatabase?
    static private var beforeDbPath: String?
    static private var currentDbPath: String = dbFilePath()

    private class func dbFilePath() -> String {
        let target = DownloadConfigure.target.rawValue
        let countryId = LanguageConfigure.countryId
        let file = String(format: Const.databaseNameFormat, arguments: [target, countryId])
        return Utility.getDocumentPath(file)
    }

    class func dbExists(filePath: String) -> Bool {
        return FileManager.default.fileExists(atPath: filePath)
    }

    class func copyDBIfNeeded(filePath: String) {
        if dbExists(filePath: filePath) {
            return
        }

        do {
            let at = Bundle.main.resourceURL!
                     .appendingPathComponent(Const.databaseName)
            try FileManager.default.copyItem(atPath: at.path, toPath: filePath)
        } catch {
        }
    }

    class func deleteDB() {
        do {
            try FileManager.default.removeItem(atPath: dbFilePath())
            if beforeDbPath != nil {
                currentDbPath = beforeDbPath!
                self.reloadDatabase()
            }
        } catch {
        }
    }

    // DBの新規作成＆更新時に必要なSQLを実行
    // （更新時の`CREATE TABLE`エラー等は無視する）
    class func initDB() {
        let db = self.getDatabase()

        if !db.open() {return}

        var sql = "ALTER TABLE m_product ADD COLUMN beauty_second_id int"
        db.executeUpdate(sql, withArgumentsIn: [])

        sql = "ALTER TABLE m_product ADD COLUMN line_id int"
        db.executeUpdate(sql, withArgumentsIn: [])

        sql = "CREATE TABLE m_log (region INT, language INT, screen TEXT, " +
              " action INT, item TEXT, product INT, log_date_time DATETIME)"
        db.executeUpdate(sql, withArgumentsIn: [])

        //Log DB準備 Start
        sql = "CREATE TABLE m_log_product (country INT, language INT, " +
        " buy_flg INT, product INT, log_date_time TEXT, UNIQUE (country, language, product, log_date_time))"
        db.executeUpdate(sql, withArgumentsIn: [])
        //Log DB準備 End

        sql = "CREATE TABLE m_recommend (product INT, line INT, beauty_second INT)"
        db.executeUpdate(sql, withArgumentsIn: [])

        db.close()
    }
}
