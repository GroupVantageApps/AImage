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

    var mContentV: UIView!

    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(){
        mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: self.size.width*4, height: self.size.height))
        mXbutton.setImage( FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        self.mScrollV.contentSize = CGSize(width: 960 * 4, height: self.size.height)
        self.mScrollV.isPagingEnabled = true
        self.mScrollV.delaysContentTouches = false
        self.mScrollV.canCancelContentTouches = true
        
        let lxArr = LanguageConfigure.lxcsv
        for index in 0..<4 {
            let view: LXProductGraphContentView = UINib(nibName: "LXProductGraphContentView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductGraphContentView
            view.frame = CGRect(x:  960 * index, y: 0, width: 960, height: Int(self.size.height))
            print(Int(self.size.height))
            if index == 3{
                let subview = view.viewWithTag(201)
                view.maxCount = 6
//                view.mImageView2.image = UIImage(named: String(format: "lx_product_graph_%d",index + 1))
                subview?.isHidden = false
                if self.size.height != 700 {
                    view.mConstraintFirstBottom.constant = 20
                    view.mConstraintFirstTop.constant = 20
                }
            } else {
                
                if self.size.height != 700 {
                    view.mConstraintSecondBottom.constant = 20
                    view.mConstraintSecondTop.constant = 56
                }
//                view.mImageView.image = UIImage(named: String(format: "lx_product_graph_%d",index + 1))
            }
            self.mContentV.addSubview(view)
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
            if index != 3 {
                for i in 0..<6 {
                    let circleV = view.viewWithTag(50 + i) as! CircleGraphView
                    let contentStr = lxArr["127"]
                    var csvId = 128 + i*2 + index*15
                    if i > 2 { csvId = csvId + 1 }
                    let percentStr = lxArr[String(csvId)]
                    print("\(csvId):\(percentStr)")
                    let image = String(format: "lx_graph_%@", (percentStr?.replacingOccurrences(of: "%", with: ""))!)
                    print(image)
                    circleV.graphImgV.image = UIImage(named: image)
                    circleV.contentLabel.text = contentStr
                    circleV.percentLabel.text = percentStr
                    circleV.drawCircle()
                }
            } else {
                let subview = view.viewWithTag(201)
                for i in 0..<4 {
                    let circleV = subview?.viewWithTag(50 + i) as! CircleGraphView
                    let contentStr = lxArr["127"]
                    var csvId = 172 + i*2
                    if i > 1 { csvId = csvId + 1 }
                    let percentStr = lxArr[String(csvId)]
                    print("\(csvId):\(percentStr)")
                    let image = String(format: "lx_graph_%@", (percentStr?.replacingOccurrences(of: "%", with: ""))!)
                    print((percentStr?.replacingOccurrences(of: "%", with: ""))!)
                    circleV.graphImgV.image = UIImage(named: image)
                    circleV.contentLabel.text = contentStr
                    circleV.percentLabel.text = percentStr
                    circleV.drawCircle()
                }
            }
            
            view.tag = 100 + index
        }
        self.mScrollV.addSubview(mContentV)
        
        self.mScrollV.minimumZoomScale = 1.0
        self.mScrollV.maximumZoomScale = 6.0

        self.mScrollV.delegate = self
        // The total number of pages that are available is based on how many available colors we have.
        self.mPageControl.numberOfPages = 4
        self.mPageControl.currentPage = 0
        self.mPageControl.frame = CGRect(x: 960/2 - 100, y: self.size.height - 45, width: 200, height: 50)
        self.mPageControl.pageIndicatorTintColor = UIColor.lightGray
        self.mPageControl.currentPageIndicatorTintColor = UIColor(red: 171.0/255, green: 154.0/255, blue: 89.0/255, alpha: 1.0)
        self.addSubview(mPageControl)
        self.mPageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.mPageControl.currentPage = Int(pageNumber)
        self.startAnimation(tag: 100 + Int(pageNumber))
    }
    func changePage(sender: AnyObject) {
        let x = CGFloat(mPageControl.currentPage) * self.mScrollV.frame.size.width
        self.mScrollV.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    func close() {
        self.isHidden = true
        print("Button pressed")
    }

    func updateAnimation(view: LXProductGraphContentView) {
        var tempV = view as! LXProductGraphContentView
        if tempV.tag == 103 {
            let subV = tempV.viewWithTag(201)
  
            if tempV.animCount < tempV.maxCount {
                if tempV.animCount == 0 || tempV.animCount == 3 {
                    let hiddenV = subV?.viewWithTag(60 + tempV.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        hiddenV?.alpha = 0
                    }, completion: nil)  
                    tempV.animCount = tempV.animCount + 1
                    
                } else {
                    let label = subV?.viewWithTag(20 + tempV.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        label?.alpha = 1
                    }, completion: nil)
                    
                    let pieGraphV = subV?.viewWithTag(50 + tempV.animPieCount) as! CircleGraphView 
                    pieGraphV.drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 1.0, toValue: 0.0, duration: 1.0, repeatCount: 1.0)
                    tempV.animCount = tempV.animCount + 1
                    tempV.animPieCount = tempV.animPieCount + 1
                }
            } else {
                
            }
        } else {
            if tempV.animCount < tempV.maxCount {
                if tempV.animCount == 0 || tempV.animCount == 4 {
                    let hiddenV = tempV.viewWithTag(60 + tempV.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        hiddenV?.alpha = 0
                    }, completion: nil)  
                    tempV.animCount = tempV.animCount + 1
                } else {
                    let label = tempV.viewWithTag(10 + tempV.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        label?.alpha = 1
                    }, completion: nil)
                    let pieGraphV = tempV.viewWithTag(50 + tempV.animPieCount) as! CircleGraphView 
                    pieGraphV.drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 1.0, toValue: 0.0, duration: 1.0, repeatCount: 1.0)
                    tempV.animCount = tempV.animCount + 1
                    tempV.animPieCount = tempV.animPieCount + 1
                }
            } else {
                
            }
        }
    }
    func startAnimation(tag: Int){
        let view = self.mScrollV.viewWithTag(tag) as! LXProductGraphContentView
        if view.hasAnimated { return }
        
        for i in 0..<view.maxCount {
            self.updateAnimation(view: view)
        }

        view.hasAnimated = true
        
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

 
