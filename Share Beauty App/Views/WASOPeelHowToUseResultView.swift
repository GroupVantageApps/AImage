//
//  SDPEfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class WASOPeelHowToUseResultView: UIView {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var SecondCircleLabel: UILabel!
    @IBOutlet weak var ThirdCircleLabel: UILabel!
    @IBOutlet weak var ForthCircleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setTexts()
    }

    // 文字セット
    func setTexts() {
        let csvArr = LanguageConfigure.sdp_eee_csv
        titleLabel.text = csvArr["128"]
        SecondCircleLabel.text = csvArr["129"]
        ThirdCircleLabel.text = csvArr["130"]
        ForthCircleLabel.text = csvArr["131"]
    }
}
