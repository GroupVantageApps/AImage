//
//  DownloadConfigure.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/02/06.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class DownloadConfigure {

    private enum UserDefaultKey: String {
        case api = "Api"
        case target = "Target"
        case downloadStatus = "DownloadStatus"
        case isNeedUpdate = "IsNeedUpdate"

        private func key() -> String {
            switch self {
            case .api, .downloadStatus, .isNeedUpdate:
                return "\(self.rawValue)-\(DownloadConfigure.target.rawValue)-\(LanguageConfigure.countryId)"
            default:
                return self.rawValue
            }
        }

        func set(value: Any) {
            let userDefault = UserDefaults.standard
            userDefault.set(value, forKey: self.key())
            userDefault.synchronize()
//            print("++++++++++++ setUserdefault ++++++++++++")
//            print("key:\(self.key()), value:\(value)")
//            print("++++++++++++++++++++++++++++++++++++++++")
        }

        func get() -> Any? {
            let value = UserDefaults.standard.object(forKey: self.key())
//            print("++++++++++++ getUserdefault ++++++++++++")
//            print("key:\(self.key()), value:\(value)")
//            print("++++++++++++++++++++++++++++++++++++++++")
            return value
        }

        func remove() {
            UserDefaults.standard.removeObject(forKey: self.key())
        }
    }

    enum Target: Int {
        case develop
        case release

        var name: String {
            switch self {
            case .develop:
                return "develop"
            case .release:
                return "release"
            }
        }
    }

    enum DownloadStatus: Int {
        case failure = -1
        case notdoing
        case success
    }

    static let targets = [Target.develop, Target.release]

    static var target: Target {
        get {
            if let value = UserDefaultKey.target.get() {
                return Target(rawValue: value as! Int)!
            } else {
                UserDefaultKey.target.set(value: Target.release.rawValue)//DB向き 本番
                return Target.release //DB向き 本番
                
                // UserDefaultKey.target.set(value: Target.develop.rawValue)//DB向き　develop or release 無理やり
               // return Target.develop //DB向き　develop or release 無理やり
            }
        }
        set (value) {
            UserDefaultKey.target.set(value: value.rawValue)
            print("target: \(self.target)")
        }
    }

    static var apiKey: String? {
        get {
            let value = UserDefaultKey.api.get()
            return value as? String
        }
        set (value) {
            if value == nil {
                UserDefaultKey.api.remove()
            } else {
                UserDefaultKey.api.set(value: value!)
            }
            print("apiKey: \(self.apiKey)")
        }
    }

    static var isNeedUpdate: Bool {
        get {
            if let value = UserDefaultKey.isNeedUpdate.get() {
                return value as! Bool
            } else {
                UserDefaultKey.isNeedUpdate.set(value: false)
                return false
            }
        }
        set (value) {
            UserDefaultKey.isNeedUpdate.set(value: value)
            print("isNeedUpdate: \(self.isNeedUpdate)")
        }
    }
    static var downloadStatus: DownloadStatus {
        get {
            if let value = UserDefaultKey.downloadStatus.get() {
                return DownloadStatus(rawValue: value as! Int)!
            } else {
                UserDefaultKey.downloadStatus.set(value: DownloadStatus.notdoing.rawValue)
                return DownloadStatus.notdoing
            }
        }
        set (value) {
            UserDefaultKey.downloadStatus.set(value: value.rawValue)
            print("downloadStatus: \(self.downloadStatus)")
        }
    }

    private static var tempTarget: Target?

    static func keepTarget() {
        tempTarget = self.target
    }
    static func rollbackTarget() {
        if tempTarget == nil {
            return
        }
        self.target = tempTarget!
        self.releaseTarget()
    }

    static func releaseTarget() {
        tempTarget = nil
    }
}
