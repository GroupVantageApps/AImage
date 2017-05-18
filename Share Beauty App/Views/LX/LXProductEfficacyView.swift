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

    @IBOutlet weak var c1GraphV: UIView!
    @IBOutlet weak var c2GraphV: UIView!
    @IBOutlet weak var c3GraphV: UIView!
    @IBOutlet weak var c4GraphV: UIView!
    
    @IBOutlet weak var intensiveV: UIView!
    
    @IBOutlet weak var intensiveGraphV: UIView!
    
    @IBOutlet weak var eyeGrapgV: UIView!
    
    @IBOutlet weak var baV: UIView!
    
    @IBOutlet weak var afterImgV: UIImageView!
    @IBOutlet weak var beforeImgV: UIImageView!
    var hasAnimated: Bool = false 
    var animCount :Int = 0
    var animPieCount :Int = 0
    var maxCount = 8
    var secondPageTag = 0
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(productId: Int){
        
        let lxArr = LanguageConfigure.lxcsv
        
        if productId == 516 {
            self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let efficacyV: LXEfficacyPenetrationView = UINib(nibName: "LXEfficacyPenetrationView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXEfficacyPenetrationView
            efficacyV.setUI()
            efficacyV.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            self.mContentV.addSubview(efficacyV)
            
            let secondV = self.c1GraphV
            secondV?.tag = 200
            secondPageTag = (secondV?.tag)!
            secondV?.frame  = CGRect(x: 960, y: 0, width: 960, height: 700)
            for i in 0..<8 {
                let label = secondV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 200
                case 1:
                    csvId = 202
                case 2:
                    csvId = 204
                case 3:
                    csvId = 205
                case 4:
                    csvId = 207
                case 5:
                    csvId = 208
                case 6:
                    csvId = 210
                case 7:
                    csvId = 211
                default: break
                }
                label.text = lxArr[String(csvId)]
            }

            for i in 0..<4 {
                let circleV = secondV?.viewWithTag(50 + i) as! CircleGraphView
                let contentStr = lxArr["127"]
                var csvId = 201 + i*2
                if i > 1 {  csvId = 200 + i*3}
                var percentStr = lxArr[String(csvId)]
                percentStr = percentStr?.replacingOccurrences(of: "%", with: "")
                percentStr = percentStr?.replacingOccurrences(of: " ", with: "")
                print("\(csvId):\(percentStr)")
                let image = String(format: "lx_graph_%@", percentStr!)
                circleV.graphImgV.image = UIImage(named: image)
                circleV.contentLabel.text = contentStr
                circleV.percentLabel.text = percentStr
                circleV.drawCircle()
            }

            self.mContentV.addSubview(secondV!)
            print(self.mContentV.subviews)
            
            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else if productId == 517 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let firstV = self.baV
            firstV?.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            for i in 0..<4 {
                let label = firstV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 212
                case 1:
                    csvId = 213
                case 2:
                    csvId = 214
                case 3:
                    csvId = 215
                default: break
                }
                label.text = lxArr[String(csvId)]
            }
            self.mContentV.addSubview(firstV!)

            
            let secondV = self.c2GraphV
            secondV?.tag = 201
            secondPageTag = (secondV?.tag)!
            secondV?.frame  = CGRect(x: 960, y: 0, width: 960, height: 700)
            for i in 0..<7 {
                let label = secondV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 216
                case 1:
                    csvId = 218
                case 2:
                    csvId = 219
                case 3:
                    csvId = 221
                case 4:
                    csvId = 222
                case 5:
                    csvId = 224
                case 6:
                    csvId = 225
                default: break
                }
                label.text = lxArr[String(csvId)]
            }
            
            for i in 0..<3 {
                let circleV = secondV?.viewWithTag(50 + i) as! CircleGraphView
                let contentStr = lxArr["127"]
                let csvId = 217 + i*3
                var percentStr = lxArr[String(csvId)]
                percentStr = percentStr?.replacingOccurrences(of: "%", with: "")
                percentStr = percentStr?.replacingOccurrences(of: " ", with: "")
                print("\(csvId):\(percentStr)")
                let image = String(format: "lx_graph_%@", percentStr!)
                circleV.graphImgV.image = UIImage(named: image)
                circleV.contentLabel.text = contentStr
                circleV.percentLabel.text = percentStr
                circleV.drawCircle()
            }
            self.mContentV.addSubview(secondV!)

            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else if productId == 519 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let firstV = self.c3GraphV
            firstV?.tag = 202
            firstV?.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            for i in 0..<9 {
                let label = firstV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 250
                case 1:
                    csvId = 252
                case 2:
                    csvId = 253
                case 3:
                    csvId = 255
                case 4:
                    csvId = 256
                case 5:
                    csvId = 258
                case 6:
                    csvId = 259
                case 7:
                    csvId = 261
                case 8:
                    csvId = 262
                default: break
                }
                label.text = lxArr[String(csvId)]
            }
            for i in 0..<4 {
                let circleV = firstV?.viewWithTag(50 + i) as! CircleGraphView
                let contentStr = lxArr["127"]
                let csvId = 251 + i*3
                var percentStr = lxArr[String(csvId)]
                percentStr = percentStr?.replacingOccurrences(of: "%", with: "")
                percentStr = percentStr?.replacingOccurrences(of: " ", with: "")
                print("\(csvId):\(percentStr)")
                let image = String(format: "lx_graph_%@", percentStr!)
                circleV.graphImgV.image = UIImage(named: image)
                circleV.contentLabel.text = contentStr
                circleV.percentLabel.text = percentStr
                circleV.drawCircle()
            }
            self.mContentV.addSubview(firstV!)
            
            let secondV = self.c4GraphV
            secondV?.tag = 203
            secondPageTag = (secondV?.tag)!
            secondV?.frame  = CGRect(x: 960, y: 0, width: 960, height: 700)
            for i in 0..<9 {
                let label = secondV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 263
                case 1:
                    csvId = 265
                case 2:
                    csvId = 266
                case 3:
                    csvId = 268
                case 4:
                    csvId = 269
                case 5:
                    csvId = 271
                case 6:
                    csvId = 272
                case 7:
                    csvId = 274
                case 8:
                    csvId = 275
                default: break
                }
                label.text = lxArr[String(csvId)]
            }
            for i in 0..<4 {
                let circleV = secondV?.viewWithTag(50 + i) as! CircleGraphView
                let contentStr = lxArr["127"]
                let csvId = 264 + i*3
                var percentStr = lxArr[String(csvId)]
                percentStr = percentStr?.replacingOccurrences(of: "%", with: "")
                percentStr = percentStr?.replacingOccurrences(of: " ", with: "")
                print("\(csvId):\(percentStr)")
                let image = String(format: "lx_graph_%@", percentStr!)
                circleV.graphImgV.image = UIImage(named: image)
                circleV.contentLabel.text = contentStr
                circleV.percentLabel.text = percentStr
                circleV.drawCircle()
            }
            self.mContentV.addSubview(secondV!)
            
            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else  if productId ==  523 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960 * 2, height: 700))
            let firstV = self.intensiveV
            firstV?.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            for i in 0..<5 {
                let label = firstV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 348
                case 1:
                    csvId = 349
                case 2:
                    csvId = 350
                case 3:
                    csvId = 351
                case 4:
                    csvId = 352
                default: break
                }
                label.text = lxArr[String(csvId)]
            }
            self.mContentV.addSubview(firstV!)
            
            
            
            let secondV = self.intensiveGraphV
            secondV?.tag = 204
            secondPageTag = (secondV?.tag)!
            secondV?.frame  = CGRect(x: 960, y: 0, width: 960, height: 700)
            for i in 0..<9 {
                let label = secondV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 353
                case 1:
                    csvId = 355
                case 2:
                    csvId = 356
                case 3:
                    csvId = 358
                case 4:
                    csvId = 359
                case 5:
                    csvId = 361
                case 6:
                    csvId = 362
                case 7:
                    csvId = 364
                case 8:
                    csvId = 365
                default: break
                }
                label.text = lxArr[String(csvId)]
            }
            for i in 0..<4 {
                let circleV = secondV?.viewWithTag(50 + i) as! CircleGraphView
                let contentStr = lxArr["127"]
                let csvId = 354 + i*3
                var percentStr = lxArr[String(csvId)]
                percentStr = percentStr?.replacingOccurrences(of: "%", with: "")
                percentStr = percentStr?.replacingOccurrences(of: " ", with: "")
                print("\(csvId):\(percentStr)")
                let image = String(format: "lx_graph_%@", percentStr!)
                print(image)
                circleV.graphImgV.image = UIImage(named: image)
                circleV.contentLabel.text = contentStr
                circleV.percentLabel.text = percentStr
                circleV.drawCircle()
            }
            self.mContentV.addSubview(secondV!)
            
            self.mPageControl.numberOfPages = 2
            self.mScrollV.contentSize = CGSize(width: 960 * 2, height: self.size.height)
            self.mScrollV.addSubview(self.mContentV) 
        } else  if productId == 522 {
             self.mContentV = UIView.init(frame: CGRect(x: 0, y: 0, width: 960, height: 700))
            let firstV = self.eyeGrapgV
            firstV?.tag = 205
            firstV?.frame  = CGRect(x: 0, y: 0, width: 960, height: 700)
            for i in 0..<9 {
                let label = firstV?.viewWithTag(10 + i) as! UILabel
                var csvId = 0
                switch i {
                case 0:
                    csvId = 325
                case 1:
                    csvId = 327
                case 2:
                    csvId = 328
                case 3:
                    csvId = 330
                case 4:
                    csvId = 331
                case 5:
                    csvId = 333
                case 6:
                    csvId = 334
                case 7:
                    csvId = 336
                case 8:
                    csvId = 337
                default: break
                }
                label.text = lxArr[String(csvId)]
            }
            for i in 0..<4 {
                let circleV = firstV?.viewWithTag(50 + i) as! CircleGraphView
                let contentStr = lxArr["127"]
                let csvId = 326 + i*3
                var percentStr = lxArr[String(csvId)]
                percentStr = percentStr?.replacingOccurrences(of: "%", with: "")
                percentStr = percentStr?.replacingOccurrences(of: " ", with: "")
                print("\(csvId):\(percentStr)")
                let image = String(format: "lx_graph_%@", percentStr!)
                print(image)
                circleV.graphImgV.image = UIImage(named: image)
                circleV.contentLabel.text = contentStr
                circleV.percentLabel.text = percentStr
                circleV.drawCircle()
            }
            self.mContentV.addSubview(firstV!)
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
        if  Int(pageNumber) == 1 {
            self.startAnimation(tag: secondPageTag)
        }
    }
    func changePage(sender: AnyObject) {
        let x = CGFloat(mPageControl.currentPage) * self.mScrollV.frame.size.width
        self.mScrollV.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.mContentV
    }

    func close() {
        self.isHidden = true
        print("Button pressed")
    }
    
    @IBAction func changeValue(_ sender: UISlider) {
        print(Float(sender.value))
        self.beforeImgV.alpha = 1 - CGFloat(Float(sender.value))
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            self.mScrollV.isPagingEnabled = true
        } else {
            self.mScrollV.isPagingEnabled = false        
        }
    }
    
    func updateAnimation(timer: Timer) {
        // do something
        let userInfo = timer.userInfo as! Dictionary<String, AnyObject>
        var tempV = userInfo["view"]
        if tempV?.tag == 200 {
            if self.animCount < self.maxCount {
                if self.animCount == 0 || self.animCount == 3  || self.animCount == 5 {
                    let hiddenV = tempV?.viewWithTag(60 + self.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        hiddenV?.alpha = 0
                    }, completion: nil)  
                    self.animCount = self.animCount + 1
                    
                } else {
                    let label = tempV?.viewWithTag(10 + self.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        label?.alpha = 1
                    }, completion: nil)
                    
                    if self.animCount == 2 {
                        let hiddenV = tempV?.viewWithTag(60 + self.animCount)
                        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                            hiddenV?.alpha = 0
                        }, completion: nil) 
                    }
                    let pieGraphV = tempV?.viewWithTag(50 + self.animPieCount) as! CircleGraphView 
                    pieGraphV.drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 1.0, toValue: 0.0, duration: 1.0, repeatCount: 1.0)
                    self.animCount = self.animCount + 1
                    self.animPieCount = self.animPieCount + 1
                }
            } else {
                timer.invalidate()
            }
        } else if tempV?.tag == 201 {
            if self.animCount < self.maxCount {
                if self.animCount == 0 || self.animCount == 2  || self.animCount == 4 {
                    let hiddenV = tempV?.viewWithTag(60 + self.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        hiddenV?.alpha = 0
                    }, completion: nil)  
                    self.animCount = self.animCount + 1
                    
                } else {
                    let label = tempV?.viewWithTag(10 + self.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        label?.alpha = 1
                    }, completion: nil)
                    
                    let pieGraphV = tempV?.viewWithTag(50 + self.animPieCount) as! CircleGraphView 
                    pieGraphV.drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 1.0, toValue: 0.0, duration: 1.0, repeatCount: 1.0)
                    self.animCount = self.animCount + 1
                    self.animPieCount = self.animPieCount + 1
                }
            } else {
                timer.invalidate()
            }
        } else {
            if self.animCount < self.maxCount {
                if self.animCount == 0 || self.animCount == 2  || self.animCount == 4  || self.animCount == 6 {
                    let hiddenV = tempV?.viewWithTag(60 + self.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        hiddenV?.alpha = 0
                    }, completion: nil)  
                    self.animCount = self.animCount + 1
                    
                } else {
                    let label = tempV?.viewWithTag(10 + self.animCount)
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                        label?.alpha = 1
                    }, completion: nil)
                    
                    let pieGraphV = tempV?.viewWithTag(50 + self.animPieCount) as! CircleGraphView 
                    pieGraphV.drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 1.0, toValue: 0.0, duration: 1.0, repeatCount: 1.0)
                    self.animCount = self.animCount + 1
                    self.animPieCount = self.animPieCount + 1
                }
            } else {
                timer.invalidate()
            }
        }
    }

    func startAnimation(tag: Int){
        let view = self.mScrollV.viewWithTag(tag)
        if tag == secondPageTag {
            if self.hasAnimated { return }
            self.animCount = 0
            self.animPieCount = 0
            if tag == 200 {
                self.maxCount = 7
            } else if tag == 201 {
                self.maxCount = 6
            }
            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateAnimation), userInfo: [ "view" : view ], repeats: true)
            timer.fire()
            
            self.hasAnimated = true
        } else {
            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateAnimation), userInfo: [ "view" : view ], repeats: true)
            timer.fire()
            self.animCount = 0
            self.animPieCount = 0
           
        }     
    }
}
 
