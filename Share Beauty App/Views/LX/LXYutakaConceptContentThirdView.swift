//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXYutakaConceptContentThirdView: UIView {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    func setUI(){
        let ud = UserDefaults.standard
        let items :[String:String] = ud.object(forKey: "LX_ARR") as! [String : String]
        for i in 0..<5 {
            let label = self.viewWithTag(i + 10) as! UILabel
            let content = items[String(format: "%d", i + 110)]
            label.text = content
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
}
