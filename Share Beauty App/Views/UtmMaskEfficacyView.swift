//
//  UtmMaskEfficacy.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/07/19.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class UtmMaskEfficacyView: UIView {
    
    @IBOutlet weak var mScrollV: UIScrollView!
    
    @IBOutlet weak var mGraphV: UIView!
    @IBOutlet weak var mPercentageV: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
        self.mScrollV.frame.size = CGSize(width: self.width, height: self.height)
        self.mScrollV.contentSize = CGSize(width: self.width, height: (self.height) * 2)
        self.mScrollV.isPagingEnabled = true
        self.mScrollV.bounces = false
        
        let image: UIImage = UIImage(named: "utm_mask_efficacy.png")!
        let imageV: UIImageView = UIImageView(image: image)
        imageV.frame = CGRect(x: 0, y: 0, width: self.mScrollV.width, height: self.mScrollV.height)
        imageV.contentMode = .scaleAspectFit
        self.mGraphV.addSubview(imageV)
//        self.mScrollV.addSubview(imageV)
        
        self.setPercentageContent()
    }
    
    private func setPercentageContent() {
        self.mPercentageV.frame = CGRect(x: 0, y: self.mScrollV.height, width: self.mScrollV.width, height: self.mScrollV.height)
        
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont(name: "Reader-Bold", size: 22)
        title.text = AppItemTable.getNameByItemId(itemId: 8011)
        title.frame = CGRect(x: 0, y: 30, width: 700, height: 40)
        title.centerX = self.mPercentageV.centerX
        title.textAlignment = .center
        self.mPercentageV.addSubview(title)
        
        for i in 0...2 {
            let percentLabel = UILabel()
            percentLabel.textColor = UIColor.black
            percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
            percentLabel.textAlignment = .center
            percentLabel.frame = CGRect(x: Int(self.mPercentageV.centerX) - 230, y: 110 + (130 * i), width: 160, height: 82)
            let perY = Int(percentLabel.frame.origin.y)
            
            let perTexts = ["86%", "89%", "86%"]

            percentLabel.text = perTexts[i]
            
            let description = UILabel()
            description.textColor = UIColor.black
            description.font = UIFont(name: "Reader", size: 20)
            description.numberOfLines = 0
            description.textAlignment = .left
            description.frame = CGRect(x: Int(self.mPercentageV.centerX) - 50, y: perY - 20, width: 350, height: 100)
            description.text = AppItemTable.getNameByItemId(itemId: 8011 + i + 1)
            
            self.mPercentageV.addSubview(percentLabel)
            self.mPercentageV.addSubview(description)
        }
        
        let text = UILabel()
        text.textColor = UIColor.lightGray
        text.font = UIFont(name: "Reader-Medium", size: 12)
        text.font = text.font.withSize(13)
        text.textAlignment = .center
        text.numberOfLines = 0
        text.frame = CGRect(x: 600, y: 500, width: 400, height: 60)
        text.text = AppItemTable.getNameByItemId(itemId: 8011 + 4)
        self.mPercentageV.addSubview(text)
        
//        self.mScrollV.addSubview(mPercentageV)
    }
}
