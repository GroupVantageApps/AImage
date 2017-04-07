//
//  LineStepUpperCollectionViewCell.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/12/29.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LineStepUpperCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var mImgVLine: UIImageView!
    @IBOutlet weak private var mLblUpper: UILabel!

    var step: DBStructStep! {
        didSet {
            isUtm = Bool(step.stepUpperId == 5)
            if !isUtm && [Const.CountryIdUs, Const.CountryIdCanada].contains(LanguageConfigure.countryId) {
                mLblUpper.text = ""
                mImgVLine.isHidden = true
                return
            }
            mLblUpper.text = step.stepUpperName
            mImgVLine.isHidden = (step.stepUpperName == "")
        }
    }

    var isUtm: Bool = false {
        didSet {
            var image: UIImage!
            var color: UIColor!

            if isUtm {
                image = UIImage(named: "line_step_bar2")
                color = UIColor(red255: 219, green255: 44, blue255: 56, alpha: 1.0)
            } else {
                image = UIImage(named: "line_step_bar1")
                color = UIColor(red255: 204, green255: 204, blue255: 204, alpha: 1.0)
            }
            mImgVLine.image = image
            mLblUpper.textColor = color
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
