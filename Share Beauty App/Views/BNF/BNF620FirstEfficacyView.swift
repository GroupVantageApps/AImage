//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

// TODO: productID 620用なのでファイル名など適切に置き換え
import Foundation

class BNF619FirstEfficacyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        for index in 0...5 {
            let tag = index + 8353
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            var title = self.convertSpecialCharacters(string: AppItemTable.getNameByItemId(itemId: tag) ?? "not exist")
            label.text = title
            label.adjustsFontSizeToFitWidth = true
            
            if index == 5 {
                title = self.convertSpecialCharacters(string: AppItemTable.getNameByItemId(itemId: 8375) ?? "not exist")
                label.text = title
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
