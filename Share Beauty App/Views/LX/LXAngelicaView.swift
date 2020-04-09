//
//  LXCherryGraphView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXAngelicaView: UIView{

    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))

    @IBOutlet weak var mDownImgV: UIImageView!
    
    func setUI() {
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControl.State.normal) 
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        let lxArr = LanguageConfigure.lxcsv
        
        for i in 0..<3 {
            let label = self.viewWithTag(10 + i) as! UILabel
            let csvId = 63 + i
            label.text = lxArr[String(csvId)]
        }
        
        let imageBg = self.viewWithTag(60) as! UIImageView
        imageBg.image = FileTable.getLXFileImage("lx_angelica.png")
        
        
    }

    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }

}
