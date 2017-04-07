//
//  ColorballView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/10/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ColorballView: UICollectionViewCell {
    @IBOutlet private weak var mImgV: UIImageView!
    @IBOutlet private weak var mLbl: UILabel!

    var colorball: DataStructColorball! {
        didSet {
            mLbl.text = colorball.name
            mImgV.image = FileTable.getImage(colorball.imageId)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
