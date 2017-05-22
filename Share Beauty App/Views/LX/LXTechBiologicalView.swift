//
//  LXGreenTeaView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXTechBiologicalView: UIView, UIScrollViewDelegate{

    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))
    @IBOutlet weak var mScrollV: UIScrollView!
    var isAnimated = false
    func setUI() {
        self.mScrollV.contentSize = CGSize(width: 959, height: 984)
        let firstView = self.viewWithTag(100)! as UIView
        firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
        let lxArr = LanguageConfigure.lxcsv
        for i in 0..<24 {
            let label = firstView.viewWithTag(10 + i) as! UILabel
            let csvId = 226 + i
            label.text = lxArr[String(csvId)]
        }
        self.mScrollV.delegate = self
        self.mScrollV.addSubview(firstView)
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
            let bg = self.viewWithTag(50)
            bg?.alpha = 1
            let bg2 = self.viewWithTag(51)
            bg2?.alpha = 1
        }, completion: nil) 
        UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveEaseOut], animations: {
            let bg = self.viewWithTag(52)
            bg?.alpha = 1
            let bg2 = self.viewWithTag(53)
            bg2?.alpha = 1
        }, completion: nil) 
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseOut], animations: {
            let bg = self.viewWithTag(54)
            bg?.alpha = 1
        }, completion: nil) 
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.mScrollV.contentOffset.y + self.mScrollV.frame.size.height > self.mScrollV.contentSize.height && self.mScrollV.isDragging {

            if self.isAnimated { return }
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut], animations: {
                let graph = self.viewWithTag(60)
                graph?.frame = CGRect(x: 153, y: 825, width: 29, height: 49)
            }, completion: nil) 
            UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveEaseOut], animations: {
                let graph = self.viewWithTag(61)
                graph?.frame = CGRect(x: 233, y: 696, width: 29, height: 178)
            }, completion: nil) 
            UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseOut], animations: {
                let graph = self.viewWithTag(62)
                graph?.frame = CGRect(x: 677, y: 801, width: 29, height: 73)
            }, completion: nil)
            UIView.animate(withDuration: 1.0, delay: 3.0, options: [.curveEaseOut], animations: {
                let graph = self.viewWithTag(63)
                graph?.frame = CGRect(x: 755, y: 750, width: 29, height: 124)
            }, completion: nil) 
            self.isAnimated = true
        }
    }

}
