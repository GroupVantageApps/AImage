//
//  WasoCleanserEfficacyView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/20.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import APNGKit

class WasoCleanserEfficacyView: UIView {
    
    @IBOutlet weak var mEfficacyView: UIView!
    @IBOutlet weak var mApngImageV: APNGImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setView()
        mApngImageV.image = APNGImage(named: "cleanser_efficacy.png")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        mApngImageV.startAnimating()
    }
    
    func setView() {
        
        for index in 0...3 {
            
            let circleLabel: UILabel = UILabel()
            circleLabel.frame = CGRect(x: 0, y: 350, width: 150, height: 0)
            circleLabel.text = AppItemTable.getNameByItemId(itemId: 8025 + index)//"a" //AppItemTable.getNameByItemId(itemId: 8069 + index)
            circleLabel.font = UIFont(name: "Reader-Medium", size: 17)
            circleLabel.textAlignment = .center
            circleLabel.numberOfLines = 0
            circleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleLabel.sizeToFit()
            circleLabel.centerX = 138 + 250 * CGFloat(index)
            
            mEfficacyView.addSubview(circleLabel)
        }
    }

}
