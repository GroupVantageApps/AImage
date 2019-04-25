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

class LXTechGeneView : UIView{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var left1: UILabel!
    @IBOutlet weak var left2: UILabel!
    @IBOutlet weak var left3: UILabel!
    @IBOutlet weak var right1: UILabel!
    @IBOutlet weak var right2: UILabel!
    @IBOutlet weak var right3: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    func setUI(){
        
        title.text = AppItemTable.getNameByItemId(itemId: 8448)
        left1.text = AppItemTable.getNameByItemId(itemId: 8449)
        left2.text = AppItemTable.getNameByItemId(itemId: 8450)
        left3.text = AppItemTable.getNameByItemId(itemId: 8451)
        right1.text = AppItemTable.getNameByItemId(itemId: 8452)
        right2.text = AppItemTable.getNameByItemId(itemId: 8453)
        right3.text = AppItemTable.getNameByItemId(itemId: 8454)
        subTitle.text = AppItemTable.getNameByItemId(itemId: 8455)
        
        
        let path = Bundle.main.path(forResource: "obi19aw", ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame =  CGRect(x:0, y: 0, width: 960, height: 700)
        playerLayer.zPosition = -1
        self.layer.insertSublayer(playerLayer, at: 0)
        player.play()
        
        let path2 = Bundle.main.path(forResource: "LXEffectImage", ofType: "mp4")!
        let player2 = AVPlayer(url: URL(fileURLWithPath: path2))
        let playerLayer2 = AVPlayerLayer(player: player2)
        playerLayer2.frame =  CGRect(x:330, y: 190, width: 300, height: 300)
        playerLayer2.zPosition = 1
        self.layer.insertSublayer(playerLayer2, at: 1)
        player2.play()
    }
    

}
