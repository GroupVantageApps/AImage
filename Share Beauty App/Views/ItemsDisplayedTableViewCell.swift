//
//  LanguageSettingTableViewCell.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/12.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol ItemsDisplayedTableViewCellInput: class {
    func changedDisplayStatus(cell: ItemsDisplayedTableViewCell, isDisplay: Bool)
}

class ItemsDisplayedTableViewCell: UITableViewCell {
    var delegate: ItemsDisplayedTableViewCellInput?
    @IBOutlet private weak var mLblTitle: UILabel!
    @IBOutlet private weak var mSwitch: UISwitch!

    var title: String? {
        didSet {
            mLblTitle.text = title
        }
    }

    var isDisplayed: Bool? {
        didSet {
            if isDisplayed != nil {
                mSwitch.isOn = isDisplayed!
            }
        }
    }

    var isLineCell: Bool? {
        didSet {
            if isDisplayed != nil {
                mSwitch.isHidden = isLineCell!
            }
        }
    }

    var product: ProductData? {
        didSet {
            title = product?.productName.replacingOccurrences(of: "\n", with: " ")
            isLineCell = false
            isDisplayed = product?.defaultDisplay == 1
        }
    }
}

extension ItemsDisplayedTableViewCell {
    @IBAction func onChangedStatus(_ sender: UISwitch) {
        self.delegate?.changedDisplayStatus(cell: self, isDisplay: sender.isOn)
    }
}
