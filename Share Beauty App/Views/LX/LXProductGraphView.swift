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
        
        let lxArr = LanguageConfigure.lxcsv
        for index in 0..<4 {
            let view: LXProductGraphContentView = UINib(nibName: "LXProductGraphContentView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductGraphContentView
            view.frame = CGRect(x:  960 * index, y: 0, width: 960, height: 700)
            if index == 3{
                let subview = view.viewWithTag(101)
                view.mImageView.isHidden = true
                view.mImageView2.image = UIImage(named: String(format: "lx_product_graph_%d",index + 1))
                subview?.isHidden = false
            } else {
                view.mImageView.image = UIImage(named: String(format: "lx_product_graph_%d",index + 1))
            }
            self.mScrollV.addSubview(view)
            for i in 0..<9 {
                if index == 0 {
                    let label = view.viewWithTag(10 + i) as! UILabel
                    var csvId = 0
                    switch i {
                    case 0:
                        csvId = 126
                    case 1:
                        csvId = 129
                    case 2:
                        csvId = 131
                    case 3:
                        csvId = 133
                    case 4:
                        csvId = 134
                    case 5:
                        csvId = 136
                    case 6:
                        csvId = 131
                    case 7:
                        csvId = 133
                    case 8:
                        csvId = 141
                    default: break
                    }
                    
                    label.text = lxArr[String(csvId)]
                } else if index == 1 {
                    let label = view.viewWithTag(10 + i) as! UILabel
                    var csvId = 0
                    switch i {
                    case 0:
                        csvId = 142
                    case 1:
                        csvId = 144
                    case 2:
                        csvId = 146
                    case 3:
                        csvId = 148
                    case 4:
                        csvId = 149
                    case 5:
                        csvId = 151
                    case 6:
                        csvId = 153
                    case 7:
                        csvId = 155
                    case 8:
                        csvId = 141
                    default: break
                    }
                    
                    label.text = lxArr[String(csvId)]
                    
                }  else if index == 2 {
                    
                    let label = view.viewWithTag(10 + i) as! UILabel
                    var csvId = 0
                    switch i {
                    case 0:
                        csvId = 157
                    case 1:
                        csvId = 159
                    case 2:
                        csvId = 161
                    case 3:
                        csvId = 163
                    case 4:
                        csvId = 164
                    case 5:
                        csvId = 166
                    case 6:
                        csvId = 168
                    case 7:
                        csvId = 170
                    case 8:
                        csvId = 141
                    default: break
                    }
                    
                    label.text = lxArr[String(csvId)]
                    
                } else{
                    if i < 5{
                        let label = view.viewWithTag(20 + i) as! UILabel
                        var csvId = 0
                        switch i {
                        case 0:
                            csvId = 171
                        case 1:
                            csvId = 173
                        case 2:
                            csvId = 175
                        case 3:
                            csvId = 176
                        case 4:
                            csvId = 178
                        case 5:
                            csvId = 181
                        case 6:
                            csvId = 141
                        default: break
                        }
                        
                        label.text = lxArr[String(csvId)]
                    }
                }
            }
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

 
