//
//  SDPEfficacyResultView.swift
//  Share Beauty App
//
//  Created by Tomoyuki Matsumoto on 2017/03/04.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


class EEESecondTechnologyView: UIView {
    
    @IBOutlet weak var subTitle1Label: UILabel!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var descliption1Label: UILabel!
    @IBOutlet weak var copy1Lable: UILabel!
    
    @IBOutlet weak var subTitle2Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var descliption2_1Label: UILabel!
    @IBOutlet weak var descliption2_2Label: UILabel!
    @IBOutlet weak var specularLable: UILabel!
    @IBOutlet weak var diffusedLable: UILabel!
    @IBOutlet weak var copy2Lable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTexts()
    }

    // 文字セット
    func setTexts() {
        let csvArr = LanguageConfigure.sdp_eee_csv
        subTitle1Label.text = csvArr["87"]
        title1Label.text = csvArr["88"]
        descliption1Label.text = csvArr["89"]
        copy1Lable.text = csvArr["90"]
        
        subTitle2Label.text = csvArr["87"]
        title2Label.text = csvArr["92"]
        descliption2_1Label.text = csvArr["93"]
        descliption2_2Label.text = csvArr["94"]
        specularLable.text = csvArr["95"]
        diffusedLable.text = csvArr["96"]
        copy2Lable.text = csvArr["90"]
        
    }
}
