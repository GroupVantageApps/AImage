//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class Waso623TechView: UIView {
    
    @IBOutlet var techView: [UIView]!
    @IBOutlet weak var mTechView: UIView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setView()
    }
    
    func setView() {
        for index in 0...7 {
            let tag = index + 8377
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            label.text = AppItemTable.getNameByItemId(itemId: tag)
            label.adjustsFontSizeToFitWidth = true
            if [2,4,6].contains(index) {
            label.textColor = UIColor.init(hex: "C20022", alpha: 1.0)
            }
        }
        let tag = 8407
        let label: UILabel = self.viewWithTag(tag) as! UILabel
        label.text = AppItemTable.getNameByItemId(itemId: tag)
    }
    
}
