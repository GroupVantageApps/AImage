//
//  SDPEfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class WASOSleepingFirstEfficacyResultView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var FirstCircleLabel: UILabel!
    @IBOutlet weak var SecondCircleLabel: UILabel!
    @IBOutlet weak var ThirdCircleLabel: UILabel!
    @IBOutlet weak var ForthCircleLabel: UILabel!
    @IBOutlet weak var copyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTexts()
    }

    // 文字セット
    func setTexts() {
        let csvArr = LanguageConfigure.sdp_eee_csv
        titleLabel.text = csvArr["150"]
        FirstCircleLabel.text = csvArr["151"]
        SecondCircleLabel.text = csvArr["152"]
        ThirdCircleLabel.text = csvArr["155"]
        ForthCircleLabel.text = csvArr["156"]
        copyLabel.text = csvArr["159"]
    }
}

