//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoMochiTechView: UIView {
    
    @IBOutlet weak var mViewPageThree: UIView!
    
    @IBOutlet weak var mTechView: UIView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setView()
    }
    
    func setView() {
        //mTitleLabel.text = AppItemTable.getNameByItemId(itemId: 0000)
        //mSubTitle.text = AppItemTable.getNameByItemId(itemId: 0000)
        
        let margin: CGFloat = 60
        var thermoX: CGFloat = 0
        let thermoWidth: CGFloat = 200
        let thermoHeight: CGFloat = 270
        
        for index in 0...1 {
            let thermographImageV: UIImageView = UIImageView(frame: CGRect(x: thermoX + margin, y: 30, width: thermoWidth, height: thermoHeight))
            thermographImageV.backgroundColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.5)
            
            //let image: UIImage = UIImage(named: "waso_87.png")!
            //thermographImageV.image = image
            thermographImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let thermoLabel: UILabel = UILabel(frame: CGRect(x: 0, y: thermographImageV.bottom + 10, width: thermoWidth, height: 0))
            thermoLabel.text = "3 min. after removing the mask\(index)."
            thermoLabel.font = UIFont(name: "Reader-Medium", size: 16)
            thermoLabel.textAlignment = .center
            thermoLabel.numberOfLines = 0
            thermoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            thermoX = thermographImageV.right
            thermoLabel.sizeToFit()
            thermoLabel.centerX = thermographImageV.centerX
            
            mTechView.addSubview(thermographImageV)
            mTechView.addSubview(thermoLabel)
        }
        
        let graphParamImageV: UIImageView = UIImageView(frame: CGRect(x: thermoX + 30, y: 30, width: 20, height: thermoHeight))
        graphParamImageV.backgroundColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.5)
        //let image: UIImage = UIImage(named: "waso_87.png")!
        //graphParamImageV.image = image
        graphParamImageV.contentMode = UIViewContentMode.scaleAspectFit
        mTechView.addSubview(graphParamImageV)
        
        for index in 0...2 {
            let frame: CGRect = CGRect(x: graphParamImageV.left - 5, y: 0, width: 0, height: 0)
            let paramLabel: UILabel = UILabel(frame: frame)
            
            if index == 0 {
                paramLabel.origin.y = 10
            } else if index == 1 {
                paramLabel.origin.x = graphParamImageV.right + 10
                paramLabel.centerY = graphParamImageV.centerY
            } else {
                paramLabel.origin.y = graphParamImageV.bottom + 10
            }
            paramLabel.text = "param\(index)."
            paramLabel.font = UIFont(name: "Reader", size: 15)
            
            paramLabel.sizeToFit()
            mTechView.addSubview(paramLabel)
        }
        
        let directImageV: UIImageView = UIImageView(frame: CGRect(x: thermoWidth + margin, y:0, width: margin, height: 80))
        directImageV.backgroundColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.5)
        directImageV.centerY = graphParamImageV.centerY
        //let image: UIImage = UIImage(named: "waso_87.png")!
        //directImageV.image = image
        directImageV.contentMode = UIViewContentMode.scaleAspectFit
        mTechView.addSubview(directImageV)
    }
    
}
