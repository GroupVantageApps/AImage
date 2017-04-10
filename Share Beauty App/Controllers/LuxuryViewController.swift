//
//  LuxuryViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
class LuxuryViewController: LXBaseViewController, UIScrollViewDelegate, MoviePlayerViewDelegate, AVAudioPlayerDelegate{
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeautyA)
    weak var delegate: NavigationControllerDelegate?
    private static let outAppInfos = [Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    @IBOutlet var mBtnOutApp: BaseButton!
    private let mDropDown = DropDown()
    var lxArr = [String : String]()
    private var mConstraintWidthZero: NSLayoutConstraint?
    var bgAudioPlayer: AVAudioPlayer!
    var moviePlay: MoviePlayerView!

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
    override func viewDidLoad() {
        super.viewDidLoad()
        mScrollV.delegate = self
        
        lxArr = Utility.csvToArray(file: "010483lx")

        let ud = UserDefaults.standard
        ud.set(lxArr, forKey: "LX_ARR")
        
        self.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        print("LuxuryViewController.viewDidLoad")

        
        moviePlay = UINib(nibName: "MoviePlayerView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! MoviePlayerView
        moviePlay.isTop = true
        moviePlay.delegate = self
        moviePlay.setUI()
        moviePlay.playMovie(movie: "lx_top")
        self.view.addSubview(moviePlay)
        
    }
    @IBAction private func onTapLuxuryMenu(_ sender: AnyObject) {
        print("onTapLuxuryMenu tag:" + sender.tag.description)
        let arrNextVc: [AnyClass] = [LuxuryProductViewController.self,
                                     LuxuryIngredientViewController.self,
                                     LuxuryYutakaViewController.self
        ]
        if LuxuryProductViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryProductViewController", targetClass: arrNextVc[sender.tag]) as! LuxuryProductViewController
            self.navigationController?.pushViewController(toVc, animated: false)
        } else if LuxuryIngredientViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryIngredientViewController", targetClass: arrNextVc[sender.tag]) as! LuxuryIngredientViewController
            toVc.bgAudioPlayer = bgAudioPlayer
            self.navigationController?.pushViewController(toVc, animated: false)

        } else if LuxuryYutakaViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryYutakaViewController", targetClass: arrNextVc[sender.tag]) as! LuxuryYutakaViewController
             toVc.bgAudioPlayer = bgAudioPlayer
            self.navigationController?.pushViewController(toVc, animated: false)

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("LuxuryViewController.viewWillAppear")
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        print("LuxuryViewController.viewDidAppear")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("LuxuryViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("LuxuryViewController.viewDidDisappear")
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
    func endMovie() {
            let soundFilePath: String = Bundle.main.path(forResource: "lx_bg", ofType: "m4a")!
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
