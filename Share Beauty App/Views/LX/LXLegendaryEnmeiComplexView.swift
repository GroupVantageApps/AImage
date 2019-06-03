//
//  LXTechGeneView.swift
//  Share Beauty App
//
//  Created by Matsuda Hidehiko on 2019/02/07.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXLegendaryEnmeiComplexView : UIView{
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var Btn: UILabel!
    
    @IBOutlet weak var desLbl: UILabel!
    
    func setUI() {
        title.text = AppItemTable.getNameByItemId(itemId: 8447)
        desLbl.text = AppItemTable.getNameByItemId(itemId: 8466)
        Btn.text = AppItemTable.getNameByItemId(itemId: 8467)
        
        
    }

}
