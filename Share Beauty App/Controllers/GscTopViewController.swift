//
//  GscViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
class GscTopViewController: GscBaseViewController, UIScrollViewDelegate, MoviePlayerViewDelegate, AVAudioPlayerDelegate, GscHeaderViewDelegate{
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLXTop)
    weak var delegate: NavigationControllerDelegate?
    private static let outAppInfos = [Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    @IBOutlet var mBtnOutApp: BaseButton!
    private let mDropDown = DropDown()
    
    @IBOutlet weak var mGscHeaderView: GscHeaderView!
    var lxArr = [String : String]()
    private var mConstraintWidthZero: NSLayoutConstraint?
    var bgAudioPlayer: AVAudioPlayer!
    var moviePlay: MoviePlayerView!
    var moviePlay2: MoviePlayerView!
    var ndGoProductVC = false
    var mSelectType: String = ""
    var mGroupType: String = ""
    var fromFindBtn: Bool = false
    
    @IBOutlet weak var mLogoImgV: UIImageView!
    @IBOutlet weak var mTopBGImgV: UIImageView!
    @IBOutlet weak var mBottomLogoImgV: UIImageView!
    var mTapLabel: UILabel!
    var mFindLabel: UILabel!
    
    var mBaseView: UIView!
    var mSunCareSelectView1: UIView!
    var mSunCareSelectView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mGscHeaderView.delegate = self
        mGscHeaderView.mBtnFind.isHidden = true
        mGscHeaderView.mBtnBack.isHidden = true
        
        let selfWidth = self.view.bounds.width
        let selfHeight = self.view.bounds.height
        
        mScrollV.delegate = self
        
        mGroupType = LanguageConfigure.gscgroup
        
        mGscHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        
        print("GscViewController.viewDidLoad")
//        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
      
    
        mBaseView = UIView.init(frame: CGRect(x: 0, y: 40, width: selfWidth, height: selfHeight - 72 ))
        mVContent.addSubview(mBaseView)
        mVContent.bringSubview(toFront: mGscHeaderView)
        
        let gscArr = LanguageConfigure.gsccsv
        
        if !fromFindBtn {
            moviePlay2 = UINib(nibName: "MoviePlayerView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! MoviePlayerView
            moviePlay2.isTop = true
            moviePlay2.delegate = self
            moviePlay2.type = 2
            moviePlay2.setUI()
            //        moviePlay.playMovie(movie: "gsc_movie/gsc_movie/scMovie2")
            self.view.addSubview(moviePlay2)
            
            
            
            moviePlay = UINib(nibName: "MoviePlayerView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! MoviePlayerView
            moviePlay.isTop = true
            moviePlay.delegate = self
            moviePlay.setUI()
            moviePlay.type = 1
            moviePlay.playMovie(movie: "gsc_movie/gsc_movie/scMovie_top")
            self.view.addSubview(moviePlay)
            
            mTapLabel = UILabel()
            mTapLabel.text = gscArr["2"]
            mTapLabel.textAlignment = .center
            mTapLabel.font = UIFont(name: "Optima-Bold", size: 25.0)
            mTapLabel.textColor = UIColor.white
            mTapLabel.frame = CGRect(x: self.view.bounds.size.width/2 - 250, y: 340, width: 500, height: 100)
            moviePlay.addSubview(mTapLabel)
    
        
            mFindLabel = UILabel()
            mFindLabel.text = gscArr["3"]
            mFindLabel.textAlignment = .center
            mFindLabel.font = UIFont(name: "Optima-Bold", size: 25.0)
            mFindLabel.textColor = UIColor.white
            mFindLabel.frame = CGRect(x: self.view.bounds.size.width/2 - 250, y: 550, width: 500, height: 100)
            moviePlay.addSubview(mFindLabel)
        }
        mGscHeaderView.mLblTitle.text = ""
        mGscHeaderView.mBtnFind.titleLabel?.text = gscArr["3"]
        
        self.setSelet1View()
        self.setSelet2View()
        
        mSunCareSelectView2.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        print("GscViewController.viewWillAppear")
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        print("GscViewController.viewDidAppear")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("GscViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("GscViewController.viewDidDisappear")
        if (moviePlay != nil) && (moviePlay2 != nil) {
            moviePlay.isHidden = true
            moviePlay2.isHidden = true
        }
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
        if type == 1 {
            moviePlay2.playMovie(movie: "gsc_movie/gsc_movie/scMovie2")
        }
    }
    
    func setSelet1View() {
        let gscArr = LanguageConfigure.gsccsv
        
        let selfWidth = self.view.bounds.width
        let selfHeight = self.view.bounds.height
        
        mSunCareSelectView1 = UIView.init(frame: CGRect(x: 0, y: 0, width: selfWidth, height: selfHeight - 72 ))
        mBaseView.addSubview(mSunCareSelectView1)
        
        let bgImg = UIImage.init(named: "suncare_bg")
        let bgImgV = UIImageView.init(image: bgImg)
        bgImgV.frame = CGRect(x: 0, y: 0, width: selfWidth, height: selfHeight - 72 )
        mSunCareSelectView1.addSubview(bgImgV)
        
        //FaceBtn
        let faceBtnImg = UIImage.init(named: "face")
        let faceBtnBGImgV = UIImageView.init(frame: CGRect(x: 0, y: 4, width: selfWidth/2, height: selfHeight - 74))
        faceBtnBGImgV.image = faceBtnImg
        faceBtnBGImgV.contentMode = .scaleAspectFill
        mSunCareSelectView1.addSubview(faceBtnBGImgV)
        let faceBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: selfWidth/2, height: selfHeight - 74))
        faceBtn.addTarget(self, action: #selector(GscTopViewController.onTapFaceBtn), for: .touchUpInside)
        mSunCareSelectView1.addSubview(faceBtn)  
        
        let faceLbl = UILabel.init(frame: CGRect(x: selfWidth/4 - 150 , y: 530, width: 300, height: 50))
        faceLbl.text = gscArr["4"]
        faceLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
        faceLbl.textAlignment = .center
        faceLbl.adjustsFontSizeToFitWidth = true
        faceLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
        mSunCareSelectView1.addSubview(faceLbl) 
        
        //Face&BodyBtn
        let bodyBtnImg = UIImage.init(named: "body")
        let bodyBtnBGImgV = UIImageView.init(frame: CGRect(x: selfWidth/2, y: 3, width: selfWidth/2, height: selfHeight - 72))
        bodyBtnBGImgV.image = bodyBtnImg
        bodyBtnBGImgV.contentMode = .scaleAspectFill
        mSunCareSelectView1.addSubview(bodyBtnBGImgV)
        let bodyBtn = UIButton.init(frame: CGRect(x: selfWidth/2, y: 0, width: selfWidth/2, height: selfHeight - 72))
        bodyBtn.addTarget(self, action: #selector(GscTopViewController.onTapBodyBtn), for: .touchUpInside)
        mSunCareSelectView1.addSubview(bodyBtn)  
        
        let bodyLbl = UILabel.init(frame: CGRect(x: selfWidth/4*3 - 150 , y: 530, width: 300, height: 50))
        bodyLbl.text = gscArr["5"]
        bodyLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
        bodyLbl.textAlignment = .center
        bodyLbl.adjustsFontSizeToFitWidth = true
        bodyLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
        mSunCareSelectView1.addSubview(bodyLbl) 
        

    }
    
    func onTapFaceBtn() {
        if mGroupType == "A" {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("GscResultViewController", targetClass: GscResultViewController.self) as! GscResultViewController
            nextVc.mSelect1Type = "face"
            self.navigationController?.pushViewController(nextVc, animated: false)
        } else {
            mGscHeaderView.mBtnFind.isHidden = false
            mGscHeaderView.mBtnBack.isHidden = false
            
            mSelectType = "face"
            self.mSunCareSelectView1.isHidden = true
            self.mSunCareSelectView2.isHidden = false
            
        }
        
    }
    
    func onTapBodyBtn() {
        if mGroupType == "A" {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("GscResultViewController", targetClass: GscResultViewController.self) as! GscResultViewController
            nextVc.mSelect1Type = "body"
            self.navigationController?.pushViewController(nextVc, animated: false)
        } else {
            mGscHeaderView.mBtnFind.isHidden = false
            
            mSelectType = "body"
            self.mSunCareSelectView1.isHidden = true
            self.mSunCareSelectView2.isHidden = false
        }
        
    }
    
    func setSelet2View() {
        let gscArr = LanguageConfigure.gsccsv
        
        let selfWidth = self.view.bounds.width
        let selfHeight = self.view.bounds.height
        
        mSunCareSelectView2 = UIView.init(frame: CGRect(x: 0, y: 0, width: selfWidth, height: selfHeight - 72 ))
        mBaseView.addSubview(mSunCareSelectView2)
        mBaseView.bringSubview(toFront: mSunCareSelectView2)
        
        let bgImg = UIImage.init(named: "suncare_bg")
        let bgImgV = UIImageView.init(image: bgImg)
        bgImgV.frame = CGRect(x: 0, y: 0, width: selfWidth, height: selfHeight - 72 )
        mSunCareSelectView2.addSubview(bgImgV)
        
        if mGroupType == "E" {
            //Sensitive Btn
            let sensitiveBtnImg = UIImage.init(named: "sensitive")
            let sensitiveBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: selfWidth/4, height: selfHeight - 74))
            sensitiveBtn.addTarget(self, action: #selector(GscTopViewController.onTapSensitiveBtn), for: .touchUpInside)
            sensitiveBtn.setBackgroundImage(sensitiveBtnImg, for: .normal)
            mSunCareSelectView2.addSubview(sensitiveBtn)
            
            let sensitiveLbl = UILabel.init(frame: CGRect(x: selfWidth/8 - 100 , y: 530, width: 200, height: 100))
            sensitiveLbl.text = gscArr["6"]
            sensitiveLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
            sensitiveLbl.textAlignment = .center
            sensitiveLbl.numberOfLines = 0
            sensitiveLbl.adjustsFontSizeToFitWidth = true
            sensitiveLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
            mSunCareSelectView2.addSubview(sensitiveLbl) 
            
            //Children Btn
            let childrenBtnImg = UIImage.init(named: "children")
            let childrenBtn = UIButton.init(frame: CGRect(x: selfWidth/4, y: 0, width: selfWidth/4, height: selfHeight - 74))
            childrenBtn.addTarget(self, action: #selector(GscTopViewController.onTapChildrenBtn), for: .touchUpInside)
            childrenBtn.setBackgroundImage(childrenBtnImg, for: .normal)
            mSunCareSelectView2.addSubview(childrenBtn)  
            
            let childrenLbl = UILabel.init(frame: CGRect(x: selfWidth/8 * 3 - 100 , y: 530, width: 200, height: 100))
            childrenLbl.text = gscArr["7"]
            childrenLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
            childrenLbl.textAlignment = .center
            childrenLbl.numberOfLines = 0
            childrenLbl.adjustsFontSizeToFitWidth = true
            childrenLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
            mSunCareSelectView2.addSubview(childrenLbl) 
            
            //Urban,Daily Btn
            let urbanBtnImg = UIImage.init(named: "urban")
            let urbanBtn = UIButton.init(frame: CGRect(x: selfWidth/4 * 2 , y: 0, width: selfWidth/4, height: selfHeight - 74))
            urbanBtn.addTarget(self, action: #selector(GscTopViewController.onTapUrbanBtn), for: .touchUpInside)
            urbanBtn.setBackgroundImage(urbanBtnImg, for: .normal)
            mSunCareSelectView2.addSubview(urbanBtn)  
            
            let urbanLbl = UILabel.init(frame: CGRect(x: selfWidth/8 * 5 - 100 , y: 530, width: 200, height: 100))
            urbanLbl.text = gscArr["8"]
            urbanLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
            urbanLbl.textAlignment = .center
            urbanLbl.numberOfLines = 0
            urbanLbl.adjustsFontSizeToFitWidth = true
            urbanLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
            mSunCareSelectView2.addSubview(urbanLbl) 
            
            //Active,Sports Btn
            let activeBtnImg = UIImage.init(named: "active")
            let activeBtn = UIButton.init(frame: CGRect(x: selfWidth/4 * 3, y: 0, width: selfWidth/4, height: selfHeight - 74))
            activeBtn.addTarget(self, action: #selector(GscTopViewController.onTapActiveBtn), for: .touchUpInside)
            activeBtn.setBackgroundImage(activeBtnImg, for: .normal)
            mSunCareSelectView2.addSubview(activeBtn)  
            
            let activeLbl = UILabel.init(frame: CGRect(x: selfWidth/8 * 7 - 100 , y: 530, width: 200, height: 100))
            activeLbl.text = gscArr["9"]
            activeLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
            activeLbl.textAlignment = .center
            activeLbl.numberOfLines = 0
            activeLbl.adjustsFontSizeToFitWidth = true
            activeLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
            mSunCareSelectView2.addSubview(activeLbl) 
            
        
        } else {
            //Sensitive,Children Btn
            let sensitiveBtnImg = UIImage.init(named: "sensitive_children")
            let sensitiveBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: selfWidth/3, height: selfHeight - 74))
            sensitiveBtn.addTarget(self, action: #selector(GscTopViewController.onTapSensitiveBtn), for: .touchUpInside)
            sensitiveBtn.setBackgroundImage(sensitiveBtnImg, for: .normal)
            mSunCareSelectView2.addSubview(sensitiveBtn)
            
            let sensitiveLbl = UILabel.init(frame: CGRect(x: selfWidth/6 - 150 , y: 530, width: 300, height: 100))
            sensitiveLbl.text = gscArr["15"]
            sensitiveLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
            sensitiveLbl.textAlignment = .center
            sensitiveLbl.numberOfLines = 0
            sensitiveLbl.adjustsFontSizeToFitWidth = true
            sensitiveLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
            mSunCareSelectView2.addSubview(sensitiveLbl) 
            
            //Urban,Daily Btn
            let urbanBtnImg = UIImage.init(named: "urban_daily")
            let urbanBtn = UIButton.init(frame: CGRect(x: selfWidth/3 , y: 0, width: selfWidth/3, height: selfHeight - 74))
            urbanBtn.addTarget(self, action: #selector(GscTopViewController.onTapUrbanBtn), for: .touchUpInside)
            urbanBtn.setBackgroundImage(urbanBtnImg, for: .normal)
            mSunCareSelectView2.addSubview(urbanBtn)
            
            let urbanLbl = UILabel.init(frame: CGRect(x: selfWidth/6 * 3 - 150 , y: 530, width: 300, height: 100))
            urbanLbl.text = gscArr["16"]
            urbanLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
            urbanLbl.textAlignment = .center
            urbanLbl.numberOfLines = 0
            urbanLbl.adjustsFontSizeToFitWidth = true
            urbanLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
            mSunCareSelectView2.addSubview(urbanLbl) 
            
            //Active,Sports Btn
            let activeBtnImg = UIImage.init(named: "active_sports")
            let activeBtn = UIButton.init(frame: CGRect(x: selfWidth/3 * 2, y: 0, width: selfWidth/3 , height: selfHeight - 74))
            activeBtn.addTarget(self, action: #selector(GscTopViewController.onTapActiveBtn), for: .touchUpInside)
            activeBtn.setBackgroundImage(activeBtnImg, for: .normal)
            mSunCareSelectView2.addSubview(activeBtn)  
            
            let activeLbl = UILabel.init(frame: CGRect(x: selfWidth/6 * 5 - 150 , y: 530, width: 300, height: 100))
            activeLbl.text = gscArr["17"]
            activeLbl.font = UIFont.init(name: "Optima-Bold", size: 40)
            activeLbl.textAlignment = .center
            activeLbl.numberOfLines = 0
            activeLbl.adjustsFontSizeToFitWidth = true
            activeLbl.textColor = UIColor.init(red: 0.87, green: 0.96, blue: 0.99, alpha: 1.0)
            mSunCareSelectView2.addSubview(activeLbl) 
        }
    }
    
    func onTapSensitiveBtn() {
    
        let nextVc = UIViewController.GetViewControllerFromStoryboard("GscResultViewController", targetClass: GscResultViewController.self) as! GscResultViewController
        nextVc.mSelect1Type = mSelectType
        nextVc.mSelect2Type = "sensitive"
        self.navigationController?.pushViewController(nextVc, animated: false)
        
    }
    
    func onTapChildrenBtn() {
        
        let nextVc = UIViewController.GetViewControllerFromStoryboard("GscResultViewController", targetClass: GscResultViewController.self) as! GscResultViewController
        nextVc.mSelect1Type = mSelectType
        nextVc.mSelect2Type = "child"
        self.navigationController?.pushViewController(nextVc, animated: false)
        
    }
    
    func onTapUrbanBtn() {
        
        let nextVc = UIViewController.GetViewControllerFromStoryboard("GscResultViewController", targetClass: GscResultViewController.self) as! GscResultViewController
        nextVc.mSelect1Type = mSelectType
        nextVc.mSelect2Type = "urban"
        self.navigationController?.pushViewController(nextVc, animated: false)
        
    }
    
    func onTapActiveBtn() {
        
        let nextVc = UIViewController.GetViewControllerFromStoryboard("GscResultViewController", targetClass: GscResultViewController.self) as! GscResultViewController
        nextVc.mSelect1Type = mSelectType
        nextVc.mSelect2Type = "active"
        self.navigationController?.pushViewController(nextVc, animated: false)
        
    }
    
    override func backVC() {
        mGscHeaderView.mBtnFind.isHidden = true
        mGscHeaderView.mBtnBack.isHidden = true
        
        mSelectType = ""
        self.mSunCareSelectView1.isHidden = false
        self.mSunCareSelectView2.isHidden = true
    }
}

