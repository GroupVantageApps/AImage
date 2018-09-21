//
//  IdealSelectCell.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/13.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol IdealSelectCellDelegate: NSObjectProtocol {
    func didTapCell(_ sender: IdealSelectCell)
}

class IdealSelectCell: BaseView {
    @IBOutlet weak fileprivate var mVMain: UIView!
    @IBOutlet weak fileprivate var mLblTitle: UILabel!
    @IBOutlet weak fileprivate var mLblSubTitle: UILabel!
    @IBOutlet weak fileprivate var mImgVSelected: UIImageView!
    @IBOutlet weak fileprivate var mBtn: BaseButton!

    @IBOutlet weak fileprivate var mConstraintTopToBottom: NSLayoutConstraint!
    @IBOutlet weak fileprivate var mConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak fileprivate var mConstraintWidth: NSLayoutConstraint!

    @IBInspectable var titleFontSize: CGFloat = 20.0 {
        didSet {
            if #available(iOS 8.2, *) {
                mLblTitle.font = UIFont.systemFont(ofSize: titleFontSize, weight: UIFontWeightSemibold)
            } else {
                mLblTitle.font = UIFont.boldSystemFont(ofSize: titleFontSize)
            }
        }
    }
    @IBInspectable var subTitleFontSize: CGFloat = 14.0 {
        didSet {
            mLblSubTitle.font = UIFont.systemFont(ofSize: subTitleFontSize)
        }
    }
    @IBInspectable var showedSubTitle: Bool = true
    @IBInspectable var selected: Bool = false {
        didSet {
            var textColor: UIColor!
            var backgroundColor: UIColor!

            if selected {
                textColor = UIColor.white
                backgroundColor = UIColor(red255:219, green255:44, blue255:56, alpha:1.0)
            } else {
                textColor = UIColor.black
                backgroundColor = UIColor(red255:255, green255:255, blue255:255, alpha: mainViewAlpha)
            }
            mLblTitle.textColor = textColor
            mLblSubTitle.textColor = textColor
            mVMain.backgroundColor = backgroundColor
            mImgVSelected.isHidden = !selected
        }
    }
    @IBInspectable var enabled: Bool = true {
        didSet {
            mBtn.isEnabled = enabled
            var textColor: UIColor!
            var backgroundColor: UIColor!
            if enabled {
                textColor = UIColor.black
                backgroundColor = UIColor(red255:255, green255:255, blue255:255, alpha: mainViewAlpha)
            } else {
                textColor = UIColor(red255:0, green255:0, blue255:0, alpha: 0.1)
                backgroundColor = UIColor(red255:200, green255:200, blue255:200, alpha: mainViewAlpha)
            }
            mLblTitle.textColor = textColor
            mLblSubTitle.textColor = textColor
            mVMain.backgroundColor = backgroundColor
        }
    }
    @IBInspectable var titleText: String? {
        didSet {
            mLblTitle.text = titleText
        }
    }
    @IBInspectable var subTitleText: String? {
        didSet {
            mLblSubTitle.text = subTitleText
        }
    }
    @IBInspectable var selectedImgSize: CGFloat = 27 {
        didSet {
            mConstraintWidth.constant = selectedImgSize
        }
    }

    @IBInspectable var mainViewAlpha: CGFloat = 0.5 {
        didSet {
            mVMain.backgroundColor = UIColor(red255:255, green255:255, blue255:255, alpha: mainViewAlpha)
        }
    }

    var line: DataStructLine? {
        didSet {
            titleText = line?.target
            subTitleText = line?.name
            if(line?.lineId == 17 && line?.target == "") {
                titleText = line?.name
                subTitleText = ""
            }
        }
    }

    var stepLower: DataStructStepLower? {
        didSet {
            titleText = stepLower?.name
        }
    }

    weak var delegate: IdealSelectCellDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        showSubTitle(showedSubTitle)
    }

    fileprivate func showSubTitle(_ show: Bool) {
        mLblSubTitle.isHidden = !show

        if show {
            mConstraintBottom.isActive = false
            mConstraintTopToBottom.isActive = true
        } else {
            mConstraintTopToBottom.isActive = false
            mConstraintBottom.isActive = true
        }
    }
    @IBAction func onTapCell(_ sender: AnyObject) {
        delegate?.didTapCell(self)
    }
}
