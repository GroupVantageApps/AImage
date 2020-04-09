//
//  LuxuryProductViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
class LuxuryProductViewController: LXBaseViewController, LXProductBLSViewDelegate, MoviePlayerViewDelegate, LXNavigationViewDelegte, LXHeaderViewDelegate, UIScrollViewDelegate{
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLXProductDetail)
    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Luxury Products"
    var products: [ProductData]!
    var tmpProducts: [ProductData]!
    private var mUpperSteps = [DBStructStep]()
    private var mLowerSteps = [DBStructLineStep]()
    var isEnterWithNavigationView: Bool = true
    @IBOutlet var mHeaderView: LXHeaderView!
    @IBOutlet var mNavigationView: LXNavigationView!
    
    var bgAudioPlayer: AVAudioPlayer!

    @IBOutlet weak var mGraphBtn: UIButton!
    @IBOutlet weak var mBABtn: UIButton!
    @IBOutlet weak var mBLSBtn: UIButton!

    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL, Const.outAppInfoUvInfo, Const.outAppInfoSoftener, Const.outAppInfoNavigator]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL]

    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        self.mBABtn.setBackgroundImage(FileTable.getLXFileImage("lx_search.png"), for: .normal)
        self.mBLSBtn.setBackgroundImage(FileTable.getLXFileImage("lx_product_bls_btn.png"), for: .normal)
        self.mGraphBtn.setBackgroundImage(FileTable.getLXFileImage("lx_product_graph_btn.png"), for: .normal)
        tmpProducts = []
        mScrollV.delegate = self
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppFoundationInfos.map {$0.title})
        } else {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        }
        print("LuxuryProductViewController")
        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
        
        let lxArr = LanguageConfigure.lxcsv
        
        let line = LineDetailData.init(lineId: 1)
        mUpperSteps = line.step
        mLowerSteps = mUpperSteps.flatMap {$0.lineStep}
        var beautyCsvId = 7
        
        print(mLowerSteps)
        for (i, step) in mLowerSteps.enumerated() {
                let baseV = self.view.viewWithTag(i + 10)! as UIView
                let stepLbl = baseV.viewWithTag(i + 60) as! UILabel
                let stepCsvId = i + 4
            
            
            
            if ((lxArr[String(stepCsvId)]?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {
                stepLbl.text = lxArr[String(stepCsvId)]
            } else {
                let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size: 20)   
                let stepLblString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr[String(stepCsvId)]!, attributes: [NSAttributedString.Key.font: font!])
                stepLblString.setAttributes([NSAttributedString.Key.font: font!,NSAttributedString.Key.baselineOffset: -1], range: NSRange(location:0,length: (lxArr[String(stepCsvId)]?.count)!))
                stepLbl.attributedText = stepLblString
            }
                products = ProductListData(productIds: step.product).products
                
                for (index, product) in products.enumerated() {
                    tmpProducts.append(product)
                    if product.defaultDisplay == 1 {
                    print("\(product.productId):\(product.defaultDisplay)")
                    let productLbl = baseV.viewWithTag(index + 40) as! UILabel
                    productLbl.text = product.productName
                    let lineHeight: CGFloat = 20.0
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.minimumLineHeight = lineHeight
                    paragraphStyle.maximumLineHeight = lineHeight
                    let attributedText = NSMutableAttributedString(string: product.productName)
                        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle,
                                                 range: NSMakeRange(0, attributedText.length))
                    productLbl.attributedText = attributedText
                    productLbl.textAlignment = .center

                    let image = baseV.viewWithTag(index + 30) as! UIImageView
                    image.image =  FileTable.getImage(product.image)

                    let btn = baseV.viewWithTag(index + 80) as! BaseButton
                        btn.isSelected = Bool(truncating: product.recommend as NSNumber)
                        btn.addTarget(self, action: #selector(LuxuryProductViewController.onTapRecommend(_:)), for: UIControl.Event.touchUpInside)
                    if i == 1 { btn.tag = btn.tag + 6 }
                    if i == 2 { btn.tag = btn.tag + 11 }
                    
                    let button = baseV.viewWithTag(index + 50) as! UIButton
                    button.tag = product.productId
                        button.addTarget(self, action: #selector(LuxuryProductViewController.tappedProduct(_:)), for: UIControl.Event.touchUpInside)
                    let beautyLbl: UILabel

                    if (index > 2 && i == 0) || (index > 0 && i == 1) {
                        beautyLbl = baseV.viewWithTag(index + 20 - 1) as! UILabel
                    } else {
                        beautyLbl = baseV.viewWithTag(index + 20) as! UILabel
                    }
                    if (index > 1 && i == 0) || ( index == 3  && i == 1) || (index == 0 && i == 2) {
                        if !(index == 3 && i == 0) {
                        print("\(index) \(i)")
                        beautyLbl.text = lxArr[String(beautyCsvId)]
                        print("\(beautyCsvId):\(lxArr[String(beautyCsvId)])")
                        beautyCsvId = beautyCsvId + 1
                            if beautyCsvId == 8 { beautyCsvId = beautyCsvId + 1}
                        }
                        
                    } else {      
                        beautyLbl.text = product.beautyName
                        print("\(product.beautyName)")
                    }
                    
                    if i == 0  {
                        if index == 2 {
                            let label = baseV.viewWithTag(index + 70) as! UILabel
                            label.text = lxArr["8"]
                        }
                        
                        if index == 3 {
                            let label = baseV.viewWithTag(index + 70) as! UILabel
                            label.text = product.beautyName
                        }
                    }
                    } else {
                        
                        let productLbl = baseV.viewWithTag(index + 40) as! UILabel
                        productLbl.isHidden = true
                        
                        let image = baseV.viewWithTag(index + 30) as! UIImageView
                        image.isHidden = true
                        
                        let btn = baseV.viewWithTag(index + 80) as! BaseButton
                        btn.isHidden = true
                        
                        let button = baseV.viewWithTag(index + 50) as! UIButton
                        button.isHidden = true
                        
                        if i == 0  {
                            if index == 2 {
                                let label = baseV.viewWithTag(index + 70) as! UILabel
                                label.isHidden = true
                            }
                            
                            if index == 3 {
                                let label = baseV.viewWithTag(index + 70) as! UILabel
                                label.isHidden = true
                            }
                        }
                        let beautyLbl: UILabel
                        
                        if (index > 2 && i == 0) || (index > 0 && i == 1) {
                            beautyLbl = baseV.viewWithTag(index + 20 - 1) as! UILabel
                        } else {
                            beautyLbl = baseV.viewWithTag(index + 20) as! UILabel
                        }

                        if (index > 1 && i == 0) || ( index == 3  && i == 1) || (index == 0 && i == 2) {
                            if !(index == 3 && i == 0) {
                                print("\(index) \(i)")
                                beautyLbl.text = lxArr[String(beautyCsvId)]
                                print("\(beautyCsvId):\(lxArr[String(beautyCsvId)])")
                                beautyCsvId = beautyCsvId + 1
                                if beautyCsvId == 8 { beautyCsvId = beautyCsvId + 1}
                            }
                            
                        } else {      
                            beautyLbl.text = product.beautyName
                            beautyLbl.isHidden = true
                            print("\(product.beautyName)")
                        }
                        
                        
//                        if (index > 2 && i == 0) || (index > 0 && i == 1) {
//                            let beautyLbl = baseV.viewWithTag(index + 20 - 1) as! UILabel
//                            beautyLbl.isHidden = true
//                        } else {
//                            let beautyLbl = baseV.viewWithTag(index + 20) as! UILabel
//                            beautyLbl.isHidden = true
//                        }
                    }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("LuxuryProductViewController.viewWillAppear")
        self.navigationController?.isNavigationBarHidden = true
         if (bgAudioPlayer != nil){ bgAudioPlayer.play() }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("LuxuryProductViewController.viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("LuxuryProductViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("LuxuryProductViewController.viewDidDisappear")
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }

    @IBAction func tappedProduct(_ sender: AnyObject) {
        print("tappedProduct:\(sender.tag)")
        let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryProductDetailViewController", targetClass: LuxuryProductDetailViewController.self) as! LuxuryProductDetailViewController
        toVc.productId = sender.tag
        toVc.bgAudioPlayer = self.bgAudioPlayer
        self.navigationController?.pushViewController(toVc, animated: false)
    }
    
    @IBAction func tappedBABtn(_ sender: Any) {
        let skingraph: LXProductionBAView = UINib(nibName: "LXProductionBAView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductionBAView
        skingraph.setUI()
        skingraph.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(skingraph)
    }
    @IBAction func onTapBLS(_ sender: Any) {
        let blsView: LXProductBLSView = UINib(nibName: "LXProductBLSView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductBLSView
        blsView.setUI()
        blsView.delegate = self
        blsView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(blsView)
    }
    @IBAction func onTapGraph(_ sender: Any) {
        if let gView = self.view.viewWithTag(150) {
            gView.removeFromSuperview()
        }
        let blsView: LXProductGraphView = UINib(nibName: "LXProductGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductGraphView
        blsView.setUI()
        blsView.tag = 150
        blsView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(blsView)
        blsView.startAnimation(tag: 100)

    }
    func movieAct(){
        
        bgAudioPlayer.pause()
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/17AW_LX.mp4"))
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
    @objc func endMovie(type: Int) {
        bgAudioPlayer.play()
    }

    @objc func onTapRecommend(_ sender: BaseButton) {
        sender.isSelected = !sender.isSelected
        let product = tmpProducts[sender.tag - 80]
        
        if sender.isSelected {
            if RecommendTable.check(product.productId) == 0 {
                var value: DBInsertValueRecommend = DBInsertValueRecommend()
                value.product = product.productId
                value.line = product.lineId
                value.beautySecond = product.beautySecondId
                RecommendTable.insert(value)
            }
            LogManager.tapProductReccomend(recommedFlg: 1, productId: product.productId, screenCode: self.mScreen.code)
        } else {
            RecommendTable.delete(product.productId)
            LogManager.tapProductReccomend(recommedFlg: -1, productId: product.productId, screenCode: self.mScreen.code)
        }
    }
}
