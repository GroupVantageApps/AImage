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
    
    let mUtmArr = LanguageConfigure.utmcsv

    weak var delegate: UtmFeaturesViewDelegate?
    var isNewUtm: Bool = false
    
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
        var arrIndexBalloon = [5, 6, 9]
        if isNewUtm {
            arrIndexBalloon = [5, 6]
        }
        var i = 0
        mLblBalloons.forEach { mLblBalloon in
            if isNewUtm && i == 1 {
                //TODO csv参照
                mLblBalloon.text = mUtmArr["41"]
                i += 1
            } else if !(isNewUtm && i == 2) {
                mLblBalloon.text = arrUtm[arrIndexBalloon[i]]
                i += 1
            }
        }
        if isNewUtm {
            mBtnTechs.forEach { btnTech in
                btnTech.superview?.isHidden = true
            }
            mBtnEfficacies.forEach { btnTech in
                btnTech.superview?.isHidden = true
            }
        } else {
            mBtnTechs.forEach { btnTech in
                btnTech.setTitle(arrUtm[7], for: .normal)
            }
            mBtnEfficacies.forEach { btnTech in
                btnTech.setTitle(arrUtm[8], for: .normal)
            }
        }
    }

    fileprivate func animateBalloon(_ index: Int, completion: ((Bool) -> ())?) {
        let mountView = mImgVBalloons[index].superview!
        let imgVBalloon = mImgVBalloons[index]
        if isNewUtm && index == 1{
            self.mImgVTexts[index].image = UIImage.init(named: "f_effect_2_new")
        }
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
                if !self.isNewUtm {
                    self.animateBalloon(2, completion:nil)
                }
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
