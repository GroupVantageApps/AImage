//
//  IngredientSkinGraphView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/02/21.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//


import Foundation
import UIKit
protocol IngredientSkinGraphViewDelegate: NSObjectProtocol {
    func ingredientMoviePlay(index: Int)
} 
class IngredientSkinGraphView: UIView, UIScrollViewDelegate{
    
    weak var delegate: IngredientSkinGraphViewDelegate?  

    @IBOutlet weak var mScrollView: UIScrollView!
    var mframe: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var colors:[UIColor] = [UIColor.white, UIColor.white, UIColor.white]
    var mPageControl : UIPageControl = UIPageControl(frame:CGRect(x: 516/2, y: 605, width: 200, height: 50))
    var mSkingeneceintrolbl = UILabel(frame:CGRect(x: 58, y: 43, width: 376, height: 66))
    var array = ["lx_ingredient_bg_1.png","lx_ingredient_bg_2.png","lx_ingredient_bg_3.png"]
    var titleArr = ["Promotes expression of the longevity gene","Inhibits Serpin b3","Suppresses factors that attack Langerhans cells"]
    var subTitleArr = ["Promotes the expression of the longevity gene Sirtuin1","Inhibits Serpin b3","Boosts skin’s defenses"]
    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))
    
    func setUI() {
        
        
        self.mScrollView.delegate = self
        self.mScrollView.showsHorizontalScrollIndicator = false
        
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        self.mScrollView.contentSize = CGSize(width: self.mScrollView.frame.size.width * 3, height: self.mScrollView.frame.size.height)
        self.mScrollView.isPagingEnabled = true
        
        mframe.size = self.mScrollView.frame.size
        print(mframe)
        
        let subvewNib = UINib(nibName: "IngredientSkinGraphContentView", bundle: nil)
        let subviews = subvewNib.instantiate(withOwner: self, options: nil)
        guard let subView = subviews[0] as? IngredientSkinGraphContentView else { return }
        subView.frame = mframe
        subView.tag = 100
        let lxArr = LanguageConfigure.lxcsv
        
        for i in 0..<7 {
            if i < 5 {
                let label = subView.viewWithTag(10 + i) as! UILabel  
                let csvId = 21 + i
                label.text = lxArr[String(csvId)]    
            } else {
                let label = subView.viewWithTag(10 + i) as! UILabel
                label.text = String(format: "%@\n%@",lxArr["26"]!,lxArr["27"]!)
            }
        }
        let label = subView.viewWithTag(16) as! UILabel 
        label.text = lxArr["39"]
        let nib = UINib(nibName: "LXGraphView", bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let graphView = views[0] as? LXGraphView else { return }
        graphView.center = CGPoint(x: (subView.bounds.size.width)*0.5 + 15, y: 340)
        subView.addSubview(graphView)
        self.mScrollView.addSubview(subView)
        
        let showMovieBtn = subView.viewWithTag(20) as! UIButton!
        showMovieBtn?.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
        showMovieBtn?.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        
        graphView.setUp(left: 57, right: 30, l_title: lxArr["28"]!,r_title: lxArr["29"]!)
        graphView.bgImage = "ingredient_graph_bg.png"
        
        let subvewNib2 = UINib(nibName: "IngredientSkinGraphContentView", bundle: nil)
        let subviews2 = subvewNib2.instantiate(withOwner: self, options: nil)
        guard let subView2 = subviews2[0] as? IngredientSkinGraphContentView else { return }
        mframe.origin.x = self.mScrollView.frame.size.width
        subView2.frame = mframe
        subView2.tag = 101
    
        for i in 0..<7 {
                let label = subView2.viewWithTag(10 + i) as! UILabel  
                let csvId = 31 + i
                label.text = lxArr[String(csvId)]    
        }
        
        let label2 = subView2.viewWithTag(16) as! UILabel 
        label2.text = lxArr["39"]
        let nib2 = UINib(nibName: "LXGraphView", bundle: nil)
        let views2 = nib2.instantiate(withOwner: self, options: nil)
        guard let graphView2 = views2[0] as? LXGraphView else { return }
        graphView2.center = CGPoint(x: (subView2.bounds.size.width)*0.5 + 15, y: 340)
        subView2.addSubview(graphView2)
        self.mScrollView.addSubview(subView2)
        
        let showMovieBtn2 = subView2.viewWithTag(20) as! UIButton!
        showMovieBtn2?.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
        showMovieBtn2?.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        
        graphView2.setUp(left: 57, right: 30, l_title: lxArr["37"]!,r_title: lxArr["38"]!)
        graphView2.bgImage = "ingredient_graph_bg.png"
        
        let subvewNib3 = UINib(nibName: "IngredientSkinGraphContentView", bundle: nil)
        let subviews3 = subvewNib3.instantiate(withOwner: self, options: nil)
        guard let subView3 = subviews3[0] as? IngredientSkinGraphContentView else { return }
        mframe.origin.x = self.mScrollView.frame.size.width * 2
        subView3.frame = mframe
        subView3.tag = 102

        for i in 0..<7 {
            if i < 5 {
                let label = subView3.viewWithTag(10 + i) as! UILabel  
                let csvId = 40 + i
                label.text = lxArr[String(csvId)]
            } else {
                let label = subView3.viewWithTag(10 + i) as! UILabel  
                let csvId = 48
                label.text = lxArr[String(csvId)]
            }
        }
        let label3 = subView2.viewWithTag(16) as! UILabel 
        label3.text = lxArr["39"]
        
        let showMovieBtn3 = subView3.viewWithTag(20) as! UIButton!
        showMovieBtn3?.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
        showMovieBtn3?.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        
        let nib3 = UINib(nibName: "LXGraphView", bundle: nil)
        let views3 = nib3.instantiate(withOwner: self, options: nil)
        guard let graphView3 = views3[0] as? LXGraphView else { return }
        graphView3.center = CGPoint(x: (subView3.bounds.size.width)*0.5 + 15, y: 340)
        subView3.addSubview(graphView3)
        self.mScrollView.addSubview(subView3)
        
        graphView3.setUp(left: 57, right: 30, l_title: lxArr["28"]!,r_title: lxArr["29"]!)
        graphView3.bgImage = "ingredient_graph_bg.png"
        
        configurePageControl()
        
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
        let x = CGFloat(self.mPageControl.currentPage) * self.mScrollView.frame.size.width
        self.mScrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.mPageControl.currentPage = Int(pageNumber)
    }
    func close() {
        self.isHidden = true
        print("Button pressed")
    }
    @IBAction func showMovie(_ sender: Any) {
        let btn = sender as! UIButton
        let superV = btn.superview
        delegate?.ingredientMoviePlay(index: superV!.tag - 99)
    }
}
