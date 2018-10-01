//
//  WasoMochiUsageView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoMochiUsageView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setView()
    }
    
    func setView() {

        let topMargin: CGFloat = 40
        let numHeight: CGFloat = (self.height - topMargin) / 5
        for index in 0...4 {
            
            let numLabel: UILabel = UILabel()
            numLabel.frame = CGRect(x: 220, y: numHeight * CGFloat(index) + topMargin, width: 0, height: 0)
            numLabel.text = "0\(index + 1)"
            numLabel.font = UIFont(name: "Reader-Bold", size: 70)
            numLabel.sizeToFit()
            
            let textLabel: UILabel = UILabel()
            textLabel.frame = CGRect(x: numLabel.right + 20, y: numLabel.top + 5, width: 350, height: 0)
            textLabel.text = AppItemTable.getNameByItemId(itemId: 8074 + index)
            textLabel.font = UIFont(name: "Reader", size: 15)
            textLabel.numberOfLines = 0
            textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            textLabel.sizeToFit()

            self.addSubview(numLabel)
            self.addSubview(textLabel)
        }
        
    }
}
