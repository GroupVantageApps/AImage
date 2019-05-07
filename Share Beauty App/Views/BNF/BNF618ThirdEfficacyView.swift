//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

// TODO: productID 619用なのでファイル名など適切に置き換え
import Foundation

class BNF618ThirdEfficacyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        for index in 0...7 {
            let tag = index + 8315
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            label.text = AppItemTable.getNameByItemId(itemId: tag)
            label.adjustsFontSizeToFitWidth = true
        }
    }
    
}
