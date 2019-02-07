//
//  LXTechGeneView.swift
//  Share Beauty App
//
//  Created by Matsuda Hidehiko on 2019/02/07.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXTechGeneView : UIView{
    
    @IBOutlet var mXbutton: UIButton!
    func setUI() {
//        let firstView = self.viewWithTag(100)! as UIView
//        firstView.frame = CGRect(x: 0, y: 0, width: 959, height: 984)
//        self.addSubview(firstView)
        
//        let imageBg = self.viewWithTag(60) as! UIImageView
//        imageBg.image = FileTable.getLXFileImage("lx_aura.png")
        
//        let lxArr = LanguageConfigure.lxcsv
//        for i in 0..<11 {
//            let label = firstView.viewWithTag(10 + i) as! UILabel
//            let csvId = 366 + i
//            label.text = lxArr[String(csvId)]
//            
//        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
}
