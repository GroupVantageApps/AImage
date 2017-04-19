//
//  TouchTransmissionView.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/04/17.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

/// タッチイベントを透過するUIView
class TouchTransmissionView: UIView {

	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		var eventView:UIView? = nil
		let hitView:UIView? = super.hitTest(point, with: event)
		if hitView != self {
			eventView = hitView
		}
		return eventView
	}

}
