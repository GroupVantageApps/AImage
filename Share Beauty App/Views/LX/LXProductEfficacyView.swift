//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXProductEfficacyView: UIView, UIScrollViewDelegate {
    
    @IBOutlet weak var mScrollV: UIScrollView!
    var mContentV: UIView!
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 960/2 - 100, y: 655, width: 200, height: 50))
 
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(productId: Int){
  
        if productId == 516 {
            self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let efficacyV: LXEfficacyPenetrationView = UINib(nibName: "LXEfficacyPenetrationView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXEfficacyPenetrationView
            efficacyV.setUI()
            efficacyV.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(efficacyV)
            
            let secondV = UIImageView.init(frame: CGRect(x: 960, y: 0, width: 960, height: 700))
                secondV.image = UIImage(named: "lx_effifacy_c_graph_1")
            self.mContentV.addSubview(secondV)
            
            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else if productId == 517 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let firstV = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            firstV.image = UIImage(named: "lx_effifacy_ba")
            self.mContentV.addSubview(firstV)
            
            let secondV = UIImageView.init(frame: CGRect(x: 960, y: 0, width: 960, height: 700))
            secondV.image = UIImage(named: "lx_effifacy_c_graph_2")
            self.mContentV.addSubview(secondV)
            
            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else if productId == 519 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let firstV = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            firstV.image = UIImage(named: "lx_effifacy_c_graph_3")
            self.mContentV.addSubview(firstV)
            
            let secondV = UIImageView.init(frame: CGRect(x: 960, y: 0, width: 960, height: 700))
            secondV.image = UIImage(named: "lx_effifacy_c_graph_4")
            self.mContentV.addSubview(secondV)
            
            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else  if productId ==  523 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let firstV = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            firstV.image = UIImage(named: "lx_intensive")
            self.mContentV.addSubview(firstV)
            
            let secondV = UIImageView.init(frame: CGRect(x: 960, y: 0, width: 960, height: 700))
            secondV.image = UIImage(named: "lx_intensive_graph")
            self.mContentV.addSubview(secondV)
            
            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else  if productId == 522 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            let firstV = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            firstV.image = UIImage(named: "lx_eye_graph")
            self.mContentV.addSubview(firstV)
            
            self.mPageControl.isHidden = true
            self.mScrollV.contentSize = CGSize(width: 960, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        }
        
        
        self.mScrollV.canCancelContentTouches = true
        self.mScrollV.delegate = self

        
        self.mPageControl.currentPage = 0
        self.mPageControl.pageIndicatorTintColor = UIColor.lightGray
        self.mPageControl.currentPageIndicatorTintColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
        self.addSubview(mPageControl)
        self.mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
        
        mXbutton.setImage( FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        self.mScrollV.minimumZoomScale = 1.0
        self.mScrollV.maximumZoomScale = 6.0
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

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.mContentV
    }

    func close() {
        self.isHidden = true
        print("Button pressed")
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            self.mScrollV.isPagingEnabled = true
        } else {
            self.mScrollV.isPagingEnabled = false        
        }
    }
}
 
