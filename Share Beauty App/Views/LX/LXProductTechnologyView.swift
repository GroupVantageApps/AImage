//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXProductTechnologyView: UIView, UIScrollViewDelegate {
    
    @IBOutlet weak var mScrollV: UIScrollView!
    var mContentV: UIView!
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 960/2 - 100, y: 655, width: 200, height: 50))

    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(productId: Int){
  
        if productId == 522 || productId == 516 || productId == 523{
            self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            let popup: LXYutakaConceptContentThirdView = UINib(nibName: "LXYutakaConceptContentThirdView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentThirdView
            popup.setUI()
            popup.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(popup)
            
            self.mPageControl.isHidden = true
            self.mScrollV.contentSize = CGSize(width: 960, height: 700)
            self.mScrollV.addSubview(self.mContentV) 
        } else if productId == 517 || productId == 521 {
            self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let bioV: LXTechBiologicalView = UINib(nibName: "LXTechBiologicalView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXTechBiologicalView
            bioV.setUI()
            bioV.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(bioV)
    
            let popup: LXYutakaConceptContentThirdView = UINib(nibName: "LXYutakaConceptContentThirdView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentThirdView
            popup.setUI()
            popup.frame  = CGRect(x: 960, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(popup)
            

            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: 700)
            self.mPageControl.numberOfPages = 2
            self.mScrollV.addSubview(self.mContentV) 
        } else  if productId == 520 || productId == 519 {
            self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 3, height: 700))
            let bioV: LXTechBiologicalView = UINib(nibName: "LXTechBiologicalView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXTechBiologicalView
            bioV.setUI()
            bioV.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(bioV)
                       
            let auraV: LXTechAuraView = UINib(nibName: "LXTechAuraView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXTechAuraView
            auraV.setUI()
            auraV.frame  = CGRect(x: 960, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(auraV)
            
            let popup: LXYutakaConceptContentThirdView = UINib(nibName: "LXYutakaConceptContentThirdView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentThirdView
            popup.setUI()
            popup.frame  = CGRect(x: 960 * 2, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(popup)

            
            self.mScrollV.contentSize = CGSize(width: 960 * 3, height: 700)
            self.mPageControl.numberOfPages = 3
            self.mScrollV.addSubview(self.mContentV) 
        } else  if productId ==  524 || productId == 525 {
            self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            let auraV: LXTechAuraView = UINib(nibName: "LXTechAuraView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXTechAuraView
            auraV.setUI() 
            auraV.frame  = CGRect(x:  0, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(auraV) 
            self.mPageControl.isHidden = true
            self.mScrollV.addSubview(self.mContentV)
        }
        
        
        self.mScrollV.canCancelContentTouches = true
        self.mScrollV.delegate = self
        self.mScrollV.minimumZoomScale = 1.0
        self.mScrollV.maximumZoomScale = 6.0
        
        self.mPageControl.currentPage = 0
        self.mPageControl.pageIndicatorTintColor = UIColor.lightGray
        self.mPageControl.currentPageIndicatorTintColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
        self.addSubview(mPageControl)
        self.mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
        
        mXbutton.setImage( FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
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
 
