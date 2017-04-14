//
//  NavigationView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/22.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol LXNavigationViewDelegte: NSObjectProtocol {
    func didTapPrev()
}

class LXNavigationView: BaseView {
    @IBOutlet weak fileprivate var mLblTheme: UILabel!
    @IBOutlet weak fileprivate var mConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak fileprivate var mVContent: UIView!
    
    @IBOutlet var mVNavi: UIView!
    @IBOutlet var mVLbl: UIView!
    weak var delegate: LXNavigationViewDelegte?
    var mIsEnter: Bool = false

    @IBAction func onTapPrev(_ sender: AnyObject) {
        delegate?.didTapPrev()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        mConstraintLeft.constant = 0
    }

    func setTheme(_ strTheme: String?) {
        mLblTheme.text = strTheme
    }

    func setTheme(_ strTheme: String?, duration: TimeInterval) {
        UIView.animateIgnoreInteraction(
            duration: duration / 2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.mLblTheme.alpha = 0
        },
            completion: {finished in
                self.mLblTheme.text = strTheme
                UIView.animateIgnoreInteraction(
                    duration: duration / 2,
                    delay: 0,
                    options: UIViewAnimationOptions.curveEaseOut,
                    animations: {
                        self.mLblTheme.alpha = 1
                },
                    completion: nil
                )
        })
    }

    func animateEnter(_ duration: TimeInterval, options: UIViewAnimationOptions) {
        if mIsEnter {
           return
        }
        mConstraintLeft.constant = 0
        mVContent.left = self.width
        UIView.animateIgnoreInteraction(
            duration: duration,
            delay: 0,
            options: options,
            animations: {
                self.layoutIfNeeded()},
            completion: {finished in
                self.mIsEnter = true
        })
    }

    func animateExit(_ duration: TimeInterval, options: UIViewAnimationOptions) {
        if !mIsEnter {
            return
        }

        mConstraintLeft.constant = self.width
        self.left = 0
        UIView.animateIgnoreInteraction(
            duration: duration,
            delay: 0,
            options: options,
            animations: {
                self.layoutIfNeeded()},
            completion: {finished in
                self.mIsEnter = false
        })
    }

    func show(_ show: Bool, animateDuration: TimeInterval?) {
        if animateDuration == nil {
            mVContent.alpha = CGFloat(show as NSNumber)
        } else {
            mVContent.alpha = CGFloat(!show as NSNumber)
            UIView.animateIgnoreInteraction(
                duration: animateDuration!,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.mVContent.alpha = CGFloat(show as NSNumber)
                },
                completion: nil
            )

        }
    }
    
    func changeUIforLX() {
        self.mVLbl.backgroundColor = UIColor.clear
        self.mVNavi.backgroundColor = UIColor.clear
    }
}
