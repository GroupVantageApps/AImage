//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXProductionBAView: UIView, UIScrollViewDelegate {
    
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
    
    var mContentV: UIView!
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 960/2 - 100, y: 655, width: 200, height: 50))

    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(){
        mXbutton.setImage( FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)

        self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: self.size.width*2, height: self.size.height))
        
        self.firstImgV.image =  FileTable.getLXFileImage("photo_1_before.png")
        self.mFirstAfterImgV.image =  FileTable.getLXFileImage("photo_1_after.png")
        self.secondImgV.image =  FileTable.getLXFileImage("photo_2_before.png")
        self.mSecondAfterImgV.image =  FileTable.getLXFileImage("photo_2_after.png")
        self.mScrollV.contentSize = CGSize(width: 960 * 2, height: 700)
        self.mScrollV.isPagingEnabled = true
        self.mScrollV.delaysContentTouches = false
        self.mScrollV.canCancelContentTouches = true
        
        var firstView = self.viewWithTag(100)! as UIView
        firstView.frame = CGRect(x: 0, y: 0, width: 960, height: 700)
        
        let lxArr = LanguageConfigure.lxcsv
        
        for i in 0..<5 {
            let label = firstView.viewWithTag(10 + i) as! UILabel
            let csvId = 116 + i
            label.text = lxArr[String(csvId)]
        }
        
        let secondView = self.viewWithTag(101)! as UIView
        secondView.frame = CGRect(x: 960, y: 0, width: 960, height: 700)
        
        for i in 0..<5 {
            let label = secondView.viewWithTag(10 + i) as! UILabel
            let csvId = 121 + i
            label.text = lxArr[String(csvId)]
        }
        
        self.mContentV.addSubview(firstView)
        self.mContentV.addSubview(secondView)
        self.mScrollV.addSubview(mContentV)
        self.mScrollV.delegate = self
        self.mScrollV.minimumZoomScale = 1.0
        self.mScrollV.maximumZoomScale = 6.0

        // The total number of pages that are available is based on how many available colors we have.
        self.mPageControl.numberOfPages = 2
        self.mPageControl.currentPage = 0
        self.mPageControl.pageIndicatorTintColor = UIColor.lightGray
        self.mPageControl.currentPageIndicatorTintColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
        self.addSubview(mPageControl)
        self.mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.mPageControl.currentPage = Int(pageNumber)
    }
    func changePage(sender: AnyObject) {
        let x = CGFloat(mPageControl.currentPage) * self.mScrollV.frame.size.width
        self.mScrollV.setContentOffset(CGPoint(x: x,y :0), animated: true)
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

class BAUIScrollView: UIScrollView {
    
}
 
