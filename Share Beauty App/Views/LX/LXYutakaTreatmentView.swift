//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
protocol LXYutakaTreatmentViewDelegate: NSObjectProtocol {
    func playSounds()
} 

class LXYutakaTreatmentView: UIView, UIScrollViewDelegate, LXYutakaTreatmentContentFirstViewDelegate {
    weak var delegate: LXYutakaTreatmentViewDelegate? 
    
    let mScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
    var mframe: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var colors:[UIColor] = [UIColor.white, UIColor.white, UIColor.white]
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 960/2 - 100, y: 650, width: 200, height: 50))
    var mSkingeneceintrolbl = UILabel(frame:CGRect(x: 58, y: 43, width: 376, height: 66))
    var array = ["lx_yutaka_sub_1.png","lx_yutaka_sub_2.png","lx_yutaka_sub_3"]
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38 , y: 16.7, width: 38, height: 38))
    
    func setUI() {
        self.mScrollView.delegate = self
        self.mScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.mScrollView)


        mXbutton.setImage(UIImage(named: "btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)

        for index in 0..<1 {
            mframe.origin.x = self.mScrollView.frame.size.width * CGFloat(index)
            mframe.size = self.mScrollView.frame.size
            let subView = UIView(frame: mframe)
            
            if index == 0 {
            let popup: LXYutakaTreatmentContentFirstView = UINib(nibName: "LXYutakaTreatmentContentFirstView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaTreatmentContentFirstView
            popup.setUI()
                popup.delegate = self
            subView.addSubview(popup)
            } else if index == 1{
                let popup: LXYutakaTreatmentContentFirstView = UINib(nibName: "LXYutakaTreatmentContentFirstView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaTreatmentContentFirstView
                popup.setUI()
                 popup.delegate = self
                subView.addSubview(popup)
            } else if index == 2 {
                let popup: LXYutakaTreatmentContentFirstView = UINib(nibName: "LXYutakaTreatmentContentFirstView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaTreatmentContentFirstView
                popup.setUI()
                 popup.delegate = self
                subView.addSubview(popup)
            }

            self.mScrollView.addSubview(subView)
        }
        self.mScrollView.contentSize = CGSize(width: self.mScrollView.frame.size.width * 3, height: self.mScrollView.frame.size.height)
        self.mScrollView.isPagingEnabled = true
        
        mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
        configurePageControl()
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
    func close() {
        self.isHidden = true
        print("Button pressed")
    }
    
    func playSounds () {
        delegate?.playSounds()
    }
}
