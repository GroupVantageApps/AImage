//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

// TODO: productID 620用なのでファイル名など適切に置き換え
import Foundation

class BNF619FirstTechView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        for index in 0...9 {
            let tag = index + 8323
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            if [2,3].contains(index) {
                let attrStr = NSMutableAttributedString(string: AppItemTable.getNameByItemId(itemId: tag) ?? "not exist")
                
                let font_color = UIColor(red: 136/255, green: 183/255, blue: 205/255, alpha: 1)
                let font_size = CGFloat(13.0)
                
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
                label2.textAlignment = .left
                label2.adjustsFontSizeToFitWidth = true
                
                self.addSubview(label2)
            } else {
                label.text = AppItemTable.getNameByItemId(itemId: tag)
                label.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
}
