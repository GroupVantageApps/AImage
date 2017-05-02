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
    func playSounds()
} 
class LXYutakaTreatmentContentFirstView: UIView, AVAudioPlayerDelegate {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    var bgAudioPlayer: AVAudioPlayer!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mDescriptionLabel: UILabel!
    @IBOutlet weak var mImgV: UIImageView!

    weak var delegate: LXYutakaTreatmentContentFirstViewDelegate?  
    var mPlaySound: UIButton!
    func setUI(image: String, title: String, description: String){
        mPlaySound = self.viewWithTag(30) as! UIButton!
        mPlaySound.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        mPlaySound.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
        self.mImgV.image = UIImage(named: image)
        mTitleLabel.text = title
        mDescriptionLabel.text = description
    }

    func playSound () {
        delegate?.playSounds()
    }

}
