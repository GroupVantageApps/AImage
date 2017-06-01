//
//  LXGreenTeaView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXEfficacyPenetrationView: UIView{

    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))

    func setUI() {
        let firstView = self.viewWithTag(100)! as UIView
        firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
        self.addSubview(firstView)
        let lxArr = LanguageConfigure.lxcsv
        let imageBg = self.viewWithTag(60) as! UIImageView
        imageBg.image = FileTable.getLXFileImage("lx_penetration.png")

        for i in 0..<13 {
            let label = self.viewWithTag(10 + i) as! UILabel
            var csvId = 181 + i
            if i > 8 { csvId = csvId + 6 } 
            label.text = lxArr[String(csvId)]
            label.adjustsFontSizeToFitWidth = true
        }
        
        for i in 0..<5 {
            let label = self.viewWithTag(30 + i) as! UILabel
            let label2 = self.viewWithTag(35 + i) as! UILabel
            let label3 = self.viewWithTag(40 + i) as! UILabel
            let csvId = 190 + i
            label.text = lxArr[String(csvId)]
            label2.text = lxArr[String(csvId)]
            label3.text = lxArr[String(csvId)]
            
            label.adjustsFontSizeToFitWidth = true
            label2.adjustsFontSizeToFitWidth = true
            label3.adjustsFontSizeToFitWidth = true
        }
        for i in 0..<3 {
            let label = self.viewWithTag(50 + i) as! UILabel
            let csvId = 195
            label.text = lxArr[String(csvId)]
            label.adjustsFontSizeToFitWidth = true
        }

    }
    
    @IBAction func close(_ sender: Any) {
        self.removeFromSuperview()
    }

}
