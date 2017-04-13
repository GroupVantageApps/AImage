//
//  ProductDetailSkinConcernView.swift
//  Share Beauty App
//
//  Created by 青木幸司 on 2017/04/13.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class ProductDetailSkinConcernView: UIView {

    @IBOutlet weak private var mVSkinConcernLabel: UIView!
    @IBOutlet weak private var openButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var troubles: [DataStructTrouble] = [] {
        didSet {
            if troubles.count == 0 {
                mVSkinConcernLabel.isHidden = true
                openButton.isHidden = true
            }
        }
    }
    
    @IBAction func onTapOpen(_ sender: AnyObject) {
        Utility.log("onTapOpen")
    }
}
