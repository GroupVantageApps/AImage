//
//  TargetSettingViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/02/08.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TargetSettingViewController: UIViewController, NavigationControllerAnnotation, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak private var mTargetTableView: UITableView!

//    private let mScreen = ScreenData(screenId: Const.screenIdIconicBeauty)

    weak var delegate: NavigationControllerDelegate?
    var theme: String? = ""
    var isEnterWithNavigationView: Bool = true

    private var mTargets: [DownloadConfigure.Target]!
    private var mTarget: DownloadConfigure.Target!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mTarget = DownloadConfigure.target
        mTargets = DownloadConfigure.targets
        

        mTargetTableView.delegate = self
        mTargetTableView.dataSource = self

        let index = mTargets.index(where: {$0 == mTarget})!

        mTargetTableView.selectRow(
            at: IndexPath.init(row: index, section: 0),
            animated: false,
            scrollPosition: .none)

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
//        設定時に無理やりdevelopを向かせる設定 release develop
        DownloadConfigure.target = DownloadConfigure.Target.develop
         DownloadConfigure.keepTarget() //＜＜設定を保存する
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapSet(_ sender: AnyObject) {
        DownloadConfigure.target = mTarget
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: CountrySettingViewController.self) as! CountrySettingViewController
        self.delegate?.nextVc(nextVc)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DownloadConfigure.targets.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mTarget = mTargets[indexPath.row]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: LanguageSettingTableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "TargetCell") as! LanguageSettingTableViewCell
        cell.title = DownloadConfigure.targets[indexPath.row].name
        return cell
    }
}
