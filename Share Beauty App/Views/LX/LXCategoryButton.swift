//
//  CategoryButton.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/23.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol LXCategoryButtonDelegate: NSObjectProtocol {
    func didTap(_ sender: LXCategoryButton)
}

class LXCategoryButton: BaseView {
    weak var delegate: LXCategoryButtonDelegate?
    @IBOutlet weak fileprivate var mBtnCategory: BaseButton!
    @IBOutlet weak var mVFooter: UIView!
    @IBOutlet weak var mConstraintHeight: NSLayoutConstraint!
    @IBInspectable var selected: Bool = false {
        didSet {
            mBtnCategory.isSelected = selected
            if selected {
                self.layer.borderWidth = 0
                mBtnCategory.backgroundColor = UIColor(red:0.67, green:0.67, blue:0.68, alpha:1.0)
                mBtnCategory.setTitleColor(UIColor.white, for: .selected)
                mConstraintHeight.constant = 2
            } else {
                mBtnCategory.layer.borderWidth = 1
                mBtnCategory.layer.borderColor = UIColor(red:0.65, green:0.60, blue:0.36, alpha:1.0).cgColor
                mBtnCategory.setTitleColor( UIColor(red:0.65, green:0.60, blue:0.36, alpha:1.0), for: .normal)
                mBtnCategory.backgroundColor = UIColor.black
                mConstraintHeight.constant = 0
            }
        }
    }
    @IBInspectable var enabled: Bool = true {
        didSet {
            mBtnCategory.isEnabled = enabled
            mVFooter.isHidden = !enabled
            if !enabled {
                mBtnCategory.layer.borderWidth = 1
                mBtnCategory.layer.borderColor = UIColor(red:0.67, green:0.67, blue:0.68, alpha:1.0).cgColor
                mBtnCategory.setTitleColor(UIColor(red:0.67, green:0.67, blue:0.68, alpha:1.0), for: .disabled)
                mBtnCategory.backgroundColor = UIColor.black
            } else {
                mBtnCategory.layer.borderWidth = 1
                mBtnCategory.layer.borderColor = UIColor(red:0.65, green:0.60, blue:0.36, alpha:1.0).cgColor
                mBtnCategory.setTitleColor( UIColor(red:0.65, green:0.60, blue:0.36, alpha:1.0), for: .normal)
                mBtnCategory.backgroundColor = UIColor.black
                mConstraintHeight.constant = 0
            }
        }
    }

    @IBInspectable var title: String? {
        didSet {
            if ((title?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {
                mBtnCategory.setTitle(title, for: UIControl.State())
            } else {
                
                mBtnCategory.titleLabel?.adjustsFontSizeToFitWidth = true
                let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size:15)
                let mBtnCategoryString: NSMutableAttributedString = NSMutableAttributedString(string: title!, attributes: [NSAttributedString.Key.font:font!])
                mBtnCategoryString.setAttributes([NSAttributedString.Key.font: font!,NSAttributedString.Key.baselineOffset: -1], range: NSRange(location:0,length: (title?.count)! ))
                mBtnCategory.titleLabel?.attributedText = mBtnCategoryString
                mBtnCategory.setTitle(title, for: UIControl.State())
                mBtnCategory.titleLabel?.lineBreakMode = .byTruncatingTail
            }
        }
    }

    @IBAction func onTapButton(_ sender: AnyObject) {
        delegate?.didTap(self)
    }
//    override func draw(_ rect: CGRect) {
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor(red:0.65, green:0.60, blue:0.36, alpha:1.0).cgColor
//        mBtnCategory.setTitleColor( UIColor(red:0.65, green:0.60, blue:0.36, alpha:1.0), for: .normal)
//        
//        if self.selected {
//            
//        } else if !self.enabled {
//            self.layer.borderWidth = 0
//            self.layer.borderColor = UIColor(red:0.67, green:0.67, blue:0.68, alpha:1.0).cgColor
//            mBtnCategory.setTitleColor(UIColor(red:0.67, green:0.67, blue:0.68, alpha:1.0), for: .normal)
//        }
//        
//        super.draw(rect)
//    }

}
