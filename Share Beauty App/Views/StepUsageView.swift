//
//  StepUsageView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/06.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

struct MovieInfo {
    var movieId: Int = 0
    var title: String?
    var stepUsageInfos = [StepUsageInfo]()
}

struct StepUsageInfo {
    var stepNumber: Int = 0
    var text: String?
    var startTime: Float64 = 0
    var endTime: Float64 = 0
}

class StepUsageView: BaseView {

    @IBOutlet weak private var mAVPlayerV: AVPlayerView!
    @IBOutlet weak private var mLblStep: UILabel!
    @IBOutlet weak private var mLblTitle: UILabel!
    @IBOutlet weak private var mLblDescription: UILabel!
    private var mStepBtns: [UIButton]!
    @IBOutlet weak private var mVBtns4: UIView!
    @IBOutlet weak private var mVBtns3: UIView!
    @IBOutlet weak var mVBtns2: UIView!

    var stepUsageInfos = [StepUsageInfo]()
    var movieInfo = MovieInfo()
    private var mPlayer: AVPlayer!
    private var mCurrentInfo =  StepUsageInfo()

    private var mAllStepFlg: Bool = false

    private var mTimeObserver: Any?

    var productId = 0

    deinit {
        removeVideo()
    }

    private func makeDummyData() {

//        stepUsageInfos = []
//        for i in 0..<3 {
//            var info = StepUsageInfo()
//            info.stepNumber = i + 1
//            let str = "step\(info.stepNumber) dummy "
//            var combined = ""
//            (0..<20).forEach({ _ in
//                combined += str
//            })
//            info.text = combined
//            info.startTime = Float64(i * 4)
//            info.endTime = info.startTime + Float64(4)
//            stepUsageInfos.append(info)
//        }
    }
    @IBAction func onTap(_ sender: UIButton) {
        self.stopVideo()
        guard let info = (stepUsageInfos.filter{$0.stepNumber == sender.tag})[safe: 0] else {
            return
        }
        mStepBtns.forEach {$0.isSelected = false}
        mStepBtns.filter {$0.tag == sender.tag}[safe: 0]?.isSelected = true
        mAllStepFlg = false
        self.applyInfo(info)
    }

    private func stopVideo() {
        if mTimeObserver != nil {
            mPlayer.removeTimeObserver(mTimeObserver!)
            mTimeObserver = nil
        }
        mPlayer.pause()
    }

    @IBAction func onTapAll(_ sender: Any) {
        self.stopVideo()
        guard let info = (stepUsageInfos.filter{$0.stepNumber == 1})[safe: 0] else {
            return
        }
        mStepBtns.forEach {$0.isSelected = false}
        mStepBtns.filter {$0.tag == 1}[safe: 0]?.isSelected = true
        self.applyInfo(info)
        mAllStepFlg = true
    }

    private func applyInfo(_ info: StepUsageInfo) {
        print("starttime:\(info.startTime)")
        print("endtime:\(info.endTime)")
        mCurrentInfo = info
        mLblStep.text = "Step\(info.stepNumber)"
        mLblDescription.text = info.text
        mPlayer.seek(to: CMTimeMakeWithSeconds(info.startTime, Int32(NSEC_PER_SEC)))

        let endTime = CMTimeMakeWithSeconds(info.endTime, Int32(NSEC_PER_SEC))
        mTimeObserver = mPlayer.addBoundaryTimeObserver(forTimes: [NSValue(time: endTime)], queue: DispatchQueue.main) { [weak self] time in
            if self == nil {return}
            self!.stopVideo()
            if self!.mAllStepFlg {
                self!.autoPlay()
            }
        }
        mPlayer.play()
    }

    private func autoPlay() {
        self.stopVideo()
        guard let info = (stepUsageInfos.filter{$0.stepNumber == mCurrentInfo.stepNumber + 1})[safe: 0] else {
            return
        }
        mStepBtns.forEach {$0.isSelected = false}
        mStepBtns.filter {$0.tag == mCurrentInfo.stepNumber + 1}[safe: 0]?.isSelected = true
        self.applyInfo(info)
    }

    func setup(movieInfo: MovieInfo) {
        self.createVideo(movieInfo: movieInfo)
        self.makeDummyData()
        mLblTitle.text = movieInfo.title
    }

    private func createVideo(movieInfo: MovieInfo) {
        let dic: [Int:UIView] = [2: mVBtns2, 3: mVBtns3, 4: mVBtns4]
        dic.values.forEach {$0.isHidden = true}

        stepUsageInfos = movieInfo.stepUsageInfos
        dic[stepUsageInfos.count]!.isHidden = false
        mStepBtns = (dic[stepUsageInfos.count]!.subviews) as! [UIButton]

        mPlayer = AVPlayer(url: FileTable.getPath(movieInfo.movieId))
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didFinishPlaying),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: mPlayer.currentItem
        )
        let layer = mAVPlayerV.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        layer.player = mPlayer
    }

    func removeVideo() {
        NotificationCenter.default.removeObserver(self)
        let layer = mAVPlayerV.layer as! AVPlayerLayer
        layer.player = nil
        mPlayer = nil
    }
    
    func didFinishPlaying() {
        mPlayer.seek(to: kCMTimeZero)
    }
}
