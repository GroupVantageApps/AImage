//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXProductionBAView: UIView {
    
    @IBOutlet var firstImgV: UIImageView!
    
    @IBOutlet var secondImgV: UIImageView!
    @IBOutlet weak var mFirstAfterImgV: UIImageView!
    
    @IBOutlet weak var mSecondAfterImgV: UIImageView!
    @IBOutlet var mFirstSlider: UISlider!
    
    @IBOutlet var mSecondSlider: UISlider!
    
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(){
        mXbutton.setImage( FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        self.firstImgV.image =  FileTable.getLXFileImage("photo_1_before.png")
        self.mFirstAfterImgV.image =  FileTable.getLXFileImage("photo_1_after.png")
        self.secondImgV.image =  FileTable.getLXFileImage("photo_2_before.png")
        self.mSecondAfterImgV.image =  FileTable.getLXFileImage("photo_2_after.png")
    }


    @IBAction func changeValue(_ sender: UISlider) {
       print(Float(sender.value))
        if sender.tag == 20 {
            firstImgV.alpha = 1 - CGFloat(Float(sender.value))
        }else if sender.tag == 21 {
            secondImgV.alpha = 1 - CGFloat(Float(sender.value))
        }
    }
    func close() {
        self.isHidden = true
        print("Button pressed")
    }
}
