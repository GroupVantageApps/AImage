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
    
    init(id: Int, text: String) {
        super.init(frame: CGRect(x:0, y:0, width:290, height:95))
        self.beautySecondId = id
        
        let btnText = NSMutableAttributedString(string: text)
        self.setAttributedTitle(btnText, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel!.font = UIFont(name: "Reader-Bold", size: CGFloat(18))
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 5)
        self.titleLabel!.numberOfLines = 3
        // 折り返し
        self.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        // 行間調整
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        btnText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, btnText.length))
        
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
