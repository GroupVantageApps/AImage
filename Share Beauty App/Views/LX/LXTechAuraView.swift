//
//  LXGreenTeaView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXTechAuraView: UIView{

    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))

    func setUI() {
        let firstView = self.viewWithTag(100)! as UIView
        firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
        self.addSubview(firstView)
        
        let imageBg = self.viewWithTag(60) as! UIImageView
        imageBg.image = FileTable.getLXFileImage("lx_aura.png")
        
        let lxArr = LanguageConfigure.lxcsv
        for i in 0..<11 {
            let label = firstView.viewWithTag(10 + i) as! UILabel
            let csvId = 366 + i
            label.text = lxArr[String(csvId)]
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }

}
