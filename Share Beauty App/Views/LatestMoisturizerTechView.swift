//
//  LatestMoisturizerTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LatestMoisturizerTechView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mFirstView: UIView!
    @IBOutlet weak var mSecondView: UIView!
    @IBOutlet weak var mThirdView: UIView!
    private var productId: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView(productId: Int) {
        self.productId = productId
        self.setFirstView()
        self.setSecondView()
        self.setThirdView()
    }
    
    func setFirstView() {
        
    }
    func setSecondView() {
        let imageV: UIImageView = UIImageView(frame: mScrollView.frame)
        let imageName: String
        
        if productId == 602 || productId == 614 || productId == 605 || productId == 604 {
            imageName = "moisture_effi_02_01"
        } else {
            imageName = "moisture_effi_02_02"
        }
        
        let image: UIImage = UIImage(named: imageName)!
        
        imageV.contentMode = UIViewContentMode.scaleAspectFit
        imageV.image = image
        mSecondView.addSubview(imageV)
    }
    func setThirdView() {
        let imageV: UIImageView = UIImageView(frame: mScrollView.frame)
        let image: UIImage = UIImage(named: "moisture_effi_\(productId)")!
        
        imageV.contentMode = UIViewContentMode.scaleAspectFit
        imageV.image = image
        mThirdView.addSubview(imageV)
    }
}
