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
    @IBOutlet weak var SubTitleLabel: UILabel!
    @IBOutlet weak var ThirdImageView: UIImageView!

    @IBOutlet weak var copyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyles()
    }

    // スタイル設定
    private func setStyles() {
//        titleLabel.textColor = UIUtil.b()
        titleLabel.font = UIFont(name: "Reader-Bold", size: 23)

        FirstCircleLabel.font = UIFont(name: "Reader-Medium", size: 18)
        SecondCircleLabel.font = UIFont(name: "Reader-Medium", size: 18)
        ThirdCircleLabel.font = UIFont(name: "Reader-Medium", size: 18)

    }
    // 文字セット
    func setTexts(start_index: Int) {
        let csvArr = LanguageConfigure.sdp_eee_csv
        titleLabel.text = csvArr["\(start_index)"]
        
        if start_index == 34 {
            SubTitleLabel.isHidden = false
            SubTitleLabel.font = UIFont(name: "Reader-Bold", size: 23)
            SubTitleLabel.text = csvArr["\(1)"]
            titleLabel.frame.origin.x = 643
        }
        
        if start_index == 17  || start_index == 50 || start_index == 66 {
            titleLabel.text = csvArr["\(1)"]
        }
        
        
        if start_index == 25 || start_index == 42 || start_index == 58 || start_index == 74 {
            titleLabel.text = csvArr["\(9)"]
        }
        
        FirstImageView.image = UIImage.init(named: ("18aw_" + (csvArr["\(start_index + 1)"]?.replacingOccurrences(of:"%", with:""))!))
        SecondImageView.image = UIImage.init(named: ("18aw_" + (csvArr["\(start_index + 2)"]?.replacingOccurrences(of:"%", with:""))!))
        ThirdImageView.image = UIImage.init(named: ("18aw_" + (csvArr["\(start_index + 3)"]?.replacingOccurrences(of:"%", with:""))!))
        FirstCircleLabel.text = csvArr["\(start_index + 4)"]
        SecondCircleLabel.text = csvArr["\(start_index + 5)"]
        ThirdCircleLabel.text = csvArr["\(start_index + 6)"]
        
        var copyLabelText = csvArr["\(start_index + 7)"]
        if start_index == 17 || start_index == 25 {
            copyLabelText = csvArr["\(24)"]
        } else  if start_index == 9 {
            copyLabelText = csvArr["\(8)"]
        }
        copyLabel.text = copyLabelText
        
    }
}
