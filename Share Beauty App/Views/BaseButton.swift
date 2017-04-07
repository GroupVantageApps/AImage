//
//  BaseButton.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/12.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isExclusiveTouch = true
        self.imageView?.contentMode = .scaleAspectFit
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isExclusiveTouch = true
        self.imageView?.contentMode = .scaleAspectFit
    }

    func copyButton() -> BaseButton {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! BaseButton
    }
}
