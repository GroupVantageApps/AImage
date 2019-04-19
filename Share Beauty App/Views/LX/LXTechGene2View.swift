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
    
    
    func setUI() {
        let path = Bundle.main.path(forResource: "LxEffectImage2", ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame =  CGRect(x:0, y: 0, width: 960, height: 700)
        playerLayer.zPosition = 0
        self.layer.insertSublayer(playerLayer, at: 0)
        player.play()

    }


}
