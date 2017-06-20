//
//  LifeStyleDefault2ProductsLayoutUnit.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/06/21.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LifeStyleDefault2ProductsLayoutUnit: NSObject {
	class func layout(containerView: UIView, productViews: [UIView]) {
		assert(productViews.count == 2, "商品枠2つ用のレイアウトです")
		
		let leftView = productViews[0]
		let rightView = productViews[1]
		
		containerView.addSubview(leftView)
		containerView.addSubview(rightView)
		
		leftView.translatesAutoresizingMaskIntoConstraints = false
		rightView.translatesAutoresizingMaskIntoConstraints = false
		containerView.addConstraints([
			NSLayoutConstraint(item: leftView, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 130.0),
			NSLayoutConstraint(item: leftView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: leftView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: leftView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 318.0),
			NSLayoutConstraint(item: rightView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -130.0),
			NSLayoutConstraint(item: rightView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: rightView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: rightView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 318.0),
			NSLayoutConstraint(item: rightView, attribute: .leadingMargin, relatedBy: .equal, toItem: leftView, attribute: .trailing, multiplier: 1.0, constant: 130.0),
		])
	}
}
