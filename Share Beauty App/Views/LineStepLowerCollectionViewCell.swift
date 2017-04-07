//
//  LineStepLowerCollectionViewCell.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/12/29.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LineStepLowerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var mImgVLine: UIImageView!
    @IBOutlet weak private var mLblLower: UILabel!

    var dbStructLineStep: DBStructLineStep! {
        didSet {
            isUtm = Bool(dbStructLineStep.stepId == 6)
            mImgVLine.isHidden = (dbStructLineStep.stepName == "")
            mLblLower.text = dbStructLineStep.stepName
        }
    }

    var isUtm: Bool = false {
        didSet {
            var image: UIImage!
            var color: UIColor!

            if isUtm {
                image = UIImage(named: "line_step_bar3")
                color = UIColor.white
            } else {
                image = UIImage(named: "line_step_bar4")
                color = UIColor.white
            }
            mImgVLine.image = image
            mLblLower.textColor = color
        }
    }
}
