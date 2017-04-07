//
//  UIColor+FQExtention.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/13.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        let rString = (cString as NSString).substring(with: NSRange(location: 0, length: 2))
        let gString = (cString as NSString).substring(with: NSRange(location: 2, length: 2))
        let bString = (cString as NSString).substring(with: NSRange(location: 4, length: 2))

        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: alpha
        )
    }

    convenience init(red255: CGFloat, green255: CGFloat, blue255: CGFloat, alpha: CGFloat) {
        self.init(
            red: red255 / 255.0,
            green: green255 / 255.0,
            blue: blue255 / 255.0,
            alpha: alpha
        )
    }
}
