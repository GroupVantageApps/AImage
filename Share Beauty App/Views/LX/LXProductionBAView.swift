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
    
    @IBOutlet weak var mScrollV: BAUIScrollView!
    @IBOutlet var mSFirstImgV: UIImageView!
    @IBOutlet var mSSecondImgV: UIImageView!
    @IBOutlet weak var mSFirstAfterImgV: UIImageView!
    @IBOutlet weak var mSSecondAfterImgV: UIImageView!
    @IBOutlet var mSFirstSlider: UISlider!
    @IBOutlet var mSSecondSlider: UISlider!
    
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(){
        mXbutton.setImage( FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        self.firstImgV.image =  FileTable.getLXFileImage("photo_1_before.png")
        self.mFirstAfterImgV.image =  FileTable.getLXFileImage("photo_1_after.png")
        self.secondImgV.image =  FileTable.getLXFileImage("photo_2_before.png")
        self.mSecondAfterImgV.image =  FileTable.getLXFileImage("photo_2_after.png")
        self.mScrollV.contentSize = CGSize(width: 960, height: 1400)
        self.mScrollV.isPagingEnabled = true
        self.mScrollV.canCancelContentTouches = false
        self.mScrollV.delaysContentTouches = false
    }


    @IBAction func changeValue(_ sender: UISlider) {
       print(Float(sender.value))
        if sender.tag == 20 {
            firstImgV.alpha = 1 - CGFloat(Float(sender.value))
        }else if sender.tag == 21 {
            secondImgV.alpha = 1 - CGFloat(Float(sender.value))
        }else if sender.tag == 22 {
            mSFirstImgV.alpha = 1 - CGFloat(Float(sender.value))
        }else if sender.tag == 23 {
            mSSecondImgV.alpha = 1 - CGFloat(Float(sender.value))
        }
        
    }
    func close() {
        self.isHidden = true
        print("Button pressed")
    }
}

class BAUIScrollView: UIScrollView {
    
    //タッチ判定のキャンセル有無を返すメソッド
    override func touchesShouldCancel(in view: UIView) -> Bool {
        
        //タグ番号がボタン20~23のならタッチをキャンセルする。
        if (view.tag > 19 && view.tag < 24) {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}
 
