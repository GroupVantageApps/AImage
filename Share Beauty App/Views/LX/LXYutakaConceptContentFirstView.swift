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
        self.mImgV.image = FileTable.getLXFileImage("lx_yutaka_sub_1.png")
    }
    

}
