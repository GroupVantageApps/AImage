//
//  AVPlayerView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import AVFoundation
import UIKit
class AVPlayerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
