//
//  WasoCleanserEfficacyView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/20.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoCleanserEfficacyView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var mViewPageOne: UIView!
    @IBOutlet weak var mViewPageTwo: UIView!
    @IBOutlet weak var mViewPageThree: UIView!
    @IBOutlet weak var mViewPageFour: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
        mViewPageTwo.frame = CGRect(x: 0, y: mScrollView.height, width: mScrollView.width, height: mScrollView.height)
        mViewPageThree.frame = CGRect(x: 0, y: mScrollView.height * 2, width: mScrollView.width, height: mScrollView.height)
        mViewPageFour.frame = CGRect(x: 0, y: mScrollView.height * 3, width: mScrollView.width, height: mScrollView.height)
    }
}
