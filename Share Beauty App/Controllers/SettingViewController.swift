//
//  SettingViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/02/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, NavigationControllerAnnotation {

    private let mScreen = ScreenData(screenId: Const.screenIdSetting)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onTapTarget(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: TargetSettingViewController.self) as! TargetSettingViewController
        delegate?.nextVc(nextVc)
    }

    @IBAction func onTapCountry(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: CountrySettingViewController.self) as! CountrySettingViewController
        delegate?.nextVc(nextVc)
    }

    @IBAction func onTapLanguage(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: LanguageSettingViewController.self) as! LanguageSettingViewController
        delegate?.nextVc(nextVc)
    }

    @IBAction func onTapLineDisplayed(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: ItemsDisplayedViewController.self) as! ItemsDisplayedViewController
        delegate?.nextVc(nextVc)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
