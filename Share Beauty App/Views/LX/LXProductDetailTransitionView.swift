//
//  ProductDetailTransitionView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/01/08.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LXProductDetailTransitionData {
    var title: String
    var selector: Selector
    init(title: String, selector: Selector) {
        self.title = title
        self.selector = selector
    }
}

class LXProductDetailTransitionView: BaseView {

    @IBOutlet private weak var mVContent: UIView!
    @IBOutlet private var mVMount: UIView!
    @IBOutlet private var mVLikeIt: UIView!
    @IBOutlet private weak var mBtnLikeIt: BaseButton!
    @IBOutlet private weak var mLblLikeIt: UILabel!
    @IBOutlet private var mBtnTemplate: BaseButton!

    var cellHeight: CGFloat! {
        didSet {
            if self.superview == nil {return}
            let height = self.cellHeight * CGFloat(mVContent.subviews.count) + space * CGFloat(mVContent.subviews.count - 1)
            if let heightConstraint = NSLayoutConstraint.findHeight(self.superview!.constraints, item: self) {
                heightConstraint.constant = height
            } else {
                self.superview!.addConstraint(NSLayoutConstraint.makeHeight(item: self, constant: height))
            }
        }
    }

    var space: CGFloat = 10

    func setLikeItSelector(_ selector: Selector, target: Any?) {
        mBtnLikeIt.addTarget(target, action: selector, for: .touchUpInside)
    }

    func isLikeItSelected(isSelected: Bool) {
        mBtnLikeIt.isSelected = isSelected
    }

    func setLikeItText(text: String?) {
        mLblLikeIt.text = text
    }

    func setProductDetailTransitionData(_ datas: [LXProductDetailTransitionData], target: Any?) {

        mVContent.subviews.forEach {$0.removeFromSuperview()}
        mVContent.removeConstraints(mVContent.constraints)

        var views = [UIView]()

        mVLikeIt.translatesAutoresizingMaskIntoConstraints = false
        views.append(mVLikeIt)

        datas.forEach { data in
            let view = self.makeButton(data: data, target: target) as UIView
            view.translatesAutoresizingMaskIntoConstraints = false
            views.append(view)
        }
        views.reverse()
        let chunkedViews = views.chunk(2)

        chunkedViews.forEach { views in
            let mountview = mVMount.copyView()
            mountview.translatesAutoresizingMaskIntoConstraints = false
            let leftView = views.last!
            let leftMountview = mountview.subviews.last!
            leftMountview.addSubview(leftView)

            let leftVerticalConnect = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : leftView])
            let leftHorizontalConnect = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : leftView])
            leftMountview.addConstraints(leftVerticalConnect + leftHorizontalConnect)

            if views.count != 1 {
                let rightView = views.first!
                let rightMountview = mountview.subviews.first!
                rightMountview.addSubview(rightView)

                let rightVerticalConnect = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : rightView])
                let rightHorizontalConnect = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : rightView])
                rightMountview.addConstraints(rightVerticalConnect + rightHorizontalConnect)
            }

            mVContent.addSubview(mountview)
        }

        mVContent.subviews.forEach { view in
            let left = NSLayoutConstraint.equalLeftEdge(item: view, toItem: mVContent)
            let right = NSLayoutConstraint.equalRightEdge(item: view, toItem: mVContent)
            mVContent.addConstraints([left, right])
            if mVContent.subviews.first == view {
                let bottom = NSLayoutConstraint.equalBottomEdge(item: view, toItem: mVContent)
                mVContent.addConstraint(bottom)
            } else {
                let height = NSLayoutConstraint.equalHeight(item: mVContent.subviews.first!, toItem: view)
                mVContent.addConstraint(height)
            }
            if mVContent.subviews.last == view {
                let top = NSLayoutConstraint.equalTopEdge(item: view, toItem: mVContent)
                mVContent.addConstraint(top)
            } else {
                let topBottom = NSLayoutConstraint.connectTopBottomEdge(item: view, toItem: mVContent.subviews.after(view)!, space: space)
                mVContent.addConstraint(topBottom)
            }
        }
    }

    private func makeButton(data: LXProductDetailTransitionData, target: Any?) -> BaseButton {
        let button = mBtnTemplate.copyButton()

        button.titleLabel?.text = data.title
        button.setTitle(data.title, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red:0.65, green:0.60, blue:0.36, alpha:1.0).cgColor
        print(data.selector.customMirror.description)
        button.addTarget(target, action: data.selector, for: .touchUpInside)
        return button
    }
}
