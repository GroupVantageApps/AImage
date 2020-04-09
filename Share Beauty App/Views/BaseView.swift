//
//  MyCustomView.swift
//  CustomViewSample
//
//  Created by himara2 on 2015/07/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

//@IBDesignable
class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let strClassName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        let nib = UINib(nibName: strClassName, bundle: bundle)

        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: bindings))
    }
}
