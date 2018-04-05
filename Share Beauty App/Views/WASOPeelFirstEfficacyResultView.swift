//
//  SDPEfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class WASOPeelFirstEfficacyResultView: UIView {
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
        titleLabel.text = csvArr["132"]
        FirstCircleLabel.text = csvArr["133"]
        SecondCircleLabel.text = csvArr["134"]
        ThirdCircleLabel.text = csvArr["137"]
        ForthCircleLabel.text = csvArr["138"]
        copyLabel.text = csvArr["141"]
    }
}

