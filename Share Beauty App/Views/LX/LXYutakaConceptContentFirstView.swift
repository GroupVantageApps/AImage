//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXYutakaConceptContentFirstView: UIView {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))

    @IBOutlet weak var mImgV: UIImageView!
    func setUI(){
        let path = FileTable.getPath(6108)
        if let arr = NSArray(contentsOf: path) as? [String] {
            print(arr)
            let countryCode = CountryTable.getEntity(LanguageConfigure.countryId)
            if arr.contains(countryCode.code){
                self.mImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_1b.png")
            } else {
                self.mImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_1.png")
            }
        } else {
            self.mImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_1.png")
        }
        let lxArr = LanguageConfigure.lxcsv
        let titleLabel = self.viewWithTag(10) as! UILabel
        titleLabel.text = lxArr["83"]
        let descriptionLabel = self.viewWithTag(11) as! UILabel
        descriptionLabel.text = lxArr["84"]

    }
    

}
