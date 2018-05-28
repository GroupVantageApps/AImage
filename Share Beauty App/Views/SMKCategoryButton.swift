//
//  SMKCategoryButton.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/05/28.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//
import UIKit

class SMKCategoryButton: UIButton {
    public private(set) var beautySecondId: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x:0, y:0, width:290, height:95))
    }
    
    init(_ id: Int) {
        super.init(frame: CGRect(x:0, y:0, width:290, height:95))
       
        self.beautySecondId = id
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel!.font = UIFont(name: "Reader-Medium", size: CGFloat(17.7))
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayoutBtnText() {
        if SMBKCategoryViewController.mDefaultList.contains(self.beautySecondId) {
            switch self.beautySecondId {
            case 34:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 60, 0, 0);
            case 35:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 93, 0, 0);
                self.titleLabel?.numberOfLines = 2
            case 41:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 36, 0, 0);
            // Powder
            case 39:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 60, 0, 0);
            case 38:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 43, 0, 0);
                // 行間指定
//                self.titleLabel?.numberOfLines = 2
//                let attributedText = NSMutableAttributedString(string: (self.titleLabel?.text)!)
//                let paragraphStyle = NSMutableParagraphStyle()
//                paragraphStyle.lineHeightMultiple = 1.3
//                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
//                self.setAttributedTitle(attributedText, for: .normal)
                
            case 40:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 62, 0, 0);
            case 37:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 89, 0, 0);
            // Concealer
            case 42:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, 60, 0, 0);
            case 70:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, -29, 0, 0);
            case 71:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, -29, 0, 0);
            case 72:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, -33, 0, 0);
            case 73:
                self.titleEdgeInsets = UIEdgeInsetsMake(7, -16, 0, 0);
            default:
                fatalError("not correct category is contains")
            }
        }
    }
}
