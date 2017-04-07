import SwiftyJSON

// LifeStyleBeautyのカウント数を管理するクラス
class LifeStyleBeautyCount {

    static let key = "LifeStyleBeautyCount"
    static let remote = "remote"
    static let local  = "local"

    /*
     カウント数を保持したDictionaryを返す
     ["0": [remote: 3],  // リモートのカウント数
           [local:  5]]  // ローカルのカウント数
     */
    private class func getDictionary() -> [String: [String: Int]] {
        if let list = UserDefaults.standard.dictionary(forKey: key) as? [String: [String: Int]] {
            return list
        }
        return [:]
    }

    // カウント数を保持したリストを返す
    class func getCounts() -> [String: Int] {
        var dict = [String: Int]()
        for (i, d) in getDictionary() {
            var n = 0
            if let r = d[remote] { n += r }
            if let l = d[local] { n += l }
            dict[i] = n
        }
        return dict
    }

    // サーバーから取得したデータを保存する
    class func save(remoteData: JSON) {
        var dict = getDictionary()

        // 0で初期化
        for index in 0...3 {
            let i = String(index)
            if let localCount = dict[i]?[local] {
                dict[i] = [remote: 0, local: localCount]
            } else {
                dict[i] = [remote: 0]
            }
        }

        // 該当するカウント数をセット
        for (_, data):(String, JSON) in remoteData {
            switch data["app_item"] {
            case "10": dict["0"]?["remote"] = data["count"].int
            case "11": dict["1"]?["remote"] = data["count"].int
            case "12": dict["2"]?["remote"] = data["count"].int
            case "13": dict["3"]?["remote"] = data["count"].int
            default: break
            }
        }

        UserDefaults.standard.set(dict, forKey: key)
        UserDefaults.standard.synchronize()
    }

    // 引数のindexのlocal countをincrementする
    class func incrementLocal(index: Int) {
        var dict = getDictionary()
        if var d = dict[String(index)] {
            let n = d[local] ?? 0
            dict[String(index)]?[local] = n + 1
        } else {
            dict[String(index)] = [local: 1]
        }
        UserDefaults.standard.set(dict, forKey: key)
        UserDefaults.standard.synchronize()
    }

    class func clearLocalData() {
        var dict = getDictionary()
        for (i, _) in dict {
            dict[i]?[local] = 0
        }
        UserDefaults.standard.set(dict, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
