//
//  CountrySettingViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/11.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import SwiftSpinner
import SCLAlertView

class CountrySettingViewController: UIViewController, NavigationControllerAnnotation, NavigationControllerOptionAnnotation, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mRegionTableView: UITableView!
    @IBOutlet weak var mCountryTableView: UITableView!
    @IBOutlet weak var mSelectedRegion: UILabel!
    @IBOutlet weak var mResetBtn: BaseButton!
    
    private let mScreen = ScreenData(screenId: Const.screenIdCountrySetting)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    private var mRegionId: Int!
    private var mCountryId: Int!

    private var mRegions = [RegionEntity]()
    private var mCountries = [CountryEntity]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        LanguageConfigure.keep()

        mRegionTableView.delegate = self
        mRegionTableView.dataSource = self
        mCountryTableView.delegate = self
        mCountryTableView.dataSource = self

        self.reflectSelectId()

        checkResetBtnAvailability()
    }

    func willPrev() {
        DownloadConfigure.rollbackTarget()
    }

    func willBackRoot(isFromDelegate: Bool) {
        if !isFromDelegate {
            DownloadConfigure.rollbackTarget()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return mRegions.count
        } else {
            return mCountries.count
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            mRegionId = mRegions[indexPath.row].regionId
            mCountries = CountryTable.getEntities(regionId: mRegionId)

            mCountryTableView.reloadData()
            mSelectedRegion.text = mRegions[indexPath.row].name
            mCountryTableView.selectRow(
                at: IndexPath(row: 0, section: 0),
                animated: false,
                scrollPosition: .bottom
            )
            mCountryId = mCountries[0].countryId
        } else {
            mCountryId = mCountries[indexPath.row].countryId
        }
        checkResetBtnAvailability()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: LanguageSettingTableViewCell!

        if tableView.tag == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell") as? LanguageSettingTableViewCell
            cell.title = mRegions[indexPath.row].name
            if mRegions[indexPath.row].regionId == 5 || mRegions[indexPath.row].regionId == 4 || mRegions[indexPath.row].regionId == 3 {
                cell.isHidden = true
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? LanguageSettingTableViewCell
            cell.title = mCountries[indexPath.row].name
        }

        return cell
    }

    private func reflectSelectId() {
        mRegionId = LanguageConfigure.regionId
        mCountryId = LanguageConfigure.countryId

        mRegions = RegionTable.getAllEntities()
        mCountries = CountryTable.getEntities(regionId: mRegionId)

        mRegionTableView.reloadData()
        mCountryTableView.reloadData()

        let regionIndex = mRegions.index(where: {$0.regionId == mRegionId})!
        let countryIndex = mCountries.index(where: {$0.countryId == mCountryId})!

        mSelectedRegion.text = mRegions[regionIndex].name

        mRegionTableView.selectRow(
            at: IndexPath(row: regionIndex, section: 0),
            animated: false,
            scrollPosition: .bottom
        )
        mCountryTableView.selectRow(
            at: IndexPath(row: countryIndex, section: 0),
            animated: false,
            scrollPosition: .bottom
        )
    }

    @IBAction func onTapSet(_ sender: AnyObject) {
        LanguageConfigure.regionId = mRegionId
        LanguageConfigure.countryId = mCountryId

        Utility.log("RegionId:" + mRegionId.description)
        Utility.log("CountryId:" + mCountryId.description)

        ModelDatabase.switchDatabase()

        if DownloadConfigure.downloadStatus != .success {
            if Utility.checkReachability() == true {
                initAppData()

            } else {
                let alert: UIAlertController = UIAlertController(title: "エラー", message: "ネットワークがオフライン状態です。", preferredStyle:  UIAlertController.Style.alert)
                let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                    (_) -> Void in
                    print("OK")
                })
                alert.addAction(defaultAction)
                present(alert, animated: true, completion: nil)
            }
        } else {
            DownloadConfigure.releaseTarget()
            LanguageConfigure.languageId = LanguageTable.getFirstEntity().languageId!
            
            Utility.reloadCsvData()

            if self.delegate == nil {
                UIApplication.shared.delegate?.window??.rootViewController =
                    UIViewController.GetViewControllerFromMainStoryboard(NavigationViewController.self) as! NavigationViewController
            } else {
                delegate!.setOutAppBtn()
                delegate!.backRootVc()
            }
        }
    }

    private func complete() {
        DownloadConfigure.downloadStatus = .success
        DownloadConfigure.releaseTarget()
        LanguageConfigure.languageId = LanguageTable.getFirstEntity().languageId!
        
        Utility.reloadCsvData()
        
        SwiftSpinner.hide()
        if delegate == nil {
            UIApplication.shared.delegate?.window??.rootViewController =
                UIViewController.GetViewControllerFromMainStoryboard(NavigationViewController.self) as! NavigationViewController
        } else {
            delegate!.setOutAppBtn()
            delegate!.backRootVc()
        }
    }

    private func error(message: String) {
        DownloadConfigure.downloadStatus = .failure
        SwiftSpinner.hide()
        ModelDatabase.deleteDB()
        LanguageConfigure.rollback()
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Done", action: {
            self.reflectSelectId()
        })
        alertView.showError("Error", subTitle: message)
    }

    // 選択した国ではじめてデータをダウンロードする場合の処理
    private func initAppData() {
        SwiftSpinner.show("Downloading Data...")
        ContentDownloader.default.download(completion: { result in
            switch result {
            case .success:
                ContentDownloader.default.downloadComplete(completion: { result in
                    switch result {
                    case .success:
                        self.complete()
                    case .failure(let error):
                        self.error(message: error.desctiption)
                    }
                })
            case .failure:
                ContentDownloader.default.downloadError(completion: { result in })
                switch result {
                case .failure(let error):
                    self.error(message: error.desctiption)
                default: break
                }
            }
        })
    }
    
    @IBAction func onTapReSet(_ sender: AnyObject) {
        LanguageConfigure.regionId = mRegionId
        LanguageConfigure.countryId = mCountryId
        
        Utility.log("RegionId:" + mRegionId.description)
        Utility.log("CountryId:" + mCountryId.description)
        
        DownloadConfigure.apiKey = nil
        DownloadConfigure.isNeedUpdate = false
        DownloadConfigure.downloadStatus = .notdoing
        
        ModelDatabase.deleteDB()
        ModelDatabase.switchDatabase()
        
        if DownloadConfigure.downloadStatus != .success {
            if Utility.checkReachability() == true {
                initAppData()
            } else {
                let alert: UIAlertController = UIAlertController(title: "エラー", message: "ネットワークがオフライン状態です。", preferredStyle:  UIAlertController.Style.alert)
                let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                    (_) -> Void in
                    print("OK")
                })
                alert.addAction(defaultAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // resetボタンの有効、無効チェック
    func checkResetBtnAvailability() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let target = DownloadConfigure.target.rawValue
        let dbFileName = String(format: Const.databaseNameFormat, arguments: [target, mCountryId])
        let filePath = "\(url.path)/\(dbFileName)"
        let downloadStatus = String(format: "DownloadStatus-%d-%d", arguments: [target, mCountryId])
        
        if ModelDatabase.dbExists(filePath: filePath) && UserDefaults.standard.integer(forKey: downloadStatus) == 1 {
            mResetBtn.isUserInteractionEnabled = true
            mResetBtn.titleLabel?.textColor = .black
            mResetBtn.superview?.superview?.backgroundColor = .black
        } else {
            mResetBtn.isUserInteractionEnabled = false
            mResetBtn.titleLabel?.textColor = .gray
            mResetBtn.superview?.superview?.backgroundColor = .gray
        }
    }

}
