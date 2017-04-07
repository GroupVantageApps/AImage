//
//  MakeupUsageView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/06.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AImage
import APNGKit

class WasoGraphEfficacyView: BaseView {
    @IBOutlet weak private var mImgVBack: UIImageView!
    @IBOutlet weak private var mImgVLeft: APNGImageView!
    @IBOutlet weak private var mImgVCenter: APNGImageView!
    @IBOutlet weak private var mImgVRight: APNGImageView!

    deinit {
        print("deinit")
        stopAnimating()
    }

    var backImage: UIImage? {
        didSet {
            mImgVBack.image = backImage
        }
    }

    func setupGreen() {
        mImgVLeft.image = APNGImage(named: "green_L", progressive: true)
        mImgVCenter.image = APNGImage(named: "green_C", progressive: true)
        mImgVRight.image = APNGImage(named: "green_R", progressive: true)
        self.startAnimating()
    }

    func setupOrange() {
        mImgVLeft.image = APNGImage(named: "orange_L", progressive: true)
        mImgVCenter.image = APNGImage(named: "orange_C", progressive: true)
        mImgVRight.image = APNGImage(named: "orange_R", progressive: true)
        self.startAnimating()
    }

    func startAnimating() {
        mImgVLeft.startAnimating()
        mImgVCenter.startAnimating()
        mImgVRight.startAnimating()
    }

    func stopAnimating() {
        mImgVLeft.stopAnimating()
        mImgVCenter.stopAnimating()
        mImgVRight.stopAnimating()
        mImgVLeft.image = nil
        mImgVCenter.image = nil
        mImgVRight.image = nil
    }
}
