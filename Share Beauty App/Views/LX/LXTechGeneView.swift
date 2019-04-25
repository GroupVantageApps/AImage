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
    
    
    func setUI(){
        
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
