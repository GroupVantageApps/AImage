//
//  LuxuryProductViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
// sharedBeauty(白)から遷移する用のLX商品一覧画面

import Foundation
import AVFoundation
import AVKit
class LXProductViewController: UIViewController, NavigationControllerAnnotation, LXProductBLSViewDelegate, MoviePlayerViewDelegate, UIScrollViewDelegate{
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

    @IBOutlet weak var mBABtn: UIButton!

    private static let outAppInfos = [Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    override
    func viewDidLoad() {
        super.viewDidLoad()
        self.mBABtn.setBackgroundImage(FileTable.getLXFileImage("lx_search.png"), for: .normal)

        mScrollV.delegate = self
        print("LuxuryProductViewController")
        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
        
        let lxArr = LanguageConfigure.lxcsv
        tmpProducts = []
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
                let stepLblString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr[String(stepCsvId)]!, attributes: [NSFontAttributeName: font!])
                stepLblString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr[String(stepCsvId)]?.count)!))
                stepLbl.attributedText = stepLblString
            }
                products = ProductListData(productIds: step.product).products
                for (index, product) in products.enumerated() {
                    tmpProducts.append(product)
                    let productLbl = baseV.viewWithTag(index + 40) as! UILabel
                    productLbl.text = product.productName
                    let lineHeight: CGFloat = 20.0
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.minimumLineHeight = lineHeight
                    paragraphStyle.maximumLineHeight = lineHeight
                    let attributedText = NSMutableAttributedString(string: product.productName)
                    attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle,
                                                 range: NSMakeRange(0, attributedText.length))
                    productLbl.attributedText = attributedText
                    productLbl.textAlignment = .center

                    let image = baseV.viewWithTag(index + 30) as! UIImageView
                    image.image =  FileTable.getImage(product.image)
                    
                    let btn = baseV.viewWithTag(index + 80) as! BaseButton
                    btn.isSelected = Bool(product.recommend as NSNumber)
                    btn.addTarget(self, action: #selector(LXProductViewController.onTapRecommend(_:)), for: UIControlEvents.touchUpInside)
                    if i == 1 { btn.tag = btn.tag + 6 }
                    if i == 2 { btn.tag = btn.tag + 11 }
                    
                    let button = baseV.viewWithTag(index + 50) as! UIButton
                    button.tag = product.productId
                    button.addTarget(self, action: #selector(LXProductViewController.tappedProduct(_:)), for: UIControlEvents.touchUpInside)
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
                            label.text = lxArr["80"]
                        }
                        
                        if index == 3 {
                            let label = baseV.viewWithTag(index + 70) as! UILabel
                            label.text = product.beautyName
                        }
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
        let nextVc = UIViewController.GetViewControllerFromStoryboard("LXProductDetailViewController", targetClass: LXProductDetailViewController.self) as! LXProductDetailViewController
        nextVc.productId = sender.tag
        self.delegate?.nextVc(nextVc)
    }
    
    @IBAction func tappedBABtn(_ sender: Any) {
        let skingraph: LXProductionBAView = UINib(nibName: "LXProductionBAView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductionBAView
        skingraph.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
        skingraph.setUI()
        skingraph.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(skingraph)
    }
    @IBAction func onTapBLS(_ sender: Any) {
        let blsView: LXProductBLSView = UINib(nibName: "LXProductBLSView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductBLSView
        blsView.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
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
        blsView.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
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
    func endMovie() {
        bgAudioPlayer.play()
    }
    func onTapRecommend(_ sender: BaseButton) {
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
