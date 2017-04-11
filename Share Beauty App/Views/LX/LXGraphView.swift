//
//  LXGraphView.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/09.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
class LXGraphView: UIView {
    
    @IBOutlet weak private var mImgVBackGround: UIImageView!
    @IBOutlet weak private  var mImgVBashLine: UIImageView!
    @IBOutlet weak private var mVLeftGraph: UIView!
    @IBOutlet weak private var mVRightGraph: UIView!
    @IBOutlet weak private var mBtnLeftGraph: UIButton!
    @IBOutlet weak private var mBtnRightGraph: UIButton!
    
     
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var bgImage: String = "" {
        didSet {
            let image = UIImage(named: bgImage)
            self.mImgVBackGround.image = image
        }
    }
    var isFirstTap :Bool = true
    var right_y : Int = 0
    func setUp(left: Int, right: Int ,l_title: String, r_title: String) {
        self.mImgVBashLine.centerY = CGFloat(left)
        self.right_y = right
        self.mBtnRightGraph.addTarget(self, action: #selector(tappedRightGraphBtn), for: .touchUpInside)
        self.mBtnRightGraph.setTitle(r_title, for: .normal)
        self.mBtnLeftGraph.setTitle(l_title, for: .normal)
        self.mBtnRightGraph.titleLabel?.textAlignment = .center
        self.mBtnLeftGraph.titleLabel?.textAlignment = .center
        self.mBtnLeftGraph.addTarget(self, action: #selector(tappedLeftGraphBtn), for: .touchUpInside)
        self.mImgVBackGround.alpha = 0
        
        let x: Int = Int(self.mVLeftGraph.frame.origin.x) 
        let width: Int = Int(self.mVLeftGraph.bounds.size.width)
        let height = Int(self.bounds.size.height) - left
        UIView.animate(withDuration: 1.0) { () -> Void in
            self.mVLeftGraph.frame = CGRect(x: x, y: left, width: width,height: height)
        }
    }

    func tappedRightGraphBtn() {
        UIView.animate(withDuration: 1.0) { () -> Void in
            self.mImgVBackGround.alpha = 1
        }
        if self.isFirstTap {

            let x: Int = Int(self.mVRightGraph.frame.origin.x) 
            let width: Int = Int(self.mVRightGraph.bounds.size.width)
            let height = Int(self.bounds.size.height) - right_y
            UIView.animate(withDuration: 1.0) { () -> Void in
                self.mVRightGraph.frame = CGRect(x: x, y: self.right_y, width: width,height: height)
            }
            self.isFirstTap = false
        } else {
            UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
                UIView.setAnimationRepeatCount(1.9)
                self.mVRightGraph.alpha = 0
            }, completion: { finished in 
                self.mVRightGraph.alpha = 1
            })
        }
    }
    
    func tappedLeftGraphBtn() {
        self.mImgVBackGround.alpha = 0
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            UIView.setAnimationRepeatCount(1.9)
            self.mVLeftGraph.alpha = 0
        }, completion: { finished in 
            self.mVLeftGraph.alpha = 1
        })
    }
}


