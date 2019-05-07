//
//  LanguageConfigure.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/02/06.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

class LanguageConfigure: NSObject {
    private static let defaultRegionId = 2
    private static let defaultCountryId = 6
    private static let defaultLanguageId = 21
    private static let lxCsv = "LxCsv"
    private static let lx2Csv = "Lx2Csv"
    private static let gscCsv = "GscCsv"
    private static let utmCsv = "UtmCsv"
    private static let sdp_eeeCsv = "SdpEeeCsv"
    private static let smkCsv = "AwsmkCsv"
    private static let gscPlist = "GscPlist"
    private static let gscGroup = "GscGroup"
    private static let lxYutaka = "lxYutaka"
    private static let suncareStandAlone = "suncareStandAlone"
    private static let UTMitem = "UTMitem"
    
    private enum UserDefaultKey: String {
        case region = "RegionId"
        case country = "CountryId"
        case language = "LanguageId"

        func set(value: Int) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: self.rawValue)
//            print("++++++++++++ setUserdefault ++++++++++++")
//            print("key:\(self.rawValue), value:\(value)")
//            print("++++++++++++++++++++++++++++++++++++++++")
            userDefault.synchronize()
        }

        func get() -> Int? {
            let value = UserDefaults.standard.object(forKey: self.rawValue)
//            print("++++++++++++ getUserdefault ++++++++++++")
//            print("key:\(self.rawValue), value:\(value)")
//            print("++++++++++++++++++++++++++++++++++++++++")
            return value as? Int
        }
    }

    static var regionId: Int {
        get {
            if let value = UserDefaultKey.region.get() {
                return value
            } else {
                UserDefaultKey.region.set(value: self.defaultRegionId)
                return self.defaultRegionId
            }
        }
        set (value) {
            UserDefaultKey.region.set(value: value)
            print("defaultRegionId: \(self.defaultRegionId)")
        }
    }

    static var countryId: Int {
        get {
            if let value = UserDefaultKey.country.get() {
                return value
            } else {
                UserDefaultKey.country.set(value: self.defaultCountryId)
                return self.defaultCountryId
            }
        }
        set (value) {
            UserDefaultKey.country.set(value: value)
            print("countryId: \(self.countryId)")
        }
    }

    static var languageId: Int {
        get {
            if let value = UserDefaultKey.language.get() {
                return value
            } else {
                UserDefaultKey.language.set(value: self.defaultLanguageId)
                return self.defaultLanguageId
            }
        }
        set (value) {
            UserDefaultKey.language.set(value: value)
            print("languageId: \(self.languageId)")
        }
    }
    
    static var UTMId: Int {
        get {
            if LanguageConfigure.isNewUTM {
                return 588
            } else {
                return 359
            }
        }
    }
    
    static var notUTMId: Int {
        get {
            if LanguageConfigure.isNewUTM {
                return 359
            } else {
                return 588
            }
        }
    }

    static var newUTMId: Int {
        get {
            if LanguageConfigure.isNewUTM {
                return 616
            } else {
                return 28
            }
        }
    }
    
    static var isNewUTM: Bool {
        get {
            if let value = UserDefaults.standard.object(forKey: UTMitem) {
                return value as! Bool
            } else {
                return true
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: UTMitem)
            userDefault.synchronize()
        }
    }
    

    private static var tempRegionId: Int?
    private static var tempCountryId: Int?
    private static var tempLanguageId: Int?

    static func keep() {
        tempRegionId = self.regionId
        tempCountryId = self.countryId
        tempLanguageId = self.languageId
    }

    static func rollback() {
        if tempRegionId == nil || tempCountryId == nil || tempLanguageId == nil {
            return
        }
        self.regionId = tempRegionId!
        self.countryId = tempCountryId!
        self.languageId = tempLanguageId!

        tempRegionId = nil
        tempCountryId = nil
        tempLanguageId = nil
    }
    static var lxcsv: [ String : String ] {
        get {
            if let value = UserDefaults.standard.object(forKey: lxCsv) {
                return value as! [String : String]
            } else {
                return [ "" : "" ] 
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: lxCsv)
            userDefault.synchronize()
        }
    }
    
    static var lx2csv: [ String : String ] {
        get {
            if let value = UserDefaults.standard.object(forKey: lx2Csv) {
                return value as! [String : String]
            } else {
                return [ "" : "" ] 
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: lx2Csv)
            userDefault.synchronize()
        }
    }
    static var gsccsv: [ String : String ] {
        get {
            if let value = UserDefaults.standard.object(forKey: gscCsv) {
                return value as! [String : String]
            } else {
                return [ "" : "" ] 
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: gscCsv)
            userDefault.synchronize()
        }
    }
    static var utmcsv: [ String : String ] {
        get {
            if let value = UserDefaults.standard.object(forKey: utmCsv) {
                return value as! [String : String]
            } else {
                return [ "" : "" ]
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: utmCsv)
            userDefault.synchronize()
        }
    }
    
    static var sdp_eee_csv: [ String : String ] {
        get {
            if let value = UserDefaults.standard.object(forKey: sdp_eeeCsv) {
                return value as! [String : String]
            } else {
                return [ "" : "" ]
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: sdp_eeeCsv)
            userDefault.synchronize()
        }
    }
    
    static var smk_csv: [ String : String ] {
        get {
            if let value = UserDefaults.standard.object(forKey: smkCsv) {
                return value as! [String : String]
            } else {
                return [ "" : "" ]
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: smkCsv)
            userDefault.synchronize()
        }
    }
   
    static var gscplist:  Dictionary<String, AnyObject>  {
        get {
            if let value = UserDefaults.standard.object(forKey: gscPlist) {
                return value as! Dictionary<String, AnyObject>
            } else {
                return [ "" : "" as AnyObject ]   
            } 
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: gscPlist)
            userDefault.synchronize()
        }
    }
    
    static var gscgroup: String {
        get {
            if let value = UserDefaults.standard.object(forKey: gscGroup) {
                return value as! String
            } else {
                return "A" 
            } 
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: gscGroup)
            userDefault.synchronize()
        }
    }
    
    static var lxyutaka: [ Int ] {
        get {
            if let value = UserDefaults.standard.object(forKey: lxYutaka) {
                return value as! [ Int ]
            } else {
                return [] 
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: lxYutaka)
            userDefault.synchronize()
        }
    }

    static var isMyanmar: Bool {
        get { return self.regionId == 2 && self.countryId == 23 && self.languageId == 58 }
    }
    
    static var isOutAppBtnHiddenCountry: Bool {
        get {
            print(self.countryId)
            return  ( self.countryId == 24 || self.countryId == 25 || self.countryId == 26 )
        }
    }
    
    static var isSuncareStandAloneApp: Bool {
        get {
            if let value = UserDefaults.standard.object(forKey: suncareStandAlone) {
                return value as! Bool
            } else {
                return false 
            }
        }
        set (value) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: suncareStandAlone)
            userDefault.synchronize()
        }
    }
}
