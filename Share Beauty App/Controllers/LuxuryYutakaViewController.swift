//
//  LuxuryYutakaViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation

class LuxuryYutakaViewController: LXBaseViewController, LXNavigationViewDelegte, LXHeaderViewDelegate, LXYutakaConceptViewDelegate ,LXYutakaTreatmentViewDelegate , MoviePlayerViewDelegate, UIScrollViewDelegate{
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeautyA)

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
        treatmentView.setUI()
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
        bgAudioPlayer.pause()
        
        let moviePlay: MoviePlayerView = UINib(nibName: "MoviePlayerView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! MoviePlayerView
        moviePlay.setUI()
        moviePlay.delegate = self
        moviePlay.playMovie(movie: "lx_yutaka")
        self.view.addSubview(moviePlay)
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
