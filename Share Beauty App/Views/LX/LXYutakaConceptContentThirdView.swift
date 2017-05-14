//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXYutakaConceptContentThirdView: UIView {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    
    @IBOutlet weak var mSub1ImgV: UIImageView!
    
    @IBOutlet weak var mSub2ImgV: UIImageView!
    
    @IBOutlet weak var mSub3ImgV: UIImageView!
    func setUI(){
        let ud = UserDefaults.standard
        let items = LanguageConfigure.lxcsv
        for i in 0..<5 {
            let label = self.viewWithTag(i + 10) as! UILabel
            let content = items[String(format: "%d", i + 87)]
            print(content)
            label.text = content
        }
        self.mSub1ImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_3_1.png")
        self.mSub2ImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_3_2.png")
        self.mSub3ImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_3_3.png")
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
}
