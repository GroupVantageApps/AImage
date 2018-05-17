//
//  CALayer+UIColor.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/05/17.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func setBorderUIColor(_ color: UIColor) {
        self.borderColor = color.cgColor
    }
}
