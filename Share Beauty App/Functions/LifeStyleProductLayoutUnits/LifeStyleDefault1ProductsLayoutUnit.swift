//
//  LifeStyleDefault1ProductsLayoutUnit.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/06/21.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LifeStyleDefault1ProductsLayoutUnit: NSObject {
	class func layout(containerView: UIView, productViews: [UIView]) {
		assert(productViews.count == 1, "商品枠1つ用のレイアウトです")
		
		let view = productViews[0]
		
		containerView.addSubview(view)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addConstraints([
			NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 318.0),
			NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
		])
	}
}
