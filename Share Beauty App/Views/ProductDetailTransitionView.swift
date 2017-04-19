//
//  ProductDetailTransitionView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/01/08.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ProductDetailTransitionData {
    var title: String
    var selector: Selector
    init(title: String, selector: Selector) {
        self.title = title
        self.selector = selector
    }
}

class ProductDetailTransitionView: BaseView {

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

    func setProductDetailTransitionData(_ datas: [ProductDetailTransitionData], target: Any?) {
		
		// 内部関数: 幅広ボタンの配置
		func centerMount(_ view: UIView) {
			let mountView = self.mVMount.copyView()
			mountView.translatesAutoresizingMaskIntoConstraints = false
			let centerMountView = mountView.subviews.first!
			centerMountView.addSubview(view)
			let leftVerticalConnect = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : view])
			let leftHorizontalConnect = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : view])
			centerMountView.addConstraints(leftVerticalConnect + leftHorizontalConnect)
			self.mVContent.addSubview(mountView)
		}

		// 初期化
        mVContent.subviews.forEach {$0.removeFromSuperview()}
        mVContent.removeConstraints(mVContent.constraints)

		// ボタン作成
        var views = [UIView]()
        datas.forEach { data in
            let view = self.makeButton(data: data, target: target) as UIView
            view.translatesAutoresizingMaskIntoConstraints = false
            views.append(view)
        }
		
		// 現在の仕様では、最初の項目に必ず「ライン名」ボタンが来る
		// ライン名ボタンは必ず幅広ボタンで表示する
		let view = views.first!
		views.removeFirst()
		centerMount(view)
		
		// ボタンリストから左右それぞれのリストを作成
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
                let rightMountview = mountview.subviews[1]
                rightMountview.addSubview(rightView)

                let rightVerticalConnect = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : rightView])
                let rightHorizontalConnect = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .alignAllTop, metrics: nil, views: ["view" : rightView])
                rightMountview.addConstraints(rightVerticalConnect + rightHorizontalConnect)
            }

            mVContent.addSubview(mountview)
        }
		
		// Like It（幅広固定）
		mVLikeIt.translatesAutoresizingMaskIntoConstraints = false
		centerMount(self.mVLikeIt)

		// レイアウト設定
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

    private func makeButton(data: ProductDetailTransitionData, target: Any?) -> BaseButton {
        let button = mBtnTemplate.copyButton()

        button.titleLabel?.text = data.title
        button.setTitle(data.title, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        print(data.selector.customMirror.description)
        button.addTarget(target, action: data.selector, for: .touchUpInside)
        return button
    }
}
