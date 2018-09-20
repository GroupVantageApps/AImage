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
    @IBOutlet weak var mContentView: UIView!
    @IBOutlet weak var mGraphV: UIView!
    @IBOutlet weak var mPercentageV: UIView!
    
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
        self.mScrollV.frame.size = CGSize(width: self.width, height: self.height)
        self.mScrollV.contentSize = CGSize(width: self.width, height: (self.height) * 2)
        self.mContentView.size = self.mScrollV.contentSize
        self.mScrollV.isPagingEnabled = true
        self.mScrollV.bounces = false
        
        self.setGraphContent()
        self.setPercentageContent()
    }
    
    private func setGraphContent() {
        self.mGraphV.frame = CGRect(x: 0, y: 0, width: self.mScrollV.width, height: self.mScrollV.height)
        
        let itemId = 8000
        self.mTitleLabel.text = AppItemTable.getNameByItemId(itemId: itemId)

        let attributedText = NSMutableAttributedString(string: AppItemTable.getNameByItemId(itemId: itemId + 1)!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        mSubTextLabel.attributedText = attributedText
        
        for i in 0...3 {
            let graphText = UILabel(frame: CGRect(x: 585, y: 230 + i*25, width: 0, height: 0))
            graphText.font = UIFont(name: "Reader", size: 15)
            graphText.text = AppItemTable.getNameByItemId(itemId: itemId + 2 + i)
            if i == 0 {
                graphText.frame.origin = CGPoint(x: 145, y: 247)
            } else if i == 2 {
                graphText.textColor = UIColor(hex: "C11029", alpha: 1.0)
            } else if i == 3 {
                graphText.text = AppItemTable.getNameByItemId(itemId: itemId + 3)
                graphText.frame.origin.y = 415
            }
            graphText.sizeToFit()
            self.mGraphV.addSubview(graphText)
        }
        
        for i in 0...4 {
            let graphAxis = UILabel(frame: CGRect(x: 125 + (i-1)*70, y: 477, width: 0, height: 0))
            graphAxis.font = UIFont(name: "Reader", size: 13)
            graphAxis.text = AppItemTable.getNameByItemId(itemId: itemId + 5 + i)
            if i == 0 {
                graphAxis.frame.origin = CGPoint(x: 80, y: 425)
            } else if i == 4 {
                graphAxis.frame.origin.x = 550
            }
            graphAxis.sizeToFit()
            self.mGraphV.addSubview(graphAxis)
        }
        
        let text = UILabel(frame: CGRect(x: 650, y: self.mGraphV.height - 30, width: 400, height: 0))
        text.font = UIFont(name: "Reader-Medium", size: 13)
        text.text = AppItemTable.getNameByItemId(itemId: itemId + 10)
        text.textColor = UIColor.lightGray
        text.textAlignment = .right
        text.numberOfLines = 0
        text.sizeToFit()
        self.mGraphV.addSubview(text)
    }
    
    private func setPercentageContent() {
        self.mPercentageV.frame = CGRect(x: 0, y: self.mScrollV.height, width: self.mScrollV.width, height: self.mScrollV.height)
        
        let itemId = 8011

        let title = UILabel(frame: CGRect(x: 0, y: 30, width: 700, height: 40))
        title.font = UIFont(name: "Reader-Bold", size: 22)
        title.text = AppItemTable.getNameByItemId(itemId: itemId)
        title.centerX = self.mPercentageV.centerX
        title.textAlignment = .center
        self.mPercentageV.addSubview(title)
        
        for i in 0...2 {
            let percentLabel = UILabel(frame: CGRect(x: Int(self.mPercentageV.centerX) - 230, y: 110 + (130 * i), width: 160, height: 82))
            percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
            percentLabel.textAlignment = .center
            let perY = Int(percentLabel.frame.origin.y)
            let perTexts = ["86%", "89%", "86%"]
            percentLabel.text = perTexts[i]
            
            let description = UILabel(frame: CGRect(x: Int(self.mPercentageV.centerX) - 50, y: perY - 20, width: 350, height: 100))
            description.font = UIFont(name: "Reader", size: 20)
            description.text = AppItemTable.getNameByItemId(itemId: itemId + i + 1)
            description.numberOfLines = 0
            description.textAlignment = .left
            
            self.mPercentageV.addSubview(percentLabel)
            self.mPercentageV.addSubview(description)
        }
        
        let text = UILabel(frame: CGRect(x: self.mPercentageV.width - 330, y: self.mPercentageV.height - 50, width: 300, height: 40))
        text.font = UIFont(name: "Reader-Medium", size: 13)
        text.text = AppItemTable.getNameByItemId(itemId: itemId + 4)
        text.textColor = UIColor.lightGray
        text.textAlignment = .right
        text.numberOfLines = 0
        self.mPercentageV.addSubview(text)

    }
}
