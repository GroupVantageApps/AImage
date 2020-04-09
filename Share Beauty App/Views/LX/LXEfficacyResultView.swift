//
//  LXEfficacyResultView.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXEfficacyResultView: UIView {
    
    var mframe: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38 , y: 16.7, width: 38, height: 38))
    
    func setUI() {


        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControl.State.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)

        }
    
    @objc func close() {
        self.isHidden = true
        print("Button pressed")
    }
    
  
}
