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
    @IBOutlet weak private var mTroubleSelectView: TroubleSelectView!
    
    private var isOpen: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mTroubleSelectView.isHidden = true
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
        if isOpen == false {
            isOpen = true
            mTroubleSelectView.isHidden = false
            
        } else {
            isOpen = false
            mTroubleSelectView.isHidden = true
        }
    }
}
