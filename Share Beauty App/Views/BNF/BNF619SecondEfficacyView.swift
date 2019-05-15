//
//  WasoMochiTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

// TODO: productID 619用なのでファイル名など適切に置き換え
import Foundation

class BNF618SecondEfficacyView: UIView {
    @IBOutlet weak var mBeforeImg: UIImageView!
    @IBOutlet weak var mBeforeBtn: UIButton!
    @IBOutlet weak var mAfterBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    
    @IBAction func onTapABBtn(sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        
        if sender.tag == 8312 {
            mBeforeImg.alpha = 0.0
            
            mBeforeBtn.backgroundColor = UIColor.clear
            mBeforeBtn.setTitleColor(UIColor.black, for: .normal)
            mBeforeBtn.isEnabled = true
        } else {
            mBeforeImg.alpha = 1.0
            
            mAfterBtn.backgroundColor = UIColor.clear
            mAfterBtn.setTitleColor(UIColor.black, for: .normal)
            
        }
    }
    
    func setView() {
        for index in 0...4 {
            let tag = index + 8310
            if [1,2].contains(index) {
                let btn: UIButton = self.viewWithTag(tag) as! UIButton
                btn.setTitle(AppItemTable.getNameByItemId(itemId: tag), for: .normal)
            } else {
                let label: UILabel = self.viewWithTag(tag) as! UILabel
                label.text = AppItemTable.getNameByItemId(itemId: tag)
                label.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
}
