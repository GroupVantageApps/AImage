//
//  NewApproachViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class NewApproachViewController: UIViewController, NavigationControllerAnnotation {

    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Shiseido's Approach to Skin"
    var isEnterWithNavigationView = true
    @IBOutlet weak var mBtnDefend: UIButton!
    @IBOutlet weak var mBtnRegenerate: UIButton!
    @IBOutlet weak var mLblSynergy: UILabel!
    @IBOutlet weak var mImgVApproach: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mBtnDefend.layer.cornerRadius = mBtnDefend.height / 2
        mBtnRegenerate.layer.cornerRadius = mBtnRegenerate.height / 2

        mLblSynergy.layer.cornerRadius = mLblSynergy.width / 2
        mLblSynergy.layer.borderWidth = 4
        mLblSynergy.layer.borderColor = UIColor.init(red255: 200, green255: 16, blue255: 46, alpha: 1).cgColor

        let imageId = AppItemTable.getMainImageByItemId(itemId: 7880)
        if let approachImage = FileTable.getImage(imageId.first) {
            mImgVApproach.image = approachImage
        }
    }
    @IBAction func onTapDefend(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealResultViewController.self) as! IdealResultViewController
        nextVc.selectedLineIds = [Const.lineIdUTM]
        delegate?.nextVc(nextVc)
    }
    @IBAction func onTapRegenerate(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealResultViewController.self) as! IdealResultViewController
        if let lines = IdealBeautyLinesData().lines {
            nextVc.selectedLineIds = lines.map {$0.lineId}
        }
        nextVc.selectedStepLowerIds = [Const.stepLowerIdMoisturizer]
        nextVc.noAddFlg = true
        delegate?.nextVc(nextVc)
    }
}
