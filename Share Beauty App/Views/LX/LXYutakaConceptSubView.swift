//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXYutakaConceptSubView: UIView ,UIScrollViewDelegate{
    var mScrollView = UIScrollView()
    var mframe: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var colors:[UIColor] = [UIColor.white, UIColor.white, UIColor.white]
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 960/2 - 100, y: 650, width: 200, height: 50))
    var mSkingeneceintrolbl = UILabel(frame:CGRect(x: 58, y: 43, width: 376, height: 66))
    var array = ["lx_yutaka_sub_1.png","lx_yutaka_sub_2.png","lx_yutaka_sub_3"]
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38 , y: 16.7, width: 38, height: 38))
    var mContentV: UIView!
    func setUI(page: Int) {
        self.mScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 960, height: self.size.height))
        self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: self.mScrollView.frame.size.width * 3, height: self.size.height))
        self.mScrollView.addSubview(mContentV)
        self.mScrollView.minimumZoomScale = 1.0
        self.mScrollView.maximumZoomScale = 6.0
        self.mScrollView.contentSize = self.mContentV.size

        self.mScrollView.delegate = self
        self.mScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.mScrollView)


        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControl.State.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)

        for index in 0..<3 {
            mframe.origin.x = self.mScrollView.frame.size.width * CGFloat(index)
            mframe.size = self.mScrollView.frame.size
            let subView = UIView(frame: mframe)
            
            if index == 0 {
            let popup: LXYutakaConceptContentFirstView = UINib(nibName: "LXYutakaConceptContentFirstView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentFirstView
            popup.setUI()
            subView.addSubview(popup)
            } else if index == 1{
                let popup: LXYutakaConceptContentSecondView = UINib(nibName: "LXYutakaConceptContentSecondView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentSecondView
                popup.setUI()
                subView.addSubview(popup)
            } else if index == 2 {
                let popup: LXYutakaConceptContentThirdView = UINib(nibName: "LXYutakaConceptContentThirdView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentThirdView
                popup.setUI()
                subView.addSubview(popup)
            }

            self.mContentV.addSubview(subView)
        }
        self.mScrollView.isPagingEnabled = true
        self.mScrollView.setContentOffset(CGPoint(x: self.mScrollView.width * CGFloat(page), y:0), animated: false)
        mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControl.Event.valueChanged)
        configurePageControl()
        mPageControl.currentPage = page
        
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.mPageControl.numberOfPages = colors.count
        self.mPageControl.currentPage = 0
        self.mPageControl.pageIndicatorTintColor = UIColor.lightGray
        self.mPageControl.currentPageIndicatorTintColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
        self.addSubview(mPageControl)
        
    }
    func changePage(sender: AnyObject) {
        let x = CGFloat(mPageControl.currentPage) * mScrollView.frame.size.width
        mScrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        mPageControl.currentPage = Int(pageNumber)
    }
    @objc func close() {
        self.removeFromSuperview()
        print("Button pressed")
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.mContentV
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            self.mScrollView.isPagingEnabled = true
        } else {
            self.mScrollView.isPagingEnabled = false        
        }
    }
}
