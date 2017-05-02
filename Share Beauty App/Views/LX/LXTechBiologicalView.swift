//
//  LXGreenTeaView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXTechBiologicalView: UIView{

    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))
    @IBOutlet weak var mScrollV: UIScrollView!

    func setUI() {
        self.mScrollV.contentSize = CGSize(width: 959, height: 984)
        let firstView = self.viewWithTag(100)! as UIView
        firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
        self.mScrollV.addSubview(firstView)
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }

}
