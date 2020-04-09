//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoMochiTechView: UIView {
    
    @IBOutlet weak var mTechView: UIView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setView()
    }
    
    func setView() {
        //mTitleLabel.text = AppItemTable.getNameByItemId(itemId: 0000)
        mSubTitle.text = AppItemTable.getNameByItemId(itemId: 8063)

        let thermographImageV: UIImageView = UIImageView()
        thermographImageV.frame = CGRect(x: 0, y: 30, width: mTechView.width - 100, height: 290)
        let image: UIImage = UIImage(named: "mochi_thermography.png")!
        thermographImageV.image = image
        thermographImageV.contentMode = UIView.ContentMode.scaleAspectFit
        thermographImageV.centerX = mTechView.width / 2
        mTechView.addSubview(thermographImageV)
        
        for index in 0...1 {
            let thermoLabel: UILabel = UILabel(frame: CGRect(x: 0, y: thermographImageV.bottom + 5, width: 200, height: 0))
            thermoLabel.text = AppItemTable.getNameByItemId(itemId: 8064 + index)
            thermoLabel.font = UIFont(name: "Reader-Medium", size: 16)
            thermoLabel.textAlignment = .center
            thermoLabel.numberOfLines = 0
            thermoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            thermoLabel.sizeToFit()
            thermoLabel.centerX = 160 + CGFloat(index) * 260

            mTechView.addSubview(thermoLabel)
        }
        
        for index in 0...2 {
            let paramLabel: UILabel = UILabel()
            paramLabel.text = AppItemTable.getNameByItemId(itemId: 8066 + index)
            paramLabel.font = UIFont(name: "Reader", size: 15)
            paramLabel.sizeToFit()
            if index == 0 {
                paramLabel.centerX = thermographImageV.right - 15
                paramLabel.bottom = thermographImageV.top - 5
            } else if index == 1 {
                paramLabel.origin.x = thermographImageV.right + 5
                paramLabel.centerY = thermographImageV.centerY
            } else {
                paramLabel.centerX = thermographImageV.right - 15
                paramLabel.top = thermographImageV.bottom + 5
            }
            mTechView.addSubview(paramLabel)
        }
    }
    
}
