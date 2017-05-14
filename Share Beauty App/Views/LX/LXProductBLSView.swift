//
//  LXEfficacyResultView.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
protocol LXProductBLSViewDelegate: NSObjectProtocol {
    func movieAct()
} 
class LXProductBLSView: UIView {
    weak var delegate: LXProductBLSViewDelegate? 
    var mframe: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38 , y: 16.7, width: 38, height: 38))
    
    func setUI() {
        
        
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        let lxArr = LanguageConfigure.lxcsv
        for i in 0..<8 {
            let label = self.viewWithTag(10 + i) as! UILabel
            let csvId = 108 + i
            label.text = lxArr[String(csvId)]
        }
        let line = LineDetailData.init(lineId: 1)
        let mUpperSteps = line.step
        let mLowerSteps = mUpperSteps.flatMap {$0.lineStep}
        let products = ProductListData(productIds: mLowerSteps[0].product).products
    }
    
    func close() {
        self.isHidden = true
        print("Button pressed")
    }

    @IBAction func onTapMovie(_ sender: Any) {
        self.isHidden = true
        delegate?.movieAct()
    }
}
