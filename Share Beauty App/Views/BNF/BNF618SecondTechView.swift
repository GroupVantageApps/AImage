//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class BNF618SecondTechView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        for index in 0...11 {
            let tag = index + 8284
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            if [5,6].contains(index) {
                let attrStr = NSMutableAttributedString(string: AppItemTable.getNameByItemId(itemId: tag) ?? "not exist")
               
                attrStr.setFont(UIUtil.getReaderMedium(11))
                let shadow = NSShadow()
                shadow.shadowColor = UIColor.white
                shadow.shadowBlurRadius = 3.0
                
                attrStr.addAttribute(NSShadowAttributeName, value: shadow, range: NSMakeRange(0, attrStr.length))
                attrStr.addAttribute(NSStrokeWidthAttributeName, value: -5.0, range: NSMakeRange(0, attrStr.length))
                attrStr.addAttribute(NSStrokeColorAttributeName, value: UIColor.white, range: NSMakeRange(0, attrStr.length))
                
                label.attributedText = attrStr
                label.adjustsFontSizeToFitWidth = true
                
                let label2: UILabel = UILabel.init(frame: label.frame)
                
                let attrStr2 = NSMutableAttributedString(string: AppItemTable.getNameByItemId(itemId: tag) ?? "not exist")
                attrStr2.setFont(UIUtil.getReaderMedium(11))
                
                label2.attributedText = attrStr2
                label2.numberOfLines = 2
                label2.textAlignment = .center
                label2.adjustsFontSizeToFitWidth = true
                
                self.addSubview(label2)
                
            } else {
                label.text = AppItemTable.getNameByItemId(itemId: tag)
                label.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
}
