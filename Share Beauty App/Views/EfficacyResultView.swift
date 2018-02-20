//
//  EfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class EfficacyResultView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var effectLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var beforeImageView: UIImageView!
    @IBOutlet weak var afterImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var afterLabel: UILabel!
    @IBOutlet weak var annotationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setStyles()
        setTexts()
    }

    // スタイル設定
    private func setStyles() {
        titleLabel.textColor = UIUtil.grayColor()
        titleLabel.font = UIUtil.getReaderBold(23)

        effectLabel.textColor = UIUtil.redColor()
        effectLabel.font = UIUtil.getReaderBold(17)

        exampleLabel.textColor = UIUtil.grayColor()
        exampleLabel.font = UIUtil.getReaderBold(15)

        for label in [beforeLabel, afterLabel] {
            label?.textColor = UIUtil.grayColor()
            label?.font = UIUtil.getReaderBold(15)
        }

        slider.setThumbImage(UIImage(named: "slider_waso"), for: .normal)
        slider.setMinimumTrackImage(UIImage(named: "efficacy_slider_full"), for: .normal)
        slider.setMaximumTrackImage(UIImage(named: "efficacy_slider_empty"), for: .normal)

        let images = AppItemTable.getJsonByItemId(itemId: 7886)?.dictionary?["image"]?[0].dictionary?["main_image"]?.arrayObject as? [Int]
        beforeImageView.image = FileTable.getImage(images?[1])
        afterImageView.image = FileTable.getImage(images?[0])
    }

    // 文字セット
    private func setTexts() {
        let items = AppItemTable.getItemsByScreenCode("17AWWASO")
        titleLabel.text = (UIUtil.getUtmArray() as NSArray as? [String])?[47]
        effectLabel.text = items["01"]
        exampleLabel.text = items["02"]
        beforeLabel.text = items["04"]
        afterLabel.text = items["05"]
        annotationLabel.text = items["06"]
    }

    @IBAction func sliderValueChanged(_ slider: UISlider) {
        beforeImageView.alpha = CGFloat(1) - CGFloat(slider.value)
    }
}
