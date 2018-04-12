//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation


protocol LXYutakaTreatmentContentFirstViewDelegate: NSObjectProtocol {
    func playSounds(tag: Int)
} 
class LXYutakaTreatmentContentFirstView: UIView, AVAudioPlayerDelegate {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    var bgAudioPlayer: AVAudioPlayer!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mDescriptionLabel: UILabel!
    @IBOutlet weak var mImgV: UIImageView!

    weak var delegate: LXYutakaTreatmentContentFirstViewDelegate?  
    
    var mPlaySoundVerOne: UIButton!
    var mPlaySoundVerTwo: UIButton!
    
    func setUI(image: String, title: String, description: String, index: Int){
        mPlaySoundVerOne = self.viewWithTag(30) as! UIButton!
        mPlaySoundVerOne.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        mPlaySoundVerOne.tag = index
        mPlaySoundVerOne.setImage(FileTable.getLXFileImage("lx_play_sound_1.png"), for: .normal)
        
        // 音楽再生ボタン追加
        mPlaySoundVerTwo = self.viewWithTag(31) as! UIButton!
        mPlaySoundVerTwo.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        mPlaySoundVerTwo.tag = index + 10
        mPlaySoundVerTwo.setImage(FileTable.getLXFileImage("lx_play_sound_2.png"), for: .normal)

        self.mImgV.image = FileTable.getLXFileImage(image)
        mTitleLabel.text = title
        mDescriptionLabel.text = description
    }

    func playSound (sender: Any) {
        let tag = (sender as AnyObject).tag
        delegate?.playSounds(tag: tag!)
    }

}
