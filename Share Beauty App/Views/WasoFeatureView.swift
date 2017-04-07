//
//  WasoFeatureView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import APNGKit


class WasoFeatureView: BaseView {
    @IBOutlet weak private var apngImageV: APNGImageView!
    @IBOutlet weak private var mRightImageV: UIImageView!
    @IBOutlet weak private var mVShake: UIView!
    @IBOutlet weak var mConstraintShakeCenter: NSLayoutConstraint!
    @IBOutlet weak var mConstraintShakeTop: NSLayoutConstraint!
    @IBOutlet weak private var mLblhukidashi: UILabel!

    private var mIsShowHukidashi = false

    deinit {
        apngImageV.startAnimating()
        apngImageV.image = nil
    }

    var apng: APNGImage? {
        didSet {
            if apng != nil {
                apngImageV.image = apng
            }
        }
    }
    var image: UIImage? {
        didSet {
            mRightImageV.image = image
        }
    }
    var hukidashiText: String? {
        didSet {
            mLblhukidashi.text = hukidashiText
        }
    }

    func startAnimation() {
        apngImageV.startAnimating()
    }

    private func showHukidashi() {
        if mIsShowHukidashi { return }

        mVShake.alpha = 0
        mConstraintShakeCenter.isActive = false
        mConstraintShakeTop.isActive = true
        self.layoutIfNeeded()

        mConstraintShakeTop.isActive = false
        mConstraintShakeCenter.isActive = true

        UIView.animateIgnoreInteraction(
            duration: 1,
            animations: {
                self.mVShake.alpha = 1
                self.layoutIfNeeded()
        }, completion: { _ in
            self.mIsShowHukidashi = true
        })
    }

    private func hideHukidashi() {
        if !mIsShowHukidashi { return }
        UIView.animateIgnoreInteraction(
            duration: 0.3,
            animations: {
                self.mVShake.alpha = 0
        }, completion: { _ in
            self.mIsShowHukidashi = false
        })
    }

    @IBAction func onTapImage(_ sender: Any) {
        self.showHukidashi()
    }

    @IBAction func onTapClose(_ sender: Any) {
        self.hideHukidashi()
    }
}
