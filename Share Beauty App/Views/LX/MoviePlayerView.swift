//
//  MoviePlayerView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/03/09.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

protocol MoviePlayerViewDelegate: NSObjectProtocol {
    func endMovie(type: Int)
}
class MoviePlayerView: UIView {
    weak var delegate: MoviePlayerViewDelegate?
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var type: Int = 0
    var isTop: Bool = false
    let mXbutton = UIButton(frame: CGRect(x: 987, y: 38.7, width: 38, height: 38))
    
    func setUI() {
        if !isTop {
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        }
        self.frame = CGRect(x: 0, y: 22, width: 1024, height: 746)
        self.addSubview(mXbutton)
    }
    
    func playMovie(movie: String) {
        
        let path = Utility.getDocumentPath(String(format: "%@.mp4",movie))
        let videoURL = NSURL(fileURLWithPath: path)
        player = AVPlayer(url: videoURL as URL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 1024, height: 746)
        
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.backgroundColor = UIColor.black
        
        self.layer.addSublayer(playerLayer)
        player.play()
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHidden = true
        self.player!.pause()
        self.playerLayer!.removeFromSuperlayer()
        delegate?.endMovie(type: type)
    }
    
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
        self.player!.pause()
        self.playerLayer!.removeFromSuperlayer()
        delegate?.endMovie(type: type)
    }
    func playerDidFinishPlaying(note: NSNotification) {
        print("end moive")
        if type == 0 {
            self.isHidden = true
            self.player!.pause()
            self.playerLayer!.removeFromSuperlayer()
            delegate?.endMovie(type: type)
        } else if type == 2  {
            UIView.animate(withDuration: 1.0, animations: {
                self.alpha = 0.0
            }, completion: { (finished: Bool) in
                self.isHidden = true
                self.player!.pause()
                self.playerLayer!.removeFromSuperlayer()
                self.delegate?.endMovie(type: self.type)
            })
        }
        else {
            self.player.seek(to: kCMTimeZero)
            self.player.play()
        }
    }
}


