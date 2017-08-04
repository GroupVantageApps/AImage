//
//  LuxuryIngredientViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
class LuxuryIngredientViewController: LXBaseViewController, LXNavigationViewDelegte, LXHeaderViewDelegate, LXIngredientViewDelegate, MoviePlayerViewDelegate, IngredientSkinGraphViewDelegate, UIScrollViewDelegate{

    @IBOutlet weak var mBGImgV: UIImageView!
    @IBOutlet weak var mAngelicaBtn: UIButton!
    @IBOutlet weak var mCherryBtn: UIButton!
    @IBOutlet weak var mGreenTeaBtn: UIButton!
    @IBOutlet weak var mSkingeneceBtn: UIButton!

    
    
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLXIngredience)
    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Luxury Ingredients"
    var isEnterWithNavigationView: Bool = true
    @IBOutlet var mHeaderView: LXHeaderView!
    @IBOutlet var mNavigationView: LXNavigationView!
    var bgAudioPlayer: AVAudioPlayer!
    private static let outAppInfos = [Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    override func viewDidLoad() {
        super.viewDidLoad()
        mScrollV.delegate = self
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
        
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            print("OutAppBtn Hidden Country")
            mHeaderView.setOutAppEnabled(false)
        }
        
        self.mBGImgV.image = FileTable.getLXFileImage("lx_ingredient.png")
        self.mAngelicaBtn.setImage(FileTable.getLXFileImage("lx_ingredient_btn_2.png"), for: .normal)
        self.mCherryBtn.setImage(FileTable.getLXFileImage("lx_ingredient_btn_3.png"), for: .normal)
        self.mGreenTeaBtn.setImage(FileTable.getLXFileImage("lx_ingredient_btn_4.png"), for: .normal)
        self.mSkingeneceBtn.setImage(FileTable.getLXFileImage("lx_ingredient_btn_1.png"), for: .normal)
        
        let lxArr = LanguageConfigure.lxcsv
        
        for i in 0..<4 {
            let label = self.view.viewWithTag(10 + i) as! UILabel
            let csvId = 13 + i
            label.text = lxArr[String(csvId)]
        }
        
        let showMovieBtn = self.view.viewWithTag(20) as! UIButton!
        showMovieBtn?.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
        showMovieBtn?.addTarget(self, action: #selector(playIngredientMovie), for: .touchUpInside)
        
        print("LuxuryIngredientViewController.viewDidLoad")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("LuxuryIngredientViewController.viewWillAppear")
         if (bgAudioPlayer != nil){ bgAudioPlayer.play() }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("LuxuryIngredientViewController.viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("LuxuryIngredientViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("LuxuryIngredientViewController.viewDidDisappear")
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }

    @IBAction func showSubView(_ sender: Any) {
        let popup: LXIngredientView = UINib(nibName: "LXIngredientView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXIngredientView
        popup.setAction()
        popup.delegate = self
        popup.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(popup)
    }
    
    @IBAction func showGraphView2(_ sender: Any) {
        let greenTeaView: LXGreenTeaView = UINib(nibName: "LXGreenTeaView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXGreenTeaView
        greenTeaView.setUI()
        greenTeaView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(greenTeaView)    }

    @IBAction func showAngelicaGraphView(_ sender: Any) {
        let skingraph: LXAngelicaView = UINib(nibName: "LXAngelicaView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXAngelicaView
        skingraph.setUI()
        skingraph.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(skingraph)
    }
    @IBAction func showCherryGraphView(_ sender: Any) {
        let cherryGraphView: LXCherryGraphView = UINib(nibName: "LXCherryGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXCherryGraphView
        cherryGraphView.setUI()
        cherryGraphView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(cherryGraphView)
    }
    
    func didTapshowSkinGraph() {
        let skingraph: IngredientSkinGraphView = UINib(nibName: "IngredientSkinGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! IngredientSkinGraphView
        skingraph.setUI()
        skingraph.delegate = self
        skingraph.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(skingraph)
    }
    
    func playIngredientMovie(){
        bgAudioPlayer.pause()
        
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/IngredientVIew.mp4"))
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
    func movieAct(){
        
        bgAudioPlayer.pause()
        
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/lx_ingredient.mp4"))
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

    func ingredientMoviePlay(index: Int){
        
        bgAudioPlayer.pause()
        
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/3e%d.mp4",index))
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
}
