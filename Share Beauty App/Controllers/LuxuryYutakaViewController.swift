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
        
        print(LanguageConfigure.lxyutaka)
        let lxTreatMentArr = LanguageConfigure.lxyutaka
        mScrollV.delegate = self
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            print("OutAppBtn Hidden Country")
            mHeaderView.setOutAppEnabled(false)
        }
        
        mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        self.mBGImgV.image = FileTable.getLXFileImage("lx_yutaka.png")
        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
        let lxArr = LanguageConfigure.lxcsv

        let conceptBtn = self.view.viewWithTag(30) as! UIButton
        conceptBtn.setTitle(lxArr["67"], for: .normal)
        if ((lxArr["67"]?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {    
            conceptBtn.setTitle(lxArr["67"], for: .normal)  
        } else {   
            
            let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size: 28)   
            let btnString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr["67"]!, attributes: [NSFontAttributeName: font!])
            btnString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr["67"]?.count)!))
            conceptBtn.titleLabel?.attributedText = btnString
            conceptBtn.setTitle(lxArr["67"], for: .normal)
        }
        let titleLabel  = self.view.viewWithTag(20) as! UILabel
        titleLabel.text = lxArr["66"]
        let treatmentTitleLabel  = self.view.viewWithTag(21) as! UILabel
        treatmentTitleLabel.text = lxArr["68"] 
        let extraTreatmentTitleLabel  = self.view.viewWithTag(22) as! UILabel
        extraTreatmentTitleLabel.text = lxArr["74"] 
    
        for i in 0..<8 {
            let btn = self.view.viewWithTag(10 + i) as! UIButton
            let index = i + 1
            if lxTreatMentArr.contains(index) {
                print(String(format: "id%d",index))
                if let myconstraint = btn.constraints.filter( { c in return c.identifier == String(format: "id%d",index) }).first {
                    myconstraint.constant = 0
                    btn.isHidden = true
                }
                if index == 5 || index == 8 {
                    if let myconstraint = mVContent.constraints.filter( { c in return c.identifier == String(format: "id%d",index + 9) }).first {
                        myconstraint.constant = 0
                    }
                } else {
                    if let myconstraint = mVContent.constraints.filter( { c in return c.identifier == String(format: "id%d",index + 10) }).first {
                        myconstraint.constant = 0
                    }
                }
            }
            
            if i < 5 { 
                let csvId = i + 69
                
                if ((lxArr[String(csvId)]?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {    
                    btn.setTitle(lxArr[String(csvId)], for: .normal)  
                } else {   
                    
                    let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size: 19)   
                    let btnString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr[String(csvId)]!, attributes: [NSFontAttributeName: font!])
                    btnString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr[String(csvId)]?.count)!))
                    btn.titleLabel?.attributedText = btnString
                    btn.setTitle(lxArr[String(csvId)], for: .normal)
                }
            } else {
                let csvId = i + 70
                if ((lxArr[String(csvId)]?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {    
                    btn.setTitle(lxArr[String(csvId)], for: .normal)  
                } else {   
                    
                    let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size: 19)   
                    let btnString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr[String(csvId)]!, attributes: [NSFontAttributeName: font!])
                    btnString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr[String(csvId)]?.count)!))
                    btn.titleLabel?.attributedText = btnString
                    btn.setTitle(lxArr[String(csvId)], for: .normal)
                }
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
        subView.setUI(page: type.rawValue)
        subView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(subView)
        
        switch type {
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
    
    func endMovie(type: Int) {
        bgAudioPlayer.play()
    }
    
    func playSounds(tag: Int) {
        let url = URL.init(string: String(format:"yutakasounds://%d",tag))
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        } else {
            let alertVc = UIAlertController(
                title: "Warning",
                message: "App is not installed",
                preferredStyle: .alert
            )
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVc.addAction(defaultAction)
            self.present(alertVc, animated: true, completion: nil)
        }
    }
}
