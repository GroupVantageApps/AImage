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
    
    @IBOutlet weak var mTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setView() {
        print("size before")
        print(mScrollV.frame)
        print(mScrollV.contentSize)
        print(mContentView.frame)
        print(mGraphV.frame)
        
        mScrollV.frame.size = CGSize(width: self.width, height: self.height)
        mScrollV.contentSize = CGSize(width: mScrollV.width, height: (mScrollV.height) * 4)
        mContentView.size = self.mScrollV.contentSize

        self.setPercentageContent()
        self.setGraphContent()

//        mScrollV.layer.borderWidth = 1
//        mContentView.layer.borderWidth = 1
//        mContentView.layer.setBorderUIColor(UIColor.red)
        print("size af")
        print(mScrollV.frame)
        print(mScrollV.contentSize)
        print(mContentView.frame)
        print(mGraphV.frame)
    }
    
    private func setGraphContent() {
        mGraphV.frame = CGRect(x: 0, y: mScrollV.height, width: mScrollV.width, height: mScrollV.height)
        
        let itemId = 8000
        mTitleLabel.text = AppItemTable.getNameByItemId(itemId: itemId)

        for i in 0...3 {
            let graphText = UILabel(frame: CGRect(x: 585, y: 150 + i*25, width: 0, height: 0))
            graphText.font = UIFont(name: "Reader", size: 15)
            graphText.text = AppItemTable.getNameByItemId(itemId: itemId + 2 + i)
            if i == 0 {
                graphText.frame.origin = CGPoint(x: 145, y: 167)
            } else if i == 2 {
                graphText.textColor = UIColor(hex: "C11029", alpha: 1.0)
            } else if i == 3 {
                graphText.text = AppItemTable.getNameByItemId(itemId: itemId + 3)
                graphText.frame.origin.y = 335
            }
            graphText.sizeToFit()
            mGraphV.addSubview(graphText)
        }
        
        for i in 0...4 {
            let graphAxis = UILabel(frame: CGRect(x: 125 + (i-1)*70, y: 397, width: 0, height: 0))
            graphAxis.font = UIFont(name: "Reader", size: 13)
            graphAxis.text = AppItemTable.getNameByItemId(itemId: itemId + 5 + i)
            if i == 0 {
                graphAxis.frame.origin = CGPoint(x: 80, y: 345)
            } else if i == 4 {
                graphAxis.frame.origin.x = 550
            }
            graphAxis.sizeToFit()
            mGraphV.addSubview(graphAxis)
        }
        
        let text = UILabel(frame: CGRect(x: 650, y: mGraphV.height - 30, width: 400, height: 0))
        text.font = UIFont(name: "Reader-Medium", size: 13)
        text.text = AppItemTable.getNameByItemId(itemId: itemId + 10)
        text.textColor = UIColor.lightGray
        text.textAlignment = .right
        text.numberOfLines = 0
        text.sizeToFit()
        mGraphV.addSubview(text)
        mContentView.addSubview(mGraphV)
    }
    
    private func setPercentageContent() {
        
        let itemId = 8011
        
        for page in 0...2 {
            var pageY: CGFloat = 0
            
            if page == 0 {
                pageY = 0
            } else {
                pageY = mScrollV.height * CGFloat(page) + mScrollV.height
            }
            
            let percentView: UIView = UIView(frame: CGRect(x: 0, y: pageY, width: mScrollV.width, height: mScrollV.height))
//            percentView.layer.borderWidth = 2
//            percentView.layer.setBorderUIColor(.blue)
            let title = UILabel(frame: CGRect(x: 0, y: 30, width: 700, height: 40))
            title.font = UIFont(name: "Reader-Bold", size: 22)
            title.text = AppItemTable.getNameByItemId(itemId: itemId)
            title.centerX = percentView.centerX
            title.textAlignment = .center
            percentView.addSubview(title)

            for i in 0...2 {
                let percentLabel = UILabel(frame: CGRect(x: Int(percentView.centerX) - 230, y: 110 + (130 * i), width: 160, height: 82))
                percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
                percentLabel.textAlignment = .center
                let perY = Int(percentLabel.frame.origin.y)
                let perTexts = [["90%", "83%", "86%"],
                                ["90%", "97%", "97%"],
                                ["86%", "90%", "97%"]
                                ]
                percentLabel.text = perTexts[page][i]
                
                let description = UILabel(frame: CGRect(x: Int(percentView.centerX) - 50, y: perY - 20, width: 350, height: 100))
                description.font = UIFont(name: "Reader", size: 20)
                description.text = AppItemTable.getNameByItemId(itemId: itemId + i + 1)
                description.numberOfLines = 0
                description.textAlignment = .left
                
                percentView.addSubview(percentLabel)
                percentView.addSubview(description)
            }
            
            let text = UILabel(frame: CGRect(x: percentView.width - 330, y: percentView.height - 50, width: 300, height: 40))
            text.font = UIFont(name: "Reader-Medium", size: 13)
            text.text = AppItemTable.getNameByItemId(itemId: itemId + 4)
            text.textColor = UIColor.lightGray
            text.textAlignment = .right
            text.numberOfLines = 0
            percentView.addSubview(text)
            
            mContentView.addSubview(percentView)
        }
    }
}
