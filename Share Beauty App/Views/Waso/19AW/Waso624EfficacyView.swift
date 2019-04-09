//
//  WasoMochiEfficacyView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import APNGKit

class Waso624EfficacyView: UIView {
    
    @IBOutlet weak var mContentView: UIView!
    @IBOutlet weak var mApngImageV: APNGImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mApngImageV.image = APNGImage(named: "graph_anim_624.png")
        for index in 0...4 {
            let tag = index + 8402
            let label: UILabel = self.viewWithTag(tag) as! UILabel
            label.text = AppItemTable.getNameByItemId(itemId: tag)
            label.adjustsFontSizeToFitWidth = true
        }
    }
    
    func startAnimation() {
        mApngImageV.startAnimating()
    }
    
}
