//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

// TODO: productID 620用なのでファイル名など適切に置き換え
import Foundation

class BNF619ThirdTechView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView() {
        for index in 0...19 {
            let tag = index + 8333
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            label.text = AppItemTable.getNameByItemId(itemId: tag)
            label.adjustsFontSizeToFitWidth = true
            if [5,6,8].contains(index) {
                let label: UILabel = self.viewWithTag(tag + 1000) as! UILabel
                label.text = AppItemTable.getNameByItemId(itemId: tag)
                label.adjustsFontSizeToFitWidth = true
                
                let label2: UILabel = self.viewWithTag(tag + 2000) as! UILabel
                label2.text = AppItemTable.getNameByItemId(itemId: tag)
                label2.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
}
