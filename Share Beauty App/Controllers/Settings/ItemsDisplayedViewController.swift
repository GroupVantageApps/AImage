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

class ItemsDisplayedViewController: UIViewController, NavigationControllerAnnotation {
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    private let mScreen = ScreenData(screenId: Const.screenIdCountrySetting)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }
    @IBOutlet weak fileprivate var mLineTableView: UITableView!
    @IBOutlet weak fileprivate var mProductTableView: UITableView!
    @IBOutlet weak fileprivate var mLblLine: UILabel!
    @IBOutlet weak fileprivate var mSwitchLine: UISwitch!

    fileprivate var mLineId: Int!
    fileprivate var mLines = [LineTranslateEntity]()
    fileprivate var mProducts = [ProductData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        mLines = LineTranslateTable.getEntities(isOnlyUseFlg: false)
        mLines = mLines.filter {!($0.lineId == Const.lineIdLX || $0.lineId == Const.lineIdUTM)}

        mLineTableView.delegate = self
        mLineTableView.dataSource = self
        mProductTableView.delegate = self
        mProductTableView.dataSource = self
    }
}

//event
extension ItemsDisplayedViewController {
    @IBAction private func onChangedLineSwitch(_ sender: UISwitch) {
        /*
        LineTranslateTable.changeUseFlg(lineId: mLineId, isUse: sender.isOn)
        if let targetIndex = mLines.index(where: {$0.lineId == mLineId}) {
            mLines[safe: targetIndex]?.useFlg = Int(sender.isOn as NSNumber)
        }
 */
        LineTranslateTable.changeDisplayFlg(lineId: mLineId, isDisplay: sender.isOn)
        if let targetIndex = mLines.index(where: {$0.lineId == mLineId}) {
            mLines[safe: targetIndex]?.displayFlg = Int(truncating: sender.isOn as NSNumber)
        }
    }
}

extension ItemsDisplayedViewController: ItemsDisplayedTableViewCellInput {
    func changedDisplayStatus(cell: ItemsDisplayedTableViewCell, isDisplay: Bool) {
        guard let product = cell.product, let targetIndex = mProducts.index(of: product) else {
            return
        }
        let defaultDisplay = Int(truncating: isDisplay as NSNumber)
        ProductTranslateTable.changeDefaultDisplay(product.productId, isDisplay: defaultDisplay)
        mProducts[safe: targetIndex]?.defaultDisplay = defaultDisplay
    }
}

extension ItemsDisplayedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mSwitchLine.isHidden = true
        let line = mLines[indexPath.row]
        mLineId = line.lineId
        mProducts = ProductListData(
            lineId: mLineId,
            isIgnoreDisplayFlg: true).products
        mProductTableView.reloadData()
        mLblLine.text = line.name
        mSwitchLine.isOn = line.displayFlg == 1
        mSwitchLine.isHidden = false
    }
}

extension ItemsDisplayedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return mLines.count
        } else {
            return mProducts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ItemsDisplayedTableViewCell!

        if tableView.tag == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "LineCell") as? ItemsDisplayedTableViewCell
            cell.title = mLines[indexPath.row].name
            cell.isLineCell = true
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ItemsDisplayedTableViewCell
            cell.product = mProducts[indexPath.row]
            cell.delegate = self
        }
        return cell
    }
}

