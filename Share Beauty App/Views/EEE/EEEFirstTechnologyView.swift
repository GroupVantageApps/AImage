//
//  SDPEfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class EEEFirstTechnologyView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var FirstCircleLabel: UILabel!
    @IBOutlet weak var SecondCircleLabel: UILabel!
    @IBOutlet weak var SubTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setTexts()
    }

    // 文字セット
    func setTexts() {
        let csvArr = LanguageConfigure.sdp_eee_csv
        titleLabel.text = csvArr["83"]
        SubTitleLabel.text = csvArr["82"]
        FirstCircleLabel.text = csvArr["84"]
        SecondCircleLabel.text = csvArr["85"]
        descriptionLabel.text = csvArr["86"]
        
    }
}
