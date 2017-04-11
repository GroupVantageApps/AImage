//
//  TroubleView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/10/02.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol LXTroubleSelectViewDelegate: LXProductDetailTagDelegate {
}

class LXTroubleSelectView: BaseView, LXProductDetailTagDelegate {
    @IBOutlet weak fileprivate var mVTagBase: UIView!

    var troubles: [DataStructTrouble] = [] {
        didSet {
            makeProductDetailTags()
        }
    }
    weak var delegate: LXTroubleSelectViewDelegate?
    fileprivate func makeProductDetailTags() {
        if mVTagBase.subviews.count != 0 {
            return
        }
        var productDetailTags: [LXProductDetailTag] = []
        var i = 0
        var mountView: UIView!

        for trouble in troubles {
            if i % 3 == 0 {
                mountView = UIView()
                mountView.translatesAutoresizingMaskIntoConstraints = false
                mVTagBase.addSubview(mountView)
            }
            let productDetailTag = LXProductDetailTag()
            productDetailTag.delegate = self
            productDetailTag.translatesAutoresizingMaskIntoConstraints = false
            productDetailTag.trouble = trouble
            mountView.addSubview(productDetailTag)
            productDetailTags.append(productDetailTag)
            i += 1
        }
        var constraints: [NSLayoutConstraint] = []
        for mountView in mVTagBase.subviews {
            let left = NSLayoutConstraint(item: mountView, attribute: .left, relatedBy: .equal, toItem: mVTagBase, attribute: .left, multiplier: 1.0, constant: 0)
            let right = NSLayoutConstraint(item: mountView, attribute: .right, relatedBy: .equal, toItem: mVTagBase, attribute: .right, multiplier: 1.0, constant: 0)
            constraints += [left, right]
            if mountView === mVTagBase.subviews.first {
                let top = NSLayoutConstraint(item: mountView, attribute: .top, relatedBy: .equal, toItem: mVTagBase, attribute: .top, multiplier: 1.0, constant: 0)
                constraints.append(top)
            }
            if mountView === mVTagBase.subviews.last {
                let bottom = NSLayoutConstraint(item: mVTagBase, attribute: .bottom, relatedBy: .equal, toItem: mountView, attribute: .bottom, multiplier: 1.0, constant: 30)
                constraints.append(bottom)
            } else {
                let bottom = NSLayoutConstraint(item: mVTagBase.subviews.after(mountView)!, attribute: .top, relatedBy: .equal, toItem: mountView, attribute: .bottom, multiplier: 1.0, constant: 10)
                constraints.append(bottom)
            }
            var mountViewConstraints: [NSLayoutConstraint] = []
            for productDetailTag in mountView.subviews {
                let top = NSLayoutConstraint(item: productDetailTag, attribute: .top, relatedBy: .equal, toItem: mountView, attribute: .top, multiplier: 1.0, constant: 0)
                let bottom = NSLayoutConstraint(item: productDetailTag, attribute: .bottom, relatedBy: .equal, toItem: mountView, attribute: .bottom, multiplier: 1.0, constant: 0)
                let width = NSLayoutConstraint(item: productDetailTag, attribute: .width, relatedBy: .equal, toItem: mountView, attribute: .width, multiplier: 1.0 / 3, constant: -(10 * 2 / 3))
                mountViewConstraints += [top, bottom, width]
                if productDetailTag === mountView.subviews.first {
                    let left = NSLayoutConstraint(item: productDetailTag, attribute: .left, relatedBy: .equal, toItem: mountView, attribute: .left, multiplier: 1.0, constant: 0)
                    mountViewConstraints.append(left)
                }
                if productDetailTag !== mountView.subviews.last {
                    let right = NSLayoutConstraint(item: mountView.subviews.after(productDetailTag)!, attribute: .left, relatedBy: .equal, toItem: productDetailTag, attribute: .right, multiplier: 1.0, constant: 10)
                    mountViewConstraints.append(right)
                }
            }
            mountView.addConstraints(mountViewConstraints)
        }
        mVTagBase.addConstraints(constraints)
    }
    func didTapTrouble(_ trouble: DataStructTrouble) {
        self.delegate?.didTapTrouble(trouble)
    }
}
