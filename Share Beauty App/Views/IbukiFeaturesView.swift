//
//  UtmFeaturesView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class IbukiFeaturesView: BaseView, CAAnimationDelegate {

    weak var delegate: UtmFeaturesViewDelegate?

    @IBOutlet weak private var mImgStar: UIView!

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
    @IBOutlet weak private var mConstraintTop: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak private var mBtnEfficacy: BaseButton!

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        let arrUtm = UIUtil.getUtmArray() as AnyObject as! [String]
        mBtnEfficacy.setTitle(arrUtm[8], for: .normal)
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.animate()
    }

    @objc fileprivate func animate() {
        let fadein = CABasicAnimation(keyPath: "opacity")
        fadein.toValue = NSNumber(value: 0)
        fadein.duration = 0.5
        fadein.delegate = self
        fadein.repeatCount = 4
        fadein.autoreverses = true
        fadein.isRemovedOnCompletion = false
        mImgStar.layer.add(fadein, forKey: "alpha")
    }

    @IBAction func onTapEfficacy(_ sender: AnyObject) {
        delegate?.didTapEfficacy()
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == mImgStar.layer.animation(forKey: "alpha") {
            mImgStar.layer.removeAnimation(forKey: "alpha")
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.animate), userInfo: nil, repeats: false)
        }
    }
}
