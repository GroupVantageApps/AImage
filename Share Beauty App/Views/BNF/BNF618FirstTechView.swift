//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class BNF618FirstTechView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        for index in 0...7 {
            let tag = index + 8276
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            if [3,4,5,6].contains(index) {
                let attrStr = NSMutableAttributedString(string: AppItemTable.getNameByItemId(itemId: tag) ?? "not exist")
                
                var font_color = UIColor(red: 136/255, green: 183/255, blue: 205/255, alpha: 1)
                var font_size = CGFloat(18.0)
                if index == 4 {
                    font_color = UIColor(red: 109/255, green: 187/255, blue: 192/255, alpha: 1)
                    font_size = CGFloat(30.0)
                }
                attrStr.setFont(UIUtil.getReaderBold(font_size))
                attrStr.setTextColor(UIColor.white)
                let shadow = NSShadow()
                shadow.shadowColor = UIColor.gray
                shadow.shadowBlurRadius = 5.0
                
                attrStr.addAttribute(NSShadowAttributeName, value: shadow, range: NSMakeRange(0, attrStr.length))
                
                label.attributedText = attrStr
                label.adjustsFontSizeToFitWidth = true
                
                let label2: UILabel = UILabel.init(frame: label.frame)
                
                let attrStr2 = NSMutableAttributedString(string: AppItemTable.getNameByItemId(itemId: tag) ?? "not exist")
                attrStr2.setFont(UIUtil.getReaderBold(font_size))
                attrStr2.setTextColor(UIColor.white)
                
                
                attrStr2.addAttribute(NSStrokeWidthAttributeName, value: -5.0, range: NSMakeRange(0, attrStr.length))
                attrStr2.addAttribute(NSStrokeColorAttributeName, value: font_color, range: NSMakeRange(0, attrStr.length))
                
                label2.attributedText = attrStr2
                label2.textAlignment = .center
                label2.adjustsFontSizeToFitWidth = true
                
                self.addSubview(label2)
            } else {
                label.text = AppItemTable.getNameByItemId(itemId: tag)
                label.adjustsFontSizeToFitWidth = true
            }
        }
//        let tag = 8407
//        let label: UILabel = self.viewWithTag(tag) as! UILabel
//        label.text = AppItemTable.getNameByItemId(itemId: tag)
    }
    
}
