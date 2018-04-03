//
//  SDPEfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class EEESecondEfficacyResultView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var title3Label: UILabel!
    @IBOutlet weak var FirstCircleLabel: UILabel!
    @IBOutlet weak var SecondCircleLabel: UILabel!
    @IBOutlet weak var ThirdCircleLabel: UILabel!


    @IBOutlet weak var copyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setTexts()
    }

    // 文字セット
    func setTexts() {
        let csvArr = LanguageConfigure.sdp_eee_csv
        titleLabel.text = csvArr["1"]
        title2Label.text = csvArr["115"]
        title3Label.text = csvArr["116"]
        
        
        FirstCircleLabel.text = csvArr["123"]
        SecondCircleLabel.text = csvArr["124"]
        ThirdCircleLabel.text = csvArr["125"]
        copyLabel.text = csvArr["126"]
        
    }
}
