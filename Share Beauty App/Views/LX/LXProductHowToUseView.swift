//
//  LXGreenTeaView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXProductHowToUseView: UIView{

    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))

    func setUI(productId: Int) {
        let lxArr = LanguageConfigure.lxcsv
        if productId == 522 {
            let firstView = self.viewWithTag(100)! as UIView
            firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
            self.addSubview(firstView)
            for i in 0..<10 {
                let label = firstView.viewWithTag(10 + i) as! UILabel
                let csvId = 315 + i
                label.text = lxArr[String(csvId)]
                
            }
        } else {
            let firstView = self.viewWithTag(101)! as UIView
            firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
            self.addSubview(firstView)
            for i in 0..<9 {
                let label = firstView.viewWithTag(10 + i) as! UILabel
                let csvId = 338 + i
                label.text = lxArr[String(csvId)]
                
            }
        }
        
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal) 
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }

}
