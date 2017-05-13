//
//  LuxuryYutakaViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
class LuxuryYutakaViewController: LXBaseViewController, LXNavigationViewDelegte, LXHeaderViewDelegate, LXYutakaConceptViewDelegate ,LXYutakaTreatmentViewDelegate , MoviePlayerViewDelegate, UIScrollViewDelegate{
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLXYUTAKA)

    @IBOutlet weak var mBGImgV: UIImageView!

    @IBOutlet var mHeaderView: LXHeaderView!
    @IBOutlet var mNavigationView: LXNavigationView!
    private static let outAppInfos = [Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    var bgAudioPlayer: AVAudioPlayer!
    var yAudioPlayer: AVAudioPlayer!
    var mConceptView: LXYutakaConceptView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mScrollV.delegate = self
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        self.mBGImgV.image = FileTable.getLXFileImage("lx_yutaka.png")
        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
        let lxArr = LanguageConfigure.lxcsv

        let conceptBtn = self.view.viewWithTag(30) as! UIButton
        conceptBtn.setTitle(lxArr["67"], for: .normal)
        
        let titleLabel  = self.view.viewWithTag(20) as! UILabel
        titleLabel.text = lxArr["66"]
        let treatmentTitleLabel  = self.view.viewWithTag(21) as! UILabel
        treatmentTitleLabel.text = lxArr["68"] 
        let extraTreatmentTitleLabel  = self.view.viewWithTag(22) as! UILabel
        extraTreatmentTitleLabel.text = lxArr["74"] 
    
        for i in 0..<8 {
            let btn = self.view.viewWithTag(10 + i) as! UIButton
            if i < 5 { 
                let csvId = i + 69
                btn.setTitle(lxArr[String(csvId)], for: .normal)
            } else {
                let csvId = i + 70
                btn.setTitle(lxArr[String(csvId)], for: .normal)
            }
        }
        
        print("LuxuryYutakaViewController.viewDidLoad")
    }

    @IBAction func tappedConceptBtn(_ sender: Any) {
        mConceptView = UINib(nibName: "LXYutakaConceptView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptView
        mConceptView.delegate = self
        mConceptView.setAction()
        mConceptView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(mConceptView)
    }
    override func viewWillAppear(_ animated: Bool) {
        print("LuxuryYutakaViewController.viewWillAppear")
         if (bgAudioPlayer != nil){ bgAudioPlayer.play() }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("LuxuryYutakaViewController.viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("LuxuryYutakaViewController.viewWillDisappear")        
        if (yAudioPlayer != nil) { yAudioPlayer.pause() } 
        bgAudioPlayer.play()
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("LuxuryYutakaViewController.viewDidDisappear")
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
    
    
    @IBAction private func tappedTreatmentBtn(_ sender: AnyObject) {
        let treatmentView = UINib(nibName: "LXYutakaTreatmentView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaTreatmentView
        treatmentView.delegate = self
        treatmentView.setUI(page: sender.tag - 10)
        treatmentView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(treatmentView)
        
    }
    
    func didLXYutakaConceptViewAction(_ type: LXYutakaConceptViewActionType) {
        mConceptView.isHidden = true
        let subView: LXYutakaConceptSubView = UINib(nibName: "LXYutakaConceptSubView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptSubView
        subView.setUI()
        subView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(subView)
        
        switch type {
        case .sounds:
            print("tapped sounds")
        case .tool:
            print("tapped tool")
        case .music:
            print("tapped music")
        case .smell:
            print("tapped smell")
        }
    }
    func movieAct(){
        
        self.bgAudioPlayer.pause()
        
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/lx_yutaka.mp4"))
        let videoURL = NSURL(fileURLWithPath: path)
        let avPlayer: AVPlayer = AVPlayer(url: videoURL as URL)
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        NotificationCenter.default.addObserver(self, selector:#selector(self.endMovie),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayerVc.player?.currentItem)
        self.present(avPlayerVc, animated: true, completion: {
        })
        avPlayer.play()
    }
    
    func endMovie() {
        bgAudioPlayer.play()
    }
    
    func playSounds() {
        //再生する音源のURLを生成.
        bgAudioPlayer.pause()
        let soundFilePath: String = Bundle.main.path(forResource: "yutaka", ofType: "m4a")!
        let fileURL = URL(fileURLWithPath: soundFilePath)
        do {
            try yAudioPlayer = AVAudioPlayer(contentsOf: fileURL)
            yAudioPlayer.play()
        } catch {
            print(error)
        }
    }
}
