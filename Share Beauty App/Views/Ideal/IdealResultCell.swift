//
//  IdealResultCell.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/13.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//r

import UIKit

protocol IdealResultCellDelegate: NSObjectProtocol {
    func didTapCell(_ sender: IdealResultCell)
}

class IdealResultCell: BaseView {
    @IBOutlet weak fileprivate var mVMain: UIView!
    @IBOutlet weak fileprivate var mVSelect: UIView!
    @IBOutlet weak fileprivate var mLblTitle: UILabel!
    @IBOutlet weak fileprivate var mLblSubTitle: UILabel!

    @IBOutlet weak fileprivate var mConstraintTopToBottom: NSLayoutConstraint!
    @IBOutlet weak fileprivate var mConstraintBottom: NSLayoutConstraint!

    @IBInspectable var titleFontSize: CGFloat = 20.0 {
        didSet {
            if #available(iOS 8.2, *) {
                mLblTitle.font = UIFont.systemFont(ofSize: titleFontSize, weight: UIFont.Weight.semibold)
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
            mVSelect.isHidden = !selected
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

    @IBInspectable var mainViewAlpha: CGFloat = 0.5 {
        didSet {
            mVMain.backgroundColor = UIColor(red255:255, green255:255, blue255:255, alpha: mainViewAlpha)
        }
    }

    var line: DataStructLine? {
        didSet {
            titleText = line?.target
            subTitleText = line?.name
        }
    }

    var stepLower: DataStructStepLower? {
        didSet {
            titleText = stepLower?.name
        }
    }

    weak var delegate: IdealResultCellDelegate?

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
