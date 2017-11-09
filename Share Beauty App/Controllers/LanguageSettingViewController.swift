//
//  LanguageSettingViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/02/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LanguageSettingViewController: UIViewController, NavigationControllerAnnotation, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak private var mLanguageTableView: UITableView!

    private let mScreen = ScreenData(screenId: Const.screenIdLanguageSetting)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    private var mLanguages = [LanguageEntity]()
    private var mLanguageId: Int!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mLanguageId = LanguageConfigure.languageId
        mLanguages = LanguageTable.getEntities(countryId: LanguageConfigure.countryId)

        mLanguageTableView.delegate = self
        mLanguageTableView.dataSource = self

        let index = mLanguages.index(where: {$0.languageId == mLanguageId})!

        mLanguageTableView.selectRow(
            at: IndexPath.init(row: index, section: 0),
            animated: false,
            scrollPosition: .none)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapSet(_ sender: AnyObject) {
        LanguageConfigure.languageId = mLanguageId
        let languageCode = LanguageTable.getEntity(mLanguageId)
        let filePath = String(format: "file://%@/Documents/lx_csv/lx_csv/%@lx.csv", NSHomeDirectory(), languageCode.code)
        let csv = Utility.csvToArray(file: filePath)
        LanguageConfigure.lxcsv = csv
        
        //        let gscFilePa、hyth = String(format: "file://%@/Documents/gsc_csv/gsc_csv/%@gsc.csv", NSHomeDirectory(), languageCode.code)
        let gscFilePath = String(format: "file://%@/Documents/gsc_csv/gsc_csv/%@gsc.csv", NSHomeDirectory(), "010483")
        let gscCsv = Utility.csvToArray(file: gscFilePath)
        LanguageConfigure.gsccsv = gscCsv

        delegate?.backRootVc()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mLanguages.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mLanguageId = mLanguages[indexPath.row].languageId
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: LanguageSettingTableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as! LanguageSettingTableViewCell
        cell.title = mLanguages[indexPath.row].name
        return cell
    }
}
