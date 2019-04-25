//
//  LXTechGeneView.swift
//  Share Beauty App
//
//  Created by Matsuda Hidehiko on 2019/02/07.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class LXTechGene2View : UIView{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var left1: UILabel!
    @IBOutlet weak var left2: UILabel!
    @IBOutlet weak var left3: UILabel!
    @IBOutlet weak var right1: UILabel!
    @IBOutlet weak var right2: UILabel!
    @IBOutlet weak var right3: UILabel!
    @IBOutlet weak var right4: UILabel!
    @IBOutlet weak var right5: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    func setUI() {
        title.text = AppItemTable.getNameByItemId(itemId: 8456)
        left1.text = AppItemTable.getNameByItemId(itemId: 8447)
        left2.text = AppItemTable.getNameByItemId(itemId: 8449)
        left3.text = AppItemTable.getNameByItemId(itemId: 8452)
        right1.text = AppItemTable.getNameByItemId(itemId: 8457)
        right2.text = AppItemTable.getNameByItemId(itemId: 8458)
        right3.text = AppItemTable.getNameByItemId(itemId: 8459)
        right4.text = AppItemTable.getNameByItemId(itemId: 8460)
        right5.text = AppItemTable.getNameByItemId(itemId: 8461)
        subTitle.text = AppItemTable.getNameByItemId(itemId: 8462)
        
        
        let path = Bundle.main.path(forResource: "LxEffectImageP2", ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame =  CGRect(x:0, y: 0, width: 960, height: 700)
        playerLayer.zPosition = -1
        self.layer.insertSublayer(playerLayer, at: 0)
        player.play()

    }


}
