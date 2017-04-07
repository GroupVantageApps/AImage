//
//  LanguageSettingTableViewCell.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/12.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LanguageSettingTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var mLblTitle: UILabel!

    var title: String? {
        didSet {
            mLblTitle.text = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
