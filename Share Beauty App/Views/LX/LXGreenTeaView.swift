//
//  LXGreenTeaView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXGreenTeaView: UIView{

    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))

    @IBOutlet weak var mDownImgV: UIImageView!
    @IBOutlet weak var mUpImgV: UIImageView!
    @IBOutlet weak var mScrollV: UIScrollView!

    func setUI() {
        self.mUpImgV.image = FileTable.getLXFileImage("graphPoint_up.png")
        self.mDownImgV.image = FileTable.getLXFileImage("graphPoint_down.png")
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        let nib = UINib(nibName: "LXGraphView", bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let graphView = views[0] as? LXGraphView else { return }
        let view = self.viewWithTag(30)
        graphView.bgImage = "tea_graph_bg.png"
        view?.addSubview(graphView)
        
        let lxArr = LanguageConfigure.lxcsv
        for i in 0..<5 {
            let label = self.viewWithTag(10 + i) as! UILabel
            var csvId = 55 + i
            if i > 4 { csvId = csvId + 3 }
            label.text = lxArr[String(csvId)]
            
        }
        
        graphView.setUp(left: 30, right: 70, l_title: lxArr["59"]! ,r_title:  lxArr["60"]! )
        
        let nib2 = UINib(nibName: "LXGraphView", bundle: nil)
        
        let views2 = nib2.instantiate(withOwner: self, options: nil)
        guard let graphView2 = views2[0] as? LXGraphView else { return }
        let view2 = self.viewWithTag(31)
        graphView2.bgImage = "tea_graph_bg.png"
        view2?.addSubview(graphView2)
        graphView2.setUp(left: 56, right: 24, l_title: lxArr["59"]! ,r_title: lxArr["60"]! )
        self.mScrollV.contentSize = CGSize(width: 700, height: 838)
        let firstView = self.viewWithTag(100)! as UIView
        firstView.frame = CGRect(x: 0, y: 0, width: 700, height: 838)
        self.mScrollV.addSubview(firstView)
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }

}
