//
//  LineDetailViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/07.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LineDetailViewController: UIViewController, NavigationControllerAnnotation, GscNavigationControllerAnnotation, UIScrollViewDelegate {

    private let mScreen = ScreenData(screenId: Const.screenIdLineDetail)

    weak var delegate: NavigationControllerDelegate?
    weak var gscDelegate: GscNavigationControllerDelegate?
    
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    
    var fromGscVc: Bool = false
    
    @IBOutlet weak private var mImgVLine: UIImageView!
    @IBOutlet weak private var mLblLineName: UILabel!
    @IBOutlet weak private var mLblSubTitle: UILabel!
    @IBOutlet weak private var mLblFeature: UILabel!
    @IBOutlet weak private var mBtnMovie: BaseButton!
    @IBOutlet weak private var mScrollVPinch: UIScrollView!
    @IBOutlet weak private var mVMain: UIView!
    var backgroundImage: UIImage!

    var image: UIImage? {
        didSet {
            mImgVLine.image = self.image
        }
    }
    var lineName: String? {
        didSet {
            mLblLineName.text = self.lineName
        }
    }
    var subTitle: String? {
        didSet {
            mLblSubTitle.text = self.subTitle
        }
    }
    var feature: String? {
        didSet {
            mLblFeature.text = self.feature
        }
    }
    var showMovie: Bool = false {
        didSet {
            mBtnMovie.isEnabled = self.showMovie
        }
    }
    var lineId: Int! {
        didSet {
            self.line = LineDetailData(lineId: self.lineId)
        }
    }

    var beautySecondId: Int!
    var line: LineDetailData!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if line != nil {
            self.image = FileTable.getImage(self.line.image)
            self.lineName = self.line.lineName
            self.subTitle = self.line.subTitle
            self.feature = self.line.feature
            self.showMovie = Bool(line.movie as NSNumber)

            if LanguageConfigure.isMyanmar {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.minimumLineHeight = Const.lineHeightMyanmar
                paragraphStyle.maximumLineHeight = Const.lineHeightMyanmar
                
                let featureText = NSMutableAttributedString(string: self.line.feature)
                featureText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, featureText.length))
                mLblFeature.attributedText = featureText
            }
        }
        mScrollVPinch.delegate = self
        print("lineid==="+String(lineId))
        if lineId == 39 {
            // 背景設定
            var image = backgroundImage
            image?.draw(in: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height + 50))
            image = UIGraphicsGetImageFromCurrentImageContext()!
            self.mVMain.backgroundColor = UIColor(patternImage: image!)
        }
    }

    @IBAction func onTapEnter(_ sender: AnyObject) {
        let lineStepVc = UIViewController.GetViewControllerFromStoryboard("LineStepViewController", targetClass: LineStepViewController.self) as! LineStepViewController
        lineStepVc.line = self.line
        lineStepVc.beautySecondId = self.beautySecondId

        if fromGscVc {
            lineStepVc.fromGscVc = true
            gscDelegate?.nextVc(lineStepVc)
        } else {
            delegate?.nextVc(lineStepVc)
        }
    }

    @IBAction func onTapPlay(_ sender: AnyObject) {
        let avPlayer: AVPlayer = AVPlayer(url: FileTable.getPath(line.movie))
        let avPlayerVc: AVPlayerViewController = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        self.present(avPlayerVc, animated: true, completion: nil)
        avPlayer.play()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }
}
