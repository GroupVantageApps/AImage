//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXProductGraphContentView: UIView, UIScrollViewDelegate {    
   
    @IBOutlet weak var mConstraintSecondBottom: NSLayoutConstraint!
    @IBOutlet weak var mConstraintSecondTop: NSLayoutConstraint!
    @IBOutlet weak var mConstraintFirstBottom: NSLayoutConstraint!
    
    @IBOutlet weak var mConstraintFirstTop: NSLayoutConstraint!
    
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mImageView2: UIImageView!
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    var hasAnimated :Bool = false 
    var animCount :Int = 0
    var animPieCount :Int = 0
    var maxCount = 8
    func setUI(){
    }    
}

 
