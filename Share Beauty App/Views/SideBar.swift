//
//  SideBar.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/11.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

enum SideBarActionType: Int {
    case home, recommended, settings
}

protocol SideBarDelegate: NSObjectProtocol {
    func didHSideBarAction(_ type: SideBarActionType)
    func nextVcFromSideBar<T: UIViewController>(_ nextVc: T) where T: NavigationControllerAnnotation
}

class SideBar: BaseView {
    weak var delegate: SideBarDelegate?
    @IBOutlet weak private var mBtnHome: BaseButton!
    @IBOutlet weak private var mBtnLikeIt: BaseButton!
    @IBOutlet weak private var mBtnSetting: BaseButton!

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        let item = AppItemTable.getItems(screenId: Const.screenIdSideMenu)
        print(item)
        mBtnHome.setTitle(item["01"], for: .normal)
        mBtnLikeIt.setTitle(item["09"], for: .normal)
        mBtnSetting.setTitle(item["11"], for: .normal)
    }

    @IBAction private func onTapHome(_ sender: AnyObject) {
        delegate?.didHSideBarAction(.home)
    }

    @IBAction private func onTapRecommended(_ sender: AnyObject) {
        delegate?.didHSideBarAction(.recommended)
    }

    @IBAction private func onTapSettings(_ sender: AnyObject) {
        delegate?.didHSideBarAction(.settings)
    }

    @IBAction private func onTapProductLine(_ sender: AnyObject) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard("ProductLineViewController", targetClass: ProductLineViewController.self) as! ProductLineViewController
        delegate?.nextVcFromSideBar(nextVc)
    }

    @IBAction private func onTapSkinConsern(_ sender: AnyObject) {
        print("*** onTapSkinConsern")
    }

    @IBAction private func onTapItemType(_ sender: AnyObject) {
        print("*** onTapItemType")
    }

    @IBAction private func onTapSkincareFinder(_ sender: AnyObject) {
        print("*** onTapSkincareFinder")
    }

    @IBAction private func onTapFoundationFinder(_ sender: AnyObject) {
        print("*** onTapFoundationFinder")
    }

    @IBAction private func onTapSkinCondition(_ sender: AnyObject) {
        print("*** onTapSkinCondition")
    }

    @IBAction private func onTapNewApproachToSkin(_ sender: AnyObject) {
        print("*** onTapNewApproachToSkin")
    }

    @IBAction private func onTapUltimuneTecnology(_ sender: AnyObject) {
        print("*** onTapUltimuneTecnology")
    }

    @IBAction private func onTapDefendAndRegenerate(_ sender: AnyObject) {
        print("*** onTapDefendAndRegenerate")
    }

    @IBAction private func onTapCleanse(_ sender: AnyObject) {
        print("*** onTapCleanse")
    }

    @IBAction private func onTapSoften(_ sender: AnyObject) {
        print("*** onTapSoften")
    }

    @IBAction private func onTapMoisturize(_ sender: AnyObject) {
        print("*** onTapMoisturize")
    }

    @IBAction private func onTapPurposeOfSkincare(_ sender: AnyObject) {
        print("*** onTapPurposeOfSkincare")
    }

    @IBAction private func onTapBeautyTips(_ sender: AnyObject) {
        print("*** onTapBeautyTips")
    }

    @IBAction private func onTapBeautySecrets(_ sender: AnyObject) {
        print("*** onTapBeautySecrets")
    }
}
