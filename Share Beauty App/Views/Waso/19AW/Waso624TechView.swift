//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class Waso624TechView: UIView {
    
    @IBOutlet var techView: [UIView]!
    @IBOutlet weak var mTechView: UIView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setView()
    }
    
    func setView() {
        for index in 0...9 {
            let tag = index + 8391
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            label.text = AppItemTable.getNameByItemId(itemId: tag)
            if [2,4,6,8].contains(index) {
            label.textColor = UIColor.init(hex: "C20022", alpha: 1.0)
                label.adjustsFontSizeToFitWidth = true
            }
        }
        let tag = 8401
        let label: UILabel = self.viewWithTag(tag) as! UILabel
        label.text = AppItemTable.getNameByItemId(itemId: tag)
    }
    
}
