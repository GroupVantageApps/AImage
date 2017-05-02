//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXProductGraphView: UIView, UIScrollViewDelegate {    
    @IBOutlet weak var mScrollV: UIScrollView!
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 960/2 - 100, y: 655, width: 200, height: 50))

    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(){
        mXbutton.setImage( FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        self.mScrollV.contentSize = CGSize(width: 960 * 4, height: 700)
        self.mScrollV.isPagingEnabled = true
        self.mScrollV.delaysContentTouches = false
        self.mScrollV.canCancelContentTouches = true

        for i in 0..<4 {
            let imgV = UIImageView.init(frame: CGRect(x: 960 * i, y: 0, width: 960, height: 700))
            imgV.image = UIImage(named: String(format: "lx_product_graph_%d", i + 1))
            self.mScrollV.addSubview(imgV)
        }
        
        self.mScrollV.delegate = self
        // The total number of pages that are available is based on how many available colors we have.
        self.mPageControl.numberOfPages = 4
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
    func close() {
        self.isHidden = true
        print("Button pressed")
    }
    
}

 
