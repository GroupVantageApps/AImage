//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class BNF619SecondEfficacyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        let percentDic:[Int:String] = [8408: "34%", 8409: "12%", 8410: "11%"]
        for subView in self.subviews {
            if type(of: subView) == UILabel.self {
                let label: UILabel = subView as! UILabel
                var title = self.convertSpecialCharacters(string: AppItemTable.getNameByItemId(itemId: label.tag) ?? "not exist")
                label.text = title
                label.adjustsFontSizeToFitWidth = true
                if [8408,8409,8410].contains(label.tag) {
                    let percent = percentDic[label.tag] ?? "not exist"
                    title = percent + (AppItemTable.getNameByItemId(itemId: 8408) ?? " ")
                    label.text = title
                }
            }
        }
    }
    
    func convertSpecialCharacters(string: String) -> String {
        var newString = string
        let char_dictionary = [
            "&lt;" : "<",
            "&gt;" : ">",
            ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
    
}
