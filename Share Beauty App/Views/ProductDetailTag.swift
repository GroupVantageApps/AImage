//
//  ProductDetailTag.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/18.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
protocol ProductDetailTagDelegate: NSObjectProtocol {
    func didTapTrouble(_ trouble: DataStructTrouble)
}
class ProductDetailTag: BaseView {
    @IBOutlet weak var mBtn: BaseButton!

    weak var delegate: ProductDetailTagDelegate?

    @IBOutlet var mBackgroundView: UIView!
    var trouble: DataStructTrouble? {
        didSet {
            if trouble != nil {
                mBtn.setTitle(trouble?.troubleName, for: UIControlState())
                mBtn.isEnabled = !Const.troubleIdNotImage.contains(trouble!.troubleId)

                if trouble?.displayFlg == Const.troubleDisplayStrong {
                    mBackgroundView.backgroundColor = UIColor.init(red: 219 / 255.0, green: 44 / 255.0, blue: 56 / 255.0, alpha: 1.0)
                }
            }
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        mBtn.titleLabel?.lineBreakMode = .byWordWrapping
        mBtn.titleLabel?.numberOfLines = 0
    }

    @IBAction func onTapTrouble(_ sender: AnyObject) {
        if trouble != nil {
            delegate?.didTapTrouble(trouble!)
        }
    }
}
