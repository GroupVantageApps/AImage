//
//  IngredientSkinGraphView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/02/21.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


import Foundation
import UIKit

class IngredientSkinGraphView: UIView, UIScrollViewDelegate{
    
    
    let mScrollView = UIScrollView(frame: CGRect(x: 57, y: 150, width: 573, height: 448))
    var mframe: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var colors:[UIColor] = [UIColor.white, UIColor.white, UIColor.white]
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 516/2, y: 605, width: 200, height: 50))
    var mSkingeneceintrolbl = UILabel(frame:CGRect(x: 58, y: 43, width: 376, height: 66))
    var array = ["bummytext.png","serpinb3.png","defend.png"]
    var titleArr = ["Promotes expression of the longevity gene","Inhibits Serpin b3","Suppresses factors that attack Langerhans cells"]
    var subTitleArr = ["Promotes the expression of the longevity gene Sirtuin1","Inhibits Serpin b3","Boosts skin’s defenses"]
    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))
    
      func setUI() {
  
        
        configurePageControl()
        
        self.mScrollView.delegate = self
        self.mScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.mScrollView)
        
//        self.mSkingeneceintrolbl.text = "Three effects that bring out\nexcellent skin cell regeneration effect"
//        self.mSkingeneceintrolbl.textColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
//        self.mSkingeneceintrolbl.lineBreakMode = NSLineBreakMode.byWordWrapping
//        self.mSkingeneceintrolbl.numberOfLines = 0
//        self.mSkingeneceintrolbl.font = UIFont(name: "ACaslonPro-Regular", size: 23.0)
//        self.addSubview(self.mSkingeneceintrolbl)

        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        for index in 0..<3 {
            mframe.origin.x = self.mScrollView.frame.size.width * CGFloat(index)
            mframe.size = self.mScrollView.frame.size
            self.mScrollView.isPagingEnabled = true

            let subView = UIView(frame: mframe)
            subView.backgroundColor = colors[index]
            let mNumlbl = UILabel(frame:CGRect(x: 0, y: 27.9, width: 20, height: 54))
            mNumlbl.text = NSString(format:"%d", index+1) as String
            mNumlbl.textColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
            mNumlbl.font = UIFont(name: "ACaslonPro-Regular", size: 47.0)
            subView.addSubview(mNumlbl)

            let imageName = self.array[index]
            let image = FileTable.getLXFileImage(imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 38, y: 113, width: 517, height: 317)
            subView.addSubview(imageView)
            
            let nib = UINib(nibName: "LXGraphView", bundle: nil)
            let views = nib.instantiate(withOwner: self, options: nil)
            guard let graphView = views[0] as? LXGraphView else { return }
            graphView.center = CGPoint(x: subView.bounds.size.width*0.5 + 30, y: 273)
            subView.addSubview(graphView)
            
            let mLineview = UIView(frame: CGRect(x: 48, y: 36, width: 1, height: 32))
            mLineview.backgroundColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
            subView.addSubview(mLineview)

            let mLoremIplbl = UILabel(frame:CGRect(x: 66, y: 27.9, width: 310, height: 51))
            mLoremIplbl.text = titleArr[index]
            mLoremIplbl.textColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
            mLoremIplbl.font = UIFont(name: "ACaslonPro-Regular", size: 18.0)
            mLoremIplbl.lineBreakMode = NSLineBreakMode.byWordWrapping
            mLoremIplbl.numberOfLines = 0
            subView.addSubview(mLoremIplbl)

            self.mScrollView.addSubview(subView)
            
            graphView.setUp(left: 57, right: 30, l_title: "Without\nSkingenecellEnmei",r_title: "With\nSkingenecellEnmei")
        }
        self.mScrollView.contentSize = CGSize(width: self.mScrollView.frame.size.width * 3, height: self.mScrollView.frame.size.height)
        mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)

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

}
