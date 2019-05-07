//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class BNF619ThirdEfficacyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        for subView in self.subviews {
            if type(of: subView) == UILabel.self {
                let label: UILabel = subView as! UILabel
                var title = AppItemTable.getNameByItemId(itemId: label.tag)
                label.text = title
                label.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
}
