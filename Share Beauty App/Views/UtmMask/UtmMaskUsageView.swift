//
//  UtmMaskUsageView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/20.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class UtmMaskUsageView: UIView {
    
    @IBOutlet weak var mUsageView: UIView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mTextOne: UILabel!
    @IBOutlet weak var mTextTwo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
        self.mUsageView.frame.size = CGSize(width: self.width, height: self.height)
//        mTitle.layer.borderWidth = 1
//        mTextOne.layer.borderWidth = 1
//        mTextTwo.layer.borderWidth = 1
        mTitle.sizeToFit()
        mTextOne.sizeToFit()
        mTextTwo.sizeToFit()
    }
}
