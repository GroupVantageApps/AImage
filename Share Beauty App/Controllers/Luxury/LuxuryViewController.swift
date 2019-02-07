//
//  LuxuryViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class LuxuryViewController: LXBaseViewController, UIScrollViewDelegate, MoviePlayerViewDelegate, AVAudioPlayerDelegate{
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLXTop)
    weak var delegate: NavigationControllerDelegate?
    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL, Const.outAppInfoUvInfo, Const.outAppInfoSoftener, Const.outAppInfoNavigator]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL]

    @IBOutlet var mBtnOutApp: BaseButton!
    private let mDropDown = DropDown()
    var lxArr = [String : String]()
    private var mConstraintWidthZero: NSLayoutConstraint?
    var bgAudioPlayer: AVAudioPlayer!
    var moviePlay: MoviePlayerView!
    var ndGoProductVC = false
    @IBOutlet weak var mLogoImgV: UIImageView!
    @IBOutlet weak var mTopBGImgV: UIImageView!
    @IBOutlet weak var mBottomLogoImgV: UIImageView!

    func setDropDown(dataSource: [String]) {
        mDropDown.dataSource = dataSource
        mDropDown.anchorView = mBtnOutApp
        mDropDown.bottomOffset = CGPoint(x: 0, y: mBtnOutApp.height)
        mDropDown.selectionAction = { [unowned self] (index, item) in
            self.didSelectOutApp(index: index)
            self.mDropDown.deselectRowAtIndexPath(index)
        }
        mDropDown.direction = .bottom
    }

    @IBOutlet var productBtn: UIButton!
    @IBOutlet var ingredientBtn: UIButton!
    @IBOutlet var yutakaBtn: UIButton!
    @IBOutlet var enmeiBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mScrollV.delegate = self
        
        
        lxArr = LanguageConfigure.lxcsv
        if ((lxArr["1"]?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {    
            
//            productBtn.setTitle(lxArr["1"], for: .normal)
//            ingredientBtn.setTitle(lxArr["2"], for: .normal)
            yutakaBtn.setTitle(lxArr["3"], for: .normal)
//            enmeiBtn.setTitle(lxArr["4"], for: .normal)
            
        } else {   
            
        let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size: 30)   
//            let productBtnString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr["1"]!, attributes: [NSFontAttributeName: font!])
//            productBtnString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr["1"]?.count)!))
//            productBtn.titleLabel?.attributedText = productBtnString
//
//            let ingredientBtnString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr["2"]!, attributes: [NSFontAttributeName: font!])
//            ingredientBtnString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr["2"]?.count)!))
//            ingredientBtn.titleLabel?.attributedText = ingredientBtnString
            
            let yutakaBtnString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr["3"]!, attributes: [NSFontAttributeName: font!])
            yutakaBtnString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr["3"]?.count)!))
            yutakaBtn.titleLabel?.attributedText = yutakaBtnString
//
//            let enmeiBtnString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr["4"]!, attributes: [NSFontAttributeName: font!])
//            enmeiBtnString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr["4"]?.count)!))
//            enmeiBtn.titleLabel?.attributedText = enmeiBtnString
            
//            productBtn.setTitle(lxArr["1"], for: .normal)
//            ingredientBtn.setTitle(lxArr["2"], for: .normal)
            yutakaBtn.setTitle(lxArr["3"], for: .normal)
