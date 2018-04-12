//
//  LXBaseViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/24.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXBaseViewController: UIViewController {
   private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL, Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL, Const.outAppInfoUltimune] 

    override func viewDidLoad() {
    super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("LXBase.viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("LXBase.viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("LXBase.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("LXBase.viewDidDisappear")
    }
    func didTapPrev() {
       _ = self.navigationController?.popViewController(animated: false)
    }
    func didHeaderViewAction(_ type: LXHeaderViewActionType) {
        switch type {
        case .home:
            self.showTop()
        case .list:
            break
        default:
            break
        }
    }
    
    func showTop() {
        print("showTop")
        let toVc = UIViewController.GetViewControllerFromStoryboard("Main", targetClass: NavigationViewController.self) as! NavigationViewController
        let navigationController = UINavigationController(rootViewController: toVc)
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
    func didSelectOutApp(index: Int) {
        let outAppInfo = type(of: self).outAppInfos[index]
        if UIApplication.shared.canOpenURL(outAppInfo.url) {
            UIApplication.shared.openURL(outAppInfo.url)
        } else {
            let alertVc = UIAlertController(
                title: "Warning",
                message: "App is not installed",
                preferredStyle: .alert
            )
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVc.addAction(defaultAction)
            self.present(alertVc, animated: true, completion: nil)
        }
    }

}
