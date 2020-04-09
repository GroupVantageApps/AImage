//
//  LXGreenTeaView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXProductHowToUseView: UIView, UIScrollViewDelegate {

    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    var mContentV: UIView!
    var mScrollV: UIScrollView!

    func setUI(productId: Int) {
        let lxArr = LanguageConfigure.lxcsv
        self.mContentV = UIView.init(frame: self.frame)
        self.mScrollV = UIScrollView.init(frame:  self.frame)
        self.mScrollV.addSubview(mContentV)
        self.addSubview(mScrollV)
        self.mScrollV.minimumZoomScale = 1.0
        self.mScrollV.maximumZoomScale = 6.0
        self.mScrollV.delegate = self
        self.mScrollV.contentSize = self.mContentV.size
        if productId == 522 {
            let firstView = self.viewWithTag(100)! as UIView
            let imageBg =  self.viewWithTag(30)! as! UIImageView
            imageBg.image = FileTable.getLXFileImage("lx_howtouse_522.png")

            firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
            firstView.isHidden = false
            self.mContentV.addSubview(firstView)
            for i in 0..<10 {
                let label = firstView.viewWithTag(10 + i) as! UILabel
                let csvId = 315 + i
                label.text = lxArr[String(csvId)]
                
            }
        } else {
            let firstView = self.viewWithTag(101)! as UIView
            let imageBg =  self.viewWithTag(31)! as! UIImageView
            imageBg.image = FileTable.getLXFileImage("lx_howtouse_523.png")
            
            firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
            firstView.isHidden = false
            self.mContentV.addSubview(firstView)
            for i in 0..<10 {
                let label = firstView.viewWithTag(10 + i) as! UILabel
                let csvId = 338 + i
                label.text = lxArr[String(csvId)]
                
            }
        }
        
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControl.State.normal) 
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.mContentV
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            self.mScrollV.isPagingEnabled = true
        } else {
            self.mScrollV.isPagingEnabled = false        
        }
    }

}