//            enmeiBtn.setTitle(lxArr["4"], for: .normal)
        }
        
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            self.setDropDown(dataSource: type(of: self).outAppFoundationInfos.map {$0.title})
        } else {
            self.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        }
         print("LuxuryViewController.viewDidLoad")
        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
        
        moviePlay = UINib(nibName: "MoviePlayerView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! MoviePlayerView
        moviePlay.isTop = true
        moviePlay.delegate = self
        moviePlay.setUI()
        moviePlay.playMovie(movie: "lx_movie/lx_movie/lx_top")
        self.view.addSubview(moviePlay)
        
        //self.mTopBGImgV.image = FileTable.getLXFileImage("lx_top_bg.png")
        let image: UIImage = UIImage(named: "page1_visual.png")!
        
        self.mTopBGImgV.image = image
        self.mLogoImgV.image = FileTable.getLXFileImage("lx_top_logo.png")
        self.mBottomLogoImgV.image = FileTable.getLXFileImage("lx_logo.png")
        
        let ingredientImage = UIImage(named: "btn_ingredients.png")
        self.ingredientBtn.setBackgroundImage(ingredientImage, for: .normal)
        //        self.ingredientBtn.setBackgroundImage(FileTable.getLXFileImage("lx_ingredients_btn.png"), for: .normal)
        let productImage = UIImage(named: "btn_products.png")
        self.productBtn.setBackgroundImage(productImage, for: .normal)
//        self.productBtn.setBackgroundImage(FileTable.getLXFileImage("lx_product_btn.png"), for: .normal)
        
        self.yutakaBtn.setBackgroundImage(FileTable.getLXFileImage("lx_yutaka_btn.png"), for: .normal)
        let enmeiImage = UIImage(named: "btn_legendary_enemi.png")
        self.enmeiBtn.setBackgroundImage(enmeiImage, for: .normal)
        
        if ndGoProductVC {
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            let LXProductVc = UIViewController.GetViewControllerFromStoryboard("LuxuryProductViewController", targetClass: LuxuryProductViewController.self) as! LuxuryProductViewController
            navigationController?.pushViewController(LXProductVc, animated: false)
            moviePlay.isHidden = true
        }
        
         //新規動画ID別途付与
        let movieBtn = UIButton()
        movieBtn.frame = CGRect(x: 30, y: self.mVContent.frame.height - 80, width: 60, height: 60)
        movieBtn.setImage(UIImage(named: "btn_next.png"), for: .normal)
        movieBtn.addTarget(self, action: #selector(self.playMovie(_:)), for: .touchUpInside)
        self.mVContent.addSubview(movieBtn)
        self.view.bringSubview(toFront: movieBtn)
    }

    @objc private func playMovie(_ sender: AnyObject){
        print("moviestart")
        bgAudioPlayer.pause()
        
        let videoURL: URL = FileTable.getPath(6719)
        let avPlayer: AVPlayer = AVPlayer(url: videoURL)
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
    
    @IBAction private func onTapLuxuryMenu(_ sender: AnyObject) {
        print("onTapLuxuryMenu tag:" + sender.tag.description)
        let arrNextVc: [AnyClass] = [LuxuryProductViewController.self,
                                     LuxuryIngredientViewController.self,
                                     LuxuryYutakaViewController.self,
                                     LuxuryLegendaryEnmeiViewController.self
        ]
        if LuxuryProductViewController.self == arrNextVc[sender.tag ] {
            let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryProductViewController", targetClass: arrNextVc[sender.tag]) as! LuxuryProductViewController
            toVc.bgAudioPlayer = bgAudioPlayer
            self.navigationController?.pushViewController(toVc, animated: false)
        } else if LuxuryIngredientViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryIngredientViewController", targetClass: arrNextVc[sender.tag]) as! LuxuryIngredientViewController
            toVc.bgAudioPlayer = bgAudioPlayer
            self.navigationController?.pushViewController(toVc, animated: false)

        } else if LuxuryYutakaViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryYutakaViewController", targetClass: arrNextVc[sender.tag]) as! LuxuryYutakaViewController
             toVc.bgAudioPlayer = bgAudioPlayer
            self.navigationController?.pushViewController(toVc, animated: false)
            
        } else if LuxuryLegendaryEnmeiViewController.self == arrNextVc[sender.tag]{
            let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryLegendaryEnmeiViewController", targetClass:arrNextVc[sender.tag]) as! LuxuryLegendaryEnmeiViewController
            
            self.navigationController?.pushViewController(toVc, animated: false)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("LuxuryViewController.viewWillAppear")
        self.navigationController?.isNavigationBarHidden = true
         if (bgAudioPlayer != nil){ bgAudioPlayer.play() }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("LuxuryViewController.viewDidAppear")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("LuxuryViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("LuxuryViewController.viewDidDisappear")
        moviePlay.isHidden = true
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
    @IBAction func outApp(_ sender: Any) {
        mDropDown.show()
    }

    @IBAction func goTop(_ sender: Any) {
        self.showTop()
    }
    
    private func audioSessionInterrupted(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let interruptionTypeRawValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let interruptionType = AVAudioSessionInterruptionType(rawValue: interruptionTypeRawValue) else {
                return
        }    
        
        switch interruptionType {
        case .began:
            print("interruption began")
        case .ended:
            print("interruption ended")
        }
    }
    func endMovie(type: Int) {
        let soundFilePath = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/lx_bg.m4a"))
            let fileURL = URL(fileURLWithPath: soundFilePath)
            do {
                try bgAudioPlayer = AVAudioPlayer(contentsOf: fileURL)
                bgAudioPlayer.delegate = self
                bgAudioPlayer.play()
            } catch {
                print(error)
            }
    }
}
