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
    var thumArray = ["lx_yutaka_treatment_thum_01.png","lx_yutaka_treatment_thum_02.png","lx_yutaka_treatment_thum_03.png","lx_yutaka_treatment_thum_04.png","lx_yutaka_treatment_thum_05.png","lx_yutaka_treatment_thum_06.png","lx_yutaka_treatment_thum_07.png","lx_yutaka_treatment_thum_08.png"]
    var titleArray = ["Essential Treatment","Ultimate Brightening","Ultimate Brightening with Hand Treatment","Ultimate Moisture Firming","Ultimate Moisture Firming with Hand Treatment","Essential Express","Brightening Express","Moisture Firming Express"]
    var descriptionArray = ["An idyllic, 50-minute treatment for refreshing the mind, body, and soul. Cleansing, softening, relaxing, regenerating, and protective, this essential experience also includes an Intensive Treatment Mask to address stressed out, tired skin. Suited to all skin types.","This special, 60-minute Ultimate Brightening treatment is bene cial for revitalizing and protecting the skin against increased melanin.  The exclusive sheet mask remedy ensures the skin is left looking positively radiant and exceptionally soft. Perfectly suited to those wishing to brighten their skin."," This 60-minute treatment brings all the bene ts of the Ultimate Brightening Treatment to one of the most important parts of your body—your hands. As you relax in the softening facial mask, indulge yourself in a nurturing hand massage, leaving your skin calm, balanced, and beautifully bright.","The ultimate moisture surge for weather-damaged, dry, lackluster skin. 60 minutes of pure indulgence and skin support, featuring a warming facial mask paired with  rming and hydrating remedies. Your skin will look and feel absolutely  awless.","An intensely moisturizing and  rming treatment with all the bene ts of the Ultimate Moisture Firming experience. Indulge yourself with a warming facial mask of nourishment, relaxation, and relief while your hands enjoy the same gentle skin care therapy to wash away damage and stress.","Pamper your skin with the addition of brightening to the Beauty Longevity System.  is treatment supports your skin to reveal your radiance, like a pearl from within. Experience the di erence just 15 minutes can make.\n\nPlease note: makeup removal will require an additional 10 minutes.","Experience the wonders of Future Solution LX on your skin through the Beauty Longevity System, a collection of essential items. The 10-minute treatment promotes resilient, smooth, glowing skin.\n\nPlease note: makeup removal will require an additional 10 minutes.","Pamper your skin with the addition of brightening to the Beauty Longevity System.  is treatment supports your skin to reveal your radiance, like a pearl from within. Experience the di erence just 15 minutes can make.\n\nPlease note: makeup removal will require an additional 10 minutes."]

    let mXbutton = UIButton(frame: CGRect(x: 960 - 38 , y: 16.7, width: 38, height: 38))
    
    func setUI(page: Int) {
        self.mScrollView.delegate = self
        self.mScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.mScrollView)


        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)

        for index in 0..<8 {
            mframe.origin.x = self.mScrollView.frame.size.width * CGFloat(index)
            mframe.size = self.mScrollView.frame.size
            let subView = UIView(frame: mframe)
            
            let popup: LXYutakaTreatmentContentFirstView = UINib(nibName: "LXYutakaTreatmentContentFirstView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaTreatmentContentFirstView
            popup.setUI(image: thumArray[index], title: titleArray[index], description: descriptionArray[index])
            popup.delegate = self
            subView.addSubview(popup)

            self.mScrollView.addSubview(subView)
        }
        self.mScrollView.contentSize = CGSize(width: self.mScrollView.frame.size.width * 8, height: self.mScrollView.frame.size.height)
        self.mScrollView.setContentOffset(CGPoint(x: self.mScrollView.width * CGFloat(page), y:0), animated: false)
        self.mScrollView.isPagingEnabled = true
        mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
        configurePageControl()
        self.mPageControl.numberOfPages = 8
        mPageControl.currentPage = page
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
    func close() {
        self.isHidden = true
        print("Button pressed")
    }
    
    func playSounds () {
        delegate?.playSounds()
    }
}
