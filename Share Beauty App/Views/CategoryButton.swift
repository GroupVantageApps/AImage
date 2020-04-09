//
//  CategoryButton.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/23.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol CategoryButtonDelegate: NSObjectProtocol {
    func didTap(_ sender: CategoryButton)
}

class CategoryButton: BaseView {
    weak var delegate: CategoryButtonDelegate?
    @IBOutlet weak fileprivate var mBtnCategory: BaseButton!
    @IBOutlet weak var mVFooter: UIView!
    @IBOutlet weak var mConstraintHeight: NSLayoutConstraint!
    @IBInspectable var selected: Bool = false {
        didSet {
            mBtnCategory.isSelected = selected
            if selected {
                mConstraintHeight.constant = 2
            } else {
                mConstraintHeight.constant = 0
            }
        }
    }
    @IBInspectable var enabled: Bool = true {
        didSet {
            mBtnCategory.isEnabled = enabled
            mVFooter.isHidden = !enabled
        }
    }

    @IBInspectable var title: String? {
        didSet {
            mBtnCategory.setTitle(title, for: UIControl.State())
        }
    }

    @IBAction func onTapButton(_ sender: AnyObject) {
        delegate?.didTap(self)
    }
}
