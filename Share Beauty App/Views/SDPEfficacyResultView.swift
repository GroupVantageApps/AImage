//
//  SDPEfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class SDPEfficacyResultView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var FirstCircleLabel: UILabel!
    @IBOutlet weak var SecondCircleLabel: UILabel!
    @IBOutlet weak var ThirdCircleLabel: UILabel!
    @IBOutlet weak var FirstImageView: UIImageView!
    @IBOutlet weak var SecondImageView: UIImageView!
    @IBOutlet weak var ThirdImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setStyles()
        setTexts()
    }

    // スタイル設定
    private func setStyles() {
        titleLabel.textColor = UIUtil.grayColor()
        titleLabel.font = UIUtil.getSystemBold(23)

        FirstCircleLabel.textColor = UIUtil.redColor()
        FirstCircleLabel.font = UIUtil.getSystemBold(17)

        SecondCircleLabel.textColor = UIUtil.grayColor()
        SecondCircleLabel.font = UIUtil.getSystemBold(15)

        ThirdCircleLabel.textColor = UIUtil.grayColor()
        ThirdCircleLabel.font = UIUtil.getSystemBold(15)

//        FirstImageView.image = FileTable.getImage(images?[1])
//        SecondImageView.image = FileTable.getImage(images?[0])
//        ThirtImageView.image = FileTable.getImage(images?[0])
    }
    // 文字セット
    private func setTexts() {
        let items = AppItemTable.getItemsByScreenCode("17AWWASO")
        titleLabel.text = (UIUtil.getUtmArray() as NSArray as? [String])?[47]
        FirstCircleLabel.text = items["01"]
        SecondCircleLabel.text = items["02"]
        ThirdCircleLabel.text = items["04"]
    }
}
