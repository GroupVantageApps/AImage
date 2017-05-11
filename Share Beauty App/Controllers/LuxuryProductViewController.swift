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
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        print("LuxuryProductViewController")
        LogManager.tapItem(screenCode: mScreen.code, itemId: "")

        let line = LineDetailData.init(lineId: 1)
        mUpperSteps = line.step
        mLowerSteps = mUpperSteps.flatMap {$0.lineStep}

        for (i, step) in mLowerSteps.enumerated() {
                let baseV = self.view.viewWithTag(i + 10)! as UIView
                let stepLbl = baseV.viewWithTag(i + 60) as! UILabel
                stepLbl.text = step.stepName
                products = ProductListData(productIds: step.product).products
                for (index, product) in products.enumerated() {
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

                    let button = baseV.viewWithTag(index + 50) as! UIButton
                    button.tag = product.productId
                    button.addTarget(self, action: #selector(LuxuryProductViewController.tappedProduct(_:)), for: UIControlEvents.touchUpInside)
                    let beautyLbl: UILabel

                    if (index > 2 && i == 0) || (index > 0 && i == 1) {
                        beautyLbl = baseV.viewWithTag(index + 20 - 1) as! UILabel
                    } else {
                        beautyLbl = baseV.viewWithTag(index + 20) as! UILabel
                    }
                    print(!(index == 2 && i == 0))
                    if !(index > 1 && i == 0) && !((index == 0 || index == 3 ) && i == 1) && !(index == 0 && i == 2) {
                        beautyLbl.text = product.beautyName
                        print("\(product.beautyName)")
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
        let blsView: LXProductGraphView = UINib(nibName: "LXProductGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductGraphView
        blsView.setUI()
        blsView.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(blsView)

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
}
