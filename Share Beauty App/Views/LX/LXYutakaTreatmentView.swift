//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
protocol LXYutakaTreatmentViewDelegate: NSObjectProtocol {
    func playSounds(tag: Int)
} 

class LXYutakaTreatmentView: UIView, UIScrollViewDelegate, LXYutakaTreatmentContentFirstViewDelegate {
    weak var delegate: LXYutakaTreatmentViewDelegate? 
    
    var mframe: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var colors:[UIColor] = [UIColor.white, UIColor.white, UIColor.white]
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 960/2 - 100, y: 650, width: 200, height: 50))
    var mSkingeneceintrolbl = UILabel(frame:CGRect(x: 58, y: 43, width: 376, height: 66))
    var thumArray = ["lx_yutaka_treatment_thum_01.png","lx_yutaka_treatment_thum_02.png","lx_yutaka_treatment_thum_03.png","lx_yutaka_treatment_thum_04.png","lx_yutaka_treatment_thum_05.png","lx_yutaka_treatment_thum_06.png","lx_yutaka_treatment_thum_07.png","lx_yutaka_treatment_thum_08.png"]
   
    var mScrollView = UIScrollView()
    var mContentV: UIView!
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38 , y: 16.7, width: 38, height: 38))
    var defaultArr = [0,1,2,3,4,5,6,7]
    
    func setUI(page: Int) {
        
        self.mScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 960, height: self.size.height))
        

        self.mScrollView.delegate = self
        self.mScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.mScrollView)


        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: .normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        let lxArr = LanguageConfigure.lxcsv

        let lxTreatMentArr = LanguageConfigure.lxyutaka
        for id in lxTreatMentArr {
            if defaultArr.contains(id - 1){
                let index = defaultArr.index(of: id - 1)
                defaultArr.remove(at: index!)
            }
        }
        print("-----------------------------")
        print(defaultArr.index(of: page)!)

        self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: self.mScrollView.frame.size.width * CGFloat(defaultArr.count), height: self.size.height))
        self.mScrollView.addSubview(mContentV)
        self.mScrollView.minimumZoomScale = 1.0
        self.mScrollView.maximumZoomScale = 6.0
        self.mScrollView.contentSize = self.mContentV.size
        
        for index in 0..<defaultArr.count {
            mframe.origin.x = self.mScrollView.frame.size.width * CGFloat(index)
            mframe.size = self.mScrollView.frame.size
            let subView = UIView(frame: mframe)
            
            let popup: LXYutakaTreatmentContentFirstView = UINib(nibName: "LXYutakaTreatmentContentFirstView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaTreatmentContentFirstView
            let csvTitleId = (defaultArr[index])*2 + 92
            let csvDescriptionId = (defaultArr[index])*2 + 93
            popup.setUI(image: thumArray[defaultArr[index]], title: lxArr[String(csvTitleId)]!, description: lxArr[String(csvDescriptionId)]!, index: index, page_num: defaultArr)
            popup.delegate = self
            subView.addSubview(popup)

            self.mContentV.addSubview(subView)
        }
        self.mScrollView.contentSize = CGSize(width: self.mScrollView.frame.size.width * CGFloat(defaultArr.count), height: self.mScrollView.frame.size.height)
        self.mScrollView.setContentOffset(CGPoint(x: self.mScrollView.width * CGFloat(defaultArr.index(of: page)!), y:0), animated: false)
        self.mScrollView.isPagingEnabled = true
        mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControl.Event.valueChanged)
        configurePageControl()
        self.mPageControl.numberOfPages = defaultArr.count

        mPageControl.currentPage = defaultArr.index(of: page)!
    }

    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.

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
        self.isHidden = true
        print("Button pressed")
    }
    
    func playSounds (tag: Int) {
        delegate?.playSounds(tag: tag)
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
