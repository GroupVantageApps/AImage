//
//  UtmFeaturesView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol UtmFeaturesViewDelegate: NSObjectProtocol {
    func didTapTech()
    func didTapEfficacy()
}

class UtmFeaturesView: BaseView {
    @IBOutlet private var mImgVBalloons: [UIImageView]!
    @IBOutlet private var mImgVTexts: [UIImageView]!
    @IBOutlet private var mLblBalloons: [UILabel]!
    @IBOutlet private var mBtnTechs: [BaseButton]!
    @IBOutlet private var mBtnEfficacies: [BaseButton]!

    weak var delegate: UtmFeaturesViewDelegate?

    @IBInspectable var topPadding: CGFloat = 0 {
        didSet {
            mConstraintTop.constant = topPadding
        }
    }
    @IBInspectable var bottomPadding: CGFloat = 0 {
        didSet {
            mConstraintBottom.constant = bottomPadding
        }
    }
    @IBOutlet weak fileprivate var mConstraintTop: NSLayoutConstraint!
    @IBOutlet weak fileprivate var mConstraintBottom: NSLayoutConstraint!

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        let arrUtm = UIUtil.getUtmArray() as AnyObject as! [String]
        let arrIndexBalloon = [5, 6, 9]
        var i = 0
        mLblBalloons.forEach { mLblBalloon in
            mLblBalloon.text = arrUtm[arrIndexBalloon[i]]
            i += 1
        }
        mBtnTechs.forEach { btnTech in
            btnTech.setTitle(arrUtm[7], for: .normal)
        }
        mBtnEfficacies.forEach { btnTech in
            btnTech.setTitle(arrUtm[8], for: .normal)
        }
    }

    fileprivate func animateBalloon(_ index: Int, completion: ((Bool) -> ())?) {
        let mountView = mImgVBalloons[index].superview!
        let imgVBalloon = mImgVBalloons[index]
        for constraint in mountView.constraints {
            let firstItem = constraint.firstItem as! UIView
            if constraint.secondItem != nil {
                let secondItem = constraint.secondItem as! UIView
                if firstItem == imgVBalloon || secondItem == imgVBalloon {
                    constraint.constant = 0
                }
            }
        }
        UIView.animate(
            withDuration: 0.3,
            animations: {
                mountView.layoutIfNeeded()
            },
            completion: { (_) in
                UIView.animate(
                    withDuration: 0.3,
                    animations: {
                        self.mImgVTexts[index].alpha = 1
                    },
                    completion: { (_) in
                        completion?(true)
                    }
                )
            }
        )
    }

    func showAnimation() {
        animateBalloon(0) { (_) in
            self.animateBalloon(1, completion: { (_) in
                self.animateBalloon(2, completion:nil)
            })
        }
    }

    @IBAction func onTapTech(_ sender: AnyObject) {
        delegate?.didTapTech()
    }
    @IBAction func onTapEfficacy(_ sender: AnyObject) {
        delegate?.didTapEfficacy()
    }
}
