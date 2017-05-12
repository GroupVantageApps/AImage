//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXYutakaConceptContentSecondView: UIView {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    
    @IBOutlet weak var mImgV: UIImageView!
    @IBOutlet var mDetailLbl: UILabel!
    func setUI(){
        let lxArr = LanguageConfigure.lxcsv
        let titleLabel = self.viewWithTag(10) as! UILabel
        titleLabel.text = lxArr["85"]
        self.mDetailLbl.text = lxArr["86"]
        self.mDetailLbl.clipsToBounds = true
        self.mImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_2.png")
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
}
