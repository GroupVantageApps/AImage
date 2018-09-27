//
//  WasoCleanserEfficacyView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/20.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoCleanserEfficacyView: UIView {
    
    @IBOutlet weak var mEfficacyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
        
        let circleW = mEfficacyView.width / 4
        let margin = (circleW - 160) / 2
        
        for index in 0...3 {
            let circleImageV: UIImageView = UIImageView(frame: CGRect(x: circleW * CGFloat(index) + margin, y: 130, width: 160, height: 160))
            
            let image: UIImage = UIImage(named: "waso_87.png")!
            circleImageV.image = image
            circleImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let circleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: circleImageV.bottom + 15, width: circleImageV.width + 30, height: 0))
            circleLabel.text = "My skin became silky-smooth\(index)."
            circleLabel.font = UIFont(name: "Reader-Medium", size: 17)
            circleLabel.textAlignment = .center
            circleLabel.numberOfLines = 0
            circleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleLabel.sizeToFit()
            circleLabel.centerX = circleImageV.centerX
            
            mEfficacyView.addSubview(circleImageV)
            mEfficacyView.addSubview(circleLabel)
        }
    }

}
