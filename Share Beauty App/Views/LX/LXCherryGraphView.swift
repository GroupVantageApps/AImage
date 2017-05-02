//
//  LXCherryGraphView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/07.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
class LXCherryGraphView: UIView{

    let mXbutton = UIButton(frame: CGRect(x: 664, y: 16.7, width: 38, height: 38))

    @IBOutlet weak var mDownImgV: UIImageView!
    
    func setUI() {
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal) 
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)

        self.mDownImgV.image = FileTable.getLXFileImage("graphPoint_down.png")

        let nib = UINib(nibName: "LXGraphView", bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let graphView = views[0] as? LXGraphView else { return }

        let view = self.viewWithTag(30)
        graphView.bgImage = "sakura_graph_bg.png"
        view?.addSubview(graphView)
        graphView.setUp(left: 28, right: 84, l_title: "Without\nSakura Leaf\nExtract",r_title: "With\nSakura Leaf\nextract")
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
}
