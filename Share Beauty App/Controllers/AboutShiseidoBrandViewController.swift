//
//  AboutShiseidoBrandViewController.swift
//  Share Beauty App
//
//  Created by 久保島 祐磨 on 2017/04/16.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class AboutShiseidoBrandViewController: UIViewController, NavigationControllerAnnotation {
	
	// NavigationControllerAnnotation
	weak var delegate: NavigationControllerDelegate?
	var theme: String? = "ABOUT SHISEIDO BRAND"
	var isEnterWithNavigationView: Bool = true
	
	fileprivate var player: AVPlayer!
	fileprivate var timeObserver: Any? = nil
	fileprivate var movieTelop: TelopData!
	fileprivate var currentMovieTelop: TelopData.DataStructTerop? = nil

	@IBOutlet weak var mAVPlayerV: AVPlayerView!
	@IBOutlet weak var mBtnPlay: BaseButton!
	@IBOutlet weak var mTelopLabel: UILabel!
	
	deinit {
		self.delegate?.setAboutShiseidoButtonEnabled(true)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.delegate?.setAboutShiseidoButtonEnabled(false)
		
        self.preparationMovie()
		self.mAVPlayerV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapView(sender:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func willMove(toParentViewController parent: UIViewController?) {
		if parent == nil {
			if let observer = self.timeObserver {
				self.player.removeTimeObserver(observer)
				self.timeObserver = nil
			}
		}
	}
}

// MARK: - UI events
extension AboutShiseidoBrandViewController {
	
	@IBAction func onTapPlay(_ sender: Any) {
		self.player.play()
		self.mBtnPlay.isHidden = true
	}
	
	@objc fileprivate func onTapView(sender: UITapGestureRecognizer) {
		self.player.pause()
		self.mBtnPlay.isHidden = false
	}
}

// MARK: - Private functions
private extension AboutShiseidoBrandViewController {
	
	// 動画準備
	func preparationMovie() {
		let movieId: Int = 6075
		self.player = AVPlayer(url: FileTable.getPath(movieId))
		
		let layer = self.mAVPlayerV.layer as! AVPlayerLayer
		layer.videoGravity = AVLayerVideoGravityResizeAspect
		layer.player = player
		
		// 動画テロップデータ読み込み
		self.movieTelop = TelopData(movieId: movieId)
		
		// 再生位置を監視し、テロップを表示する
		let detectionInterval = CMTime(seconds: 1.0, preferredTimescale: 10)
		self.timeObserver = self.player.addPeriodicTimeObserver(forInterval: detectionInterval, queue: nil, using: { time in
			// 内部関数: 該当のテロップデータを検索する
			func searchTelop(playbackPosition: Float64) -> TelopData.DataStructTerop? {
				var result: TelopData.DataStructTerop? = nil
				for data in self.movieTelop.datas {
					if data.startTime <= playbackPosition && data.endTime >= playbackPosition {
						result = data
						break
					}
				}
				
				return result
			}
			
			// 内部関数: テロップラベルの更新
			func updateTelopLabel() {
				if let current = self.currentMovieTelop {
					self.mTelopLabel.text = current.content
				} else {
					self.mTelopLabel.text = nil
				}
			}
			
			let playbackPosition = CMTimeGetSeconds(time)
			if let current = self.currentMovieTelop {
				if current.startTime > playbackPosition || current.endTime < playbackPosition {
					self.currentMovieTelop = searchTelop(playbackPosition: playbackPosition)
					updateTelopLabel()
				}
			} else {
				self.currentMovieTelop = searchTelop(playbackPosition: playbackPosition)
				updateTelopLabel()
			}
		})
	}
}
