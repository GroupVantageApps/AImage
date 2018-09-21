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
	@IBOutlet weak var mLblVLeft: UILabel!
	@IBOutlet weak var mLblVCenter: UILabel!
	@IBOutlet weak var mLblVRight: UILabel!

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
		mLblVLeft.text = AppItemTranslateTable.getEntity(7917).name
		mLblVCenter.text = AppItemTranslateTable.getEntity(7918).name
		mLblVRight.text = AppItemTranslateTable.getEntity(7919).name
		mImgVCenter.image = FileTable.getAImage(6081)
        self.startAnimating()
    }

    func setupOrange() {
		mLblVLeft.text = AppItemTranslateTable.getEntity(7914).name
		mLblVCenter.text = AppItemTranslateTable.getEntity(7915).name
		mLblVRight.text = AppItemTranslateTable.getEntity(7916).name
		mImgVCenter.image = FileTable.getAImage(6082)
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
