//
//  ProductDetailViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SwiftyJSON

class ProductDetailViewController: UIViewController, NavigationControllerAnnotation, GscNavigationControllerAnnotation,CategoryButtonDelegate, UtmFeaturesViewDelegate, TroubleViewDelegate, TroubleSelectViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak private var mImgVProduct: UIImageView!
    @IBOutlet weak private var mImgVFirstDailyCare: UIImageView!
    @IBOutlet weak private var mImgVSecondDailyCare: UIImageView!

    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mVBaseIbukiBtn: UIView!
    @IBOutlet weak private var mVBaseFeaturesView: UIView!
    @IBOutlet weak private var mRelationScrollV: UIScrollView!
    @IBOutlet weak var mRelationPearentView: UIView!
    @IBOutlet weak private var mVScrollContent: UIView!
    @IBOutlet weak private var mVSkinConcern: ProductDetailSkinConcernView!
    @IBOutlet weak private var mTroubleSelectView: TroubleSelectView!
    @IBOutlet weak private var mColorballCollectionView: ColorballCollectionView!
    @IBOutlet weak private var mVRelationProductBase: UIView!
    @IBOutlet weak private var mVCategoryImage: UIView!
    @IBOutlet weak private var mVCategoryImageBase: UIView!
    @IBOutlet weak private var mTroubleView: TroubleView!
    @IBOutlet weak private var mVColorBall: UIView!

//    @IBOutlet weak var mVHowToUse: UIView!
    @IBOutlet weak private var mVHowToUse: UIView!
    
    @IBOutlet weak private var mCategoryButtonFeatures: CategoryButton!
    @IBOutlet weak private var mCategoryButtonTechnologies: CategoryButton!
    @IBOutlet weak private var mCategoryButtonHowToUse: CategoryButton!
    @IBOutlet weak private var mCategoryButtonEfficacy: CategoryButton!
    @IBOutlet weak private var mCategoryButtonDefend: CategoryButton!
    @IBOutlet weak private var mBtnMovie: BaseButton!
    @IBOutlet weak private var mBtnBrush: BaseButton!
    @IBOutlet weak private var mBtnRecommend: BaseButton!

    @IBOutlet weak private var mLblBeautyName: UILabel!
    @IBOutlet weak private var mLblLineName: UILabel!
    @IBOutlet weak private var mLblProductName: UILabel!
    @IBOutlet weak private var mLblFeature: UILabel!
    @IBOutlet weak private var mLblHowToUse: UILabel!
    @IBOutlet weak private var mLblUnit: UILabel!
    @IBOutlet weak private var mLblLikeIt: UILabel!

    @IBOutlet weak private var mItemFeature: UILabel!
    @IBOutlet weak private var mItemDailyCare: UILabel!
    @IBOutlet weak private var mItemHowToUse: UILabel!
    @IBOutlet weak private var mItemSkinConcern: UILabel!
    @IBOutlet weak private var mItemColorVariation: UILabel!
    @IBOutlet weak private var mConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintRight: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintColorballHeight: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintColorballBottom: NSLayoutConstraint!

    @IBOutlet weak var productNamesView: UIView!
    @IBOutlet weak var productDetailFeaturesView: UIView!

    @IBOutlet weak var mConstraintTop: NSLayoutConstraint!
    
    @IBOutlet weak private var mImageBackgroundDot: UIImageView!        //17SS移植用 水玉背景画像

    @IBOutlet weak private var mTransitionView: ProductDetailTransitionView!

    @IBOutlet weak private var mScrollVPinch: UIScrollView!
    @IBOutlet weak private var mVMain: UIView!
    @IBOutlet weak private var mImgVBackImage: UIImageView!

    private let mScreen = ScreenData(screenId: Const.screenIdProductDetail)

    weak var delegate: NavigationControllerDelegate?
    weak var gscDelegate: GscNavigationControllerDelegate?
    
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    
    var fromGscVc: Bool = false
    
    var productId: Int!
    var isHowToUseView: Bool = false
    var indexHowToUse: Int = 0
    var showEfficacy: Bool = false
    var mIsUtm: Bool = false
    var mIsNewUtm: Bool = false
    var mIsUtmEye: Bool = false
    var mIsIbuki: Bool = false
    var mIsWhiteLucentOnMakeUp: Bool = false
    var mIsWhiteLucentWhiteLucentAllDay: Bool = false
    var mIsSunCareBBSports: Bool = false
    var mIsSunCareFragrance: Bool = false
    var mIsSunCarePerfectUv: Bool = false
    var mIsMakeUp: Bool = false
    var mIsWaso: Bool = false
    var mUtmTechV: UtmTechnologiesView? = nil
    var mIsEE: Bool = false
    var mIsSDP: Bool = false
    var mIsEEE: Bool = false
    var mIsUtmMask: Bool = false
    var mIsLatestMoisturizer: Bool = false

    var product: ProductDetailData!
    var relationProducts: [ProductData] = []
    private var mItems: [String: String]!
    private var mItemsSideMenu: [String: String]!
    private var mItemsCommon: [String: String]!

    private var mBtnCurrentSelect: CategoryButton?
    private var mVCurrentSelect: UIView?

    private var mUtmFeaturesView: UtmFeaturesView!
    private var mIbukiFeaturesView: IbukiFeaturesView!
    private var mWhiteLucentAllDayFeaturesView: WhiteLucentFeaturesView!
    private var mSuncareFeaturesView: SunCareFeaturesView!
    private var mWasoFeatureView: WasoFeatureView!
    private var mMakeupUsageView: MakeupUsageView!
	
	private var movieTelop: TelopData!
	private var currentMovieTelop: TelopData.DataStructTerop? = nil
    
    let techScrollV = UIScrollView()
    let efficacyScrollV = UIScrollView()
    let efficacySDPScrollV = UIScrollView()
    let efficacyEEEScrollV = UIScrollView()
    let technologyEEEScrollV = UIScrollView()
    let efficacyWASOScrollV = UIScrollView()
    let efficacyGSCScrollV = UIScrollView()
    
    // UTM2.0多言語化CSV
    let mUtmArr = LanguageConfigure.utmcsv
    let mEeeArr = LanguageConfigure.sdp_eee_csv
	
	// 特殊な初期表示を行う商品ID辞書
	private enum eTransitionDestinate {
		case howTowUse
	}
	private let initialTransitionDic: [Int: eTransitionDestinate] = [
		513: .howTowUse,
		252: .howTowUse,
		313: .howTowUse,
	]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        product = ProductDetailData(productId: productId)
        self.checkSpecialCase()
        print("product.image:", product.image)

        mCategoryButtonFeatures.delegate = self
        mCategoryButtonTechnologies.delegate = self
        mCategoryButtonHowToUse.delegate = self
        mCategoryButtonEfficacy.delegate = self
        mCategoryButtonDefend.delegate = self
        mTroubleView.delegate = self
        mTroubleSelectView.delegate = self
        
        mBtnCurrentSelect = mCategoryButtonFeatures

        mItems = AppItemTable.getItems(screenId: Const.screenIdProductDetail)
        mItemsSideMenu = AppItemTable.getItems(screenId: Const.screenIdSideMenu)
        mItemsCommon = AppItemTable.getItems(screenId: Const.screenIdProductDetailCommon)

        mItemFeature.text = mItems["08"]
        mItemHowToUse.text = mItems["09"]
        mItemDailyCare.text = mItems["11"]
        mCategoryButtonFeatures.title = mItemsCommon["01"]
        mCategoryButtonHowToUse.title = mItemsCommon["02"]
        mCategoryButtonEfficacy.title = mItemsCommon["03"]
        mCategoryButtonTechnologies.title = mItemsCommon["05"]
		mCategoryButtonDefend.title =  product.makeupLook ? mItemsCommon["06"] : mItemsSideMenu["16"]
        mTransitionView.setLikeItText(text: mItemsSideMenu["09"])

        mItemSkinConcern.text = AppItemTable.getNameByItemId(itemId: 54)
        mItemColorVariation.text = AppItemTable.getNameByItemId(itemId: 87)

        mImgVProduct.image = FileTable.getImage(product.image)
        mImgVBackImage.image = FileTable.getImage(product.backImage)
        
        // 背景
        if productId >= 553 && productId <= 556 || productId == 564{
            mImgVBackImage.image = UIImage(named: "")//FileTable.getImage(product.backImage)
            var image: UIImage = FileTable.getImage(6355)!
            let resize = CGSize(width: self.view.width, height: self.view.height)
            UIGraphicsBeginImageContext(resize)
            image.draw(in: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height))
            image = UIGraphicsGetImageFromCurrentImageContext()!
            self.view.backgroundColor = UIColor(patternImage: image)
            mRelationScrollV.backgroundColor = UIColor.clear
            mRelationPearentView.backgroundColor = UIColor.clear
        }
        
        
        mLblBeautyName.text = product.beautyName
        mLblLineName.text = product.lineName
        mLblProductName.text = product.productName
        mLblFeature.text = product.feature
        mLblHowToUse.text = product.howToUse
        mLblUnit.text = product.spec

        if LanguageConfigure.isMyanmar {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = Const.lineHeightMyanmar
            paragraphStyle.maximumLineHeight = Const.lineHeightMyanmar
            
            let featureText = NSMutableAttributedString(string: product.feature)
            featureText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, featureText.length))
            mLblFeature.attributedText = featureText
            
            let howToUseText = NSMutableAttributedString(string: product.feature)
            howToUseText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, howToUseText.length))
            mLblHowToUse.attributedText = howToUseText
        }

        mCategoryButtonTechnologies.enabled = (product.technologyImage.count != 0)
        mCategoryButtonHowToUse.enabled = (product.usageImage.count != 0)
        mCategoryButtonEfficacy.enabled = (product.effectImage.count != 0)
        
     //   }
        // HowToUseが空の時はViewを非表示
        if product.howToUse == "" {
            mVHowToUse.isHidden = true
//            print(mConstraintTop.secondItem)
        }
        
        if product.usageImage == ProductDetailData(productId: 564).usageImage{
            mVHowToUse.isHidden = false
        }
		
		if product.makeupLook {
			mCategoryButtonDefend.enabled = product.makeupLookImages.count > 0
		} else {
			mCategoryButtonDefend.enabled = mIsUtm
		}
        
        if [588, 593, 594].contains(self.product.productId){
            self.mIsNewUtm = true
            self.mIsUtm = false
        }

        self.setSpecialMenu()
        self.setCategoryButtonDefend()

        if Bool(product.day as NSNumber) {
            mImgVFirstDailyCare.image = UIImage(named: "icon_day")!
        }
        if Bool(product.night as NSNumber) {
            let imgNight = UIImage(named: "icon_night")!
            if mImgVFirstDailyCare.image == nil {
                mImgVFirstDailyCare.image = imgNight
            } else {
                mImgVSecondDailyCare.image = imgNight
            }
        }
        if (mImgVFirstDailyCare.image == nil && mImgVSecondDailyCare.image == nil) {
            mItemDailyCare.text = nil
        }
        mBtnMovie.isEnabled = (product.movie != 0)
        mBtnBrush.isEnabled = Bool(product.brush as NSNumber)

        self.initSpecialView()

        //mVSkinConcern配下に、mTroubleSelectViewがあるので、両方にtroublesを渡す必要はないけど、
        //mTroubleSelectViewからのイベント(プロトコル)を直接ここで受けたいので、
        //現状このうような作りになってます
        self.mVSkinConcern.troubles = product.troubles
        self.mTroubleSelectView.troubles = product.troubles

        print("++++++++++++++++++++++++++++++++++++++++++++++++")
        print(self.product.troubles)
        print(self.product.productId)
        print("++++++++++++++++++++++++++++++++++++++++++++++++")

        mVBaseIbukiBtn.isHidden = !mIsMakeUp

        //#804 スライド5.6の背景の水玉表示
        if self.product.productId == 498 || self.product.productId == 499 || (545 <= self.product.productId && self.product.productId <= 550){
            mImageBackgroundDot.isHidden = false
        } else {
            mImageBackgroundDot.isHidden = true
        }

        self.initTransitionView()

        mScrollVPinch.delegate = self
		
		// 動画テロップデータ読み込み
		self.movieTelop = TelopData(movieId: product.movie)
        
        if isHowToUseView == true {
            mBtnCurrentSelect?.selected = false
            let sender = self.mCategoryButtonHowToUse
            mBtnCurrentSelect = sender
            mBtnCurrentSelect?.selected = true
            
            mVContent.isHidden = true
            mVCurrentSelect?.removeFromSuperview()
            mVCurrentSelect = nil
            
            showInfo(sender!)
        }
        

        if [588, 593, 594].contains(self.product.productId){
            
            self.efficacyScrollV.delegate = self
            self.efficacyScrollV.frame.size = CGSize(width: self.mVContent.frame.width, height: self.mVContent.height)
            self.efficacyScrollV.contentSize = CGSize(width: efficacyScrollV.frame.width, height: (efficacyScrollV.frame.height)*3)
            self.efficacyScrollV.isPagingEnabled = true
            self.efficacyScrollV.bounces = false
            
            self.setEfficacyView()
            
            
            self.techScrollV.delegate = self
            self.techScrollV.frame.size = CGSize(width: self.mVContent.frame.width, height: self.mVContent.height)
            self.techScrollV.contentSize = CGSize(width: techScrollV.frame.width, height: (techScrollV.frame.height)*4)
            self.techScrollV.isPagingEnabled = true
            self.techScrollV.bounces = false

            self.setGeneratingView()
            self.setEnhanceView()
            self.setImucalmView()
            
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeRelationProducts()
        viewDidLayoutSubviewsOnce {
            if self.product.colorballs.count == 0 {
                mVColorBall.removeFromSuperview()
                mConstraintColorballBottom.isActive = true
            } else {
                mColorballCollectionView.cellWidth = (mColorballCollectionView.superview!.width / 5)
                mColorballCollectionView.collorballs = self.product.colorballs
                self.view.layoutIfNeeded()
                mConstraintColorballHeight.constant = mColorballCollectionView.contentSize.height
            }
        }
		
		// waso用画像タップ案内表示
		if self.mIsWaso {
			self.showWasoHukidashiGuideView()
		}

		// 初期特殊遷移
		self.initialTransition()

    }
    
    func setWasoEfficacySCV(){
        self.efficacyWASOScrollV.delegate = self
        self.efficacyWASOScrollV.frame.size = CGSize(width: self.mVContent.frame.width, height: self.mVContent.height)
        self.efficacyWASOScrollV.contentSize = CGSize(width: self.mVContent.frame.width, height: (self.mVContent.height)*2)
        self.efficacyWASOScrollV.isPagingEnabled = true
        self.efficacyWASOScrollV.bounces = false
        self.efficacyWASOScrollV.backgroundColor = UIColor.clear

        if productId == 570 || productId == 571 {
            let nib = UINib(nibName: "WASOPeelFirstEfficacyResultView", bundle: nil)
            let views = nib.instantiate(withOwner: self, options: nil)
            guard let efficacyView1 = views[0] as? WASOPeelFirstEfficacyResultView else { return }
            efficacyView1.frame = CGRect(x: 0, y: 0, width: self.mVContent.frame.width, height: self.mVContent.height)
            efficacyView1.tag = 65
            self.efficacyWASOScrollV.addSubview(efficacyView1)
            
            let title = UILabel()
            title.text = mEeeArr["145"]
            title.textColor = UIColor.black
            title.font = UIFont(name: "Reader-Bold", size: 18)
            title.frame = CGRect(x: 0, y: Int(self.efficacyWASOScrollV.frame.height), width: 500, height: 100)
            title.centerX = self.mVContent.centerX
            title.numberOfLines = 0
            title.textAlignment = .center
            
            let label_35 = UILabel()
            label_35.text = "35%UP"
            label_35.textColor = UIColor.black
            label_35.font = UIFont(name: "Reader-Bold", size: 50)
            label_35.frame = CGRect(x: Int(self.mVContent.centerX + 200), y: 100 + Int(self.efficacyWASOScrollV.frame.height), width: 200, height: 60)
            label_35.numberOfLines = 0
            label_35.textAlignment = .left
            
            let label_35_description = UILabel()
            label_35_description.text = mEeeArr["148"]
            label_35_description.textColor = UIColor.black
            label_35_description.font = UIFont(name: "Reader-Medium", size: 15)
            label_35_description.frame = CGRect(x: Int(self.mVContent.centerX + 200), y: 150 + Int(self.efficacyWASOScrollV.frame.height), width: 200, height: 100)
            label_35_description.numberOfLines = 0
            label_35_description.textAlignment = .left
            
            let image_after = UIImage(named: "waso_after.png")
            let faceImageV_after = UIImageView(image:image_after)
            faceImageV_after.contentMode = .scaleAspectFit
            faceImageV_after.clipsToBounds = true
            faceImageV_after.frame = CGRect(x: 0, y: 70 + Int(self.efficacyWASOScrollV.frame.height), width: 300, height: 300)
            faceImageV_after.centerX = self.mVContent.centerX
            faceImageV_after.backgroundColor = UIColor.clear
            
            
            
            let image = UIImage(named: "waso_before.png")
            let faceImageV = UIImageView(image:image)
            faceImageV.contentMode = .scaleAspectFit
            faceImageV.tag = 30
            faceImageV.clipsToBounds = true
            faceImageV.frame = CGRect(x: 0, y: 70 + Int(self.efficacyWASOScrollV.frame.height), width: 300, height: 300)
            faceImageV.centerX = self.mVContent.centerX
            faceImageV.backgroundColor = UIColor.clear
            
            let beforeBtn = UIButton()
            beforeBtn.isEnabled = false
            beforeBtn.frame = CGRect(x: 0, y: 400 + Int(self.efficacyWASOScrollV.frame.height), width: 145, height: 30)
            beforeBtn.origin.x = self.mVContent.centerX - beforeBtn.frame.width - 10
            beforeBtn.setTitle(mUtmArr["27"], for: .normal) // "Before"
            beforeBtn.isEnabled = false
            beforeBtn.setTitleColor(UIColor.white, for: .normal)
            beforeBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            beforeBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 12)
            beforeBtn.tag = 10
            beforeBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            let afterBtn = UIButton()
            afterBtn.isEnabled = true
            afterBtn.frame = CGRect(x: 0, y: 400 + Int(self.efficacyWASOScrollV.frame.height), width: 145, height: 30)
            afterBtn.origin.x = self.mVContent.centerX + 10
            afterBtn.setTitle(mUtmArr["28"], for: .normal) // "After 4 Weeks"
            afterBtn.isEnabled = true
            afterBtn.setTitleColor(UIColor.white, for: .normal)
            afterBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            
            afterBtn.setTitleColor(UIColor.black, for: .normal)
            afterBtn.backgroundColor = UIColor.white
            afterBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 12)
            afterBtn.tag = 20
            afterBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            
            for j in 0...2{
                let image:UIImage = UIImage(named:"point_01.png")!
                let border = UIImageView(image:image)
                border.contentMode = .scaleToFill
                
                if j == 0{
                    border.frame = CGRect(x: Int(self.mVContent.centerX) - Int(beforeBtn.frame.width) - 20, y: 398 + Int(self.efficacyWASOScrollV.frame.height), width: 1, height: 34)
                }else if j == 1{
                    border.frame = CGRect(x: Int(self.mVContent.centerX), y: 398 + Int(self.efficacyWASOScrollV.frame.height), width: 1, height: 34)
                    
                }else if j == 2{
                    border.frame = CGRect(x: Int(self.mVContent.centerX) + Int(afterBtn.frame.width) + 20, y: 398 + Int(self.efficacyWASOScrollV.frame.height), width: 1, height: 34)
                    
                }
                
                self.efficacyWASOScrollV.addSubview(border)
                
            }
            
            let copy = UILabel()
            copy.textColor = UIColor.gray
            copy.font = UIFont(name: "Reader-Medium", size: 14)
            copy.frame = CGRect(x: 10 , y: self.mVContent.size.height * 2 - 250 , width: 400, height: 100)
            copy.numberOfLines = 0
            copy.textAlignment = .left
            copy.text = mEeeArr["149"]
            
            self.efficacyWASOScrollV.addSubview(copy)
            self.efficacyWASOScrollV.addSubview(title)
            self.efficacyWASOScrollV.addSubview(label_35)
            self.efficacyWASOScrollV.addSubview(label_35_description)
            
            self.efficacyWASOScrollV.addSubview(faceImageV_after)
            self.efficacyWASOScrollV.addSubview(faceImageV)
            self.efficacyWASOScrollV.addSubview(beforeBtn)
            self.efficacyWASOScrollV.addSubview(afterBtn)
            
        }

    }
        
    func setEEESCV(){
        self.efficacyEEEScrollV.delegate = self
        self.efficacyEEEScrollV.frame.size = CGSize(width: self.mVContent.frame.width, height: self.mVContent.height)
        self.efficacyEEEScrollV.contentSize = CGSize(width: self.mVContent.frame.width, height: (self.mVContent.height)*3)
        self.efficacyEEEScrollV.isPagingEnabled = true
        self.efficacyEEEScrollV.bounces = false
        self.efficacyEEEScrollV.backgroundColor = UIColor.clear
        
        for i in 0...1{
            
            let margin =  i == 0 ? -200 : 200
            let marginEffectImage = i == 0 ? -215 : 215
            let marginEffectLabel = i == 0 ? -410 : 410
            let title = UILabel()
            title.textColor = UIColor.black
            title.font = UIFont(name: "Reader-Bold", size: 45)
            title.frame = CGRect(x: 500 * i, y: 50 , width: 400, height: 50)
            title.centerX = self.mVContent.centerX + CGFloat(margin)
            title.textAlignment = .center

            if i == 0{
                title.text =  mEeeArr["101"] 
            }else if i == 1{
                title.text = mEeeArr["102"]
            }
            let imageNum = i + 1
            let image_after = UIImage(named: "eee_item0\(imageNum)_after.png")
            let faceImageV_after = UIImageView(image:image_after)
            faceImageV_after.contentMode = .scaleAspectFit
            faceImageV_after.clipsToBounds = true
            faceImageV_after.frame = CGRect(x: 500 * i, y: 120 , width: 240, height: 230)
            // faceImageV_after.frame = CGRect(x: 500 * i, y: 70 , width: 300, height: 300)
            faceImageV_after.centerX = self.mVContent.centerX + CGFloat(margin)
            faceImageV_after.backgroundColor = UIColor.clear
            
            let image = UIImage(named: "eee_item0\(imageNum)_before.png")
            let faceImageV = UIImageView(image:image)
            faceImageV.contentMode = .scaleAspectFit
            faceImageV.tag = 30 + i//300
            faceImageV.clipsToBounds = true
            faceImageV.frame = CGRect(x: 500 * i, y: 120 , width: 240, height: 230)
            // faceImageV.frame = CGRect(x: 500 * i, y: 70 , width: 300, height: 300)
            faceImageV.centerX = self.mVContent.centerX + CGFloat(margin)
            faceImageV.backgroundColor = UIColor.clear
            
            let effectImage = UIImage(named: "13_yazirushi_0\(imageNum).png")
            let effectImageV = UIImageView(image:effectImage)
            effectImageV.contentMode = .scaleAspectFit
            effectImageV.clipsToBounds = true
            effectImageV.frame = CGRect(x: 500 * i, y: 110 , width: 280, height: 270)
            effectImageV.centerX = self.mVContent.centerX + CGFloat(marginEffectImage)
            effectImageV.backgroundColor = UIColor.clear
            
            let effectLabel = UILabel()
            effectLabel.textColor = UIColor.black
            effectLabel.font = UIFont(name: "Reader-Bold", size: 15)
            effectLabel.frame = CGRect(x: 500 * i, y: 210 , width: 80, height: 70)
            effectLabel.centerX = self.mVContent.centerX + CGFloat(marginEffectLabel)
            effectLabel.textAlignment = .left
            effectLabel.numberOfLines = 0
            effectLabel.text = mEeeArr["100"]

            let beforeBtn = UIButton()
            beforeBtn.isEnabled = false
            beforeBtn.frame = CGRect(x:  500 * i, y: 390, width: 145, height: 30)
            beforeBtn.origin.x = self.mVContent.centerX - beforeBtn.frame.width - 10 + CGFloat(margin)
            beforeBtn.setTitle(mEeeArr["98"], for: .normal) // "Before"
            beforeBtn.isEnabled = false
            beforeBtn.setTitleColor(UIColor.white, for: .normal)
            beforeBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            beforeBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 15)
            beforeBtn.tag = 10 + i//100
            beforeBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            let afterBtn = UIButton()
            afterBtn.isEnabled = true
            afterBtn.frame = CGRect(x:  500 * i, y: 390, width: 145, height: 30)
            afterBtn.origin.x = self.mVContent.centerX + 10 + CGFloat(margin)
            afterBtn.setTitle(mEeeArr["99"], for: .normal) // "After 4 Weeks"
            afterBtn.isEnabled = true
            afterBtn.setTitleColor(UIColor.white, for: .normal)
            afterBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            
            afterBtn.setTitleColor(UIColor.black, for: .normal)
            afterBtn.backgroundColor = UIColor.white
            afterBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 15)
            afterBtn.tag = 20 + i//200
            afterBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            for j in 0...2{
                let image:UIImage = UIImage(named:"point_01.png")!
                let border = UIImageView(image:image)
                border.contentMode = .scaleToFill
                if j == 0{
                    border.frame = CGRect(x: Int(self.mVContent.centerX) - Int(beforeBtn.frame.width) - 20 + margin , y: 388, width: 1, height: 34)
                }else if j == 1{
                    border.frame = CGRect(x: Int(self.mVContent.centerX)  + margin, y: 388, width: 1, height: 34)
                    
                }else if j == 2{
                    border.frame = CGRect(x: Int(self.mVContent.centerX) + Int(afterBtn.frame.width) + 20 + margin, y: 388 , width: 1, height: 34)
                }
                self.efficacyEEEScrollV.addSubview(border)
                
            }
            
            let copy = UILabel()
            copy.textColor = UIColor.gray
            copy.font = UIFont(name: "Reader-Medium", size: 14)
            copy.frame = CGRect(x: 15 , y: self.mVContent.size.height - 170 , width: 360, height: 100)
            copy.numberOfLines = 0
            copy.textAlignment = .left
            copy.text = mEeeArr["103"]
            
            self.efficacyEEEScrollV.addSubview(copy)
            self.efficacyEEEScrollV.addSubview(title)
            self.efficacyEEEScrollV.addSubview(faceImageV_after)
            self.efficacyEEEScrollV.addSubview(faceImageV)
            self.efficacyEEEScrollV.addSubview(beforeBtn)
            self.efficacyEEEScrollV.addSubview(afterBtn)
            self.efficacyEEEScrollV.addSubview(effectImageV)
            self.efficacyEEEScrollV.addSubview(effectLabel)

        }
        
        let nib = UINib(nibName: "EEEFirstEfficacyResultView", bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let efficacyView1 = views[0] as? EEEFirstEfficacyResultView else { return }
        efficacyView1.frame = CGRect(x: 0, y: self.mVContent.height, width: self.mVContent.frame.width, height: self.mVContent.height)
        
        self.efficacyEEEScrollV.addSubview(efficacyView1)
        
        let nib2 = UINib(nibName: "EEESecondEfficacyResultView", bundle: nil)
        let views2 = nib2.instantiate(withOwner: self, options: nil)
        guard let efficacyView2 = views2[0] as? EEESecondEfficacyResultView else { return }
        efficacyView2.frame = CGRect(x: 0, y: self.mVContent.height * 2, width: self.mVContent.frame.width, height: self.mVContent.height)
        
        self.efficacyEEEScrollV.addSubview(efficacyView2)
        
        self.technologyEEEScrollV.delegate = self
        self.technologyEEEScrollV.frame.size = CGSize(width: self.mVContent.frame.width, height: self.mVContent.height)
        self.technologyEEEScrollV.contentSize = CGSize(width: self.mVContent.frame.width, height: (self.mVContent.height)*2)
        self.technologyEEEScrollV.isPagingEnabled = true
        self.technologyEEEScrollV.bounces = false
        self.technologyEEEScrollV.backgroundColor = UIColor.clear
        
        let nib_t1 = UINib(nibName: "EEEFirstTechnologyView", bundle: nil)
        let views_t1 = nib_t1.instantiate(withOwner: self, options: nil)
        guard let technologyView1 = views_t1[0] as? EEEFirstTechnologyView else { return }
        technologyView1.frame = CGRect(x: 0, y: 0, width: self.mVContent.frame.width, height: self.mVContent.height)
        
        self.technologyEEEScrollV.addSubview(technologyView1)
        
        let nib_t2 = UINib(nibName: "EEESecondTechnologyView", bundle: nil)
        let views_t2 = nib_t2.instantiate(withOwner: self, options: nil)
        guard let technologyView2 = views_t2[0] as? EEESecondTechnologyView else { return }
        technologyView2.frame = CGRect(x: 0, y: self.mVContent.height, width: self.mVContent.frame.width, height: self.mVContent.height)
        
        self.technologyEEEScrollV.addSubview(technologyView2)
    }
    
    func setSDPEfficacySCV(){
        self.efficacySDPScrollV.delegate = self
        self.efficacySDPScrollV.frame.size = CGSize(width: self.mVContent.frame.width, height: self.mVContent.height)
        self.efficacySDPScrollV.contentSize = CGSize(width: self.mVContent.frame.width, height: (self.mVContent.height)*2)
        self.efficacySDPScrollV.isPagingEnabled = true
        self.efficacySDPScrollV.bounces = false
        
        for i in 0...1{
            let nib = UINib(nibName: "SDPEfficacyResultView", bundle: nil)
            let views = nib.instantiate(withOwner: self, options: nil)
            guard let efficacyView = views[0] as? SDPEfficacyResultView else { return }
            efficacyView.frame = CGRect(x: 0, y: self.mVContent.height * CGFloat(i), width: self.mVContent.frame.width, height: self.mVContent.height)
            
            var start = 0
            switch productId {
            case 565:
                start = 1
            case 566:
                start = 17
            case 567:
                start = 34
            case 568:
                start = 50
            case 569:
                start = 66
            default:
                break // do nothing
            }
            let index = i == 0 ? start : start + i * 8
            efficacyView.setTexts(start_index: index)
            
            self.efficacySDPScrollV.addSubview(efficacyView)
        }
    }
    
    func setGSCEfficacySCV() {
        self.efficacyGSCScrollV.delegate = self
        self.efficacyGSCScrollV.frame.size = CGSize(width: self.mVContent.frame.width, height: self.mVContent.frame.height)
        self.efficacyGSCScrollV.contentSize = CGSize(width: self.mVContent.frame.width, height: self.mVContent.frame.height)
        self.efficacyGSCScrollV.isPagingEnabled = true
        self.efficacyGSCScrollV.bounces = false
        
        let itemId: Int

        switch productId {
        case 610:
            itemId = 7990
        case 611:
            itemId = 7995
        default:
            print("error: productId is not correct")
            return
        }
        
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont(name: "Reader-Bold", size: 22)
        title.text = AppItemTable.getNameByItemId(itemId: itemId)
        title.frame = CGRect(x: 0, y: 30, width: 700, height: 40)
        title.centerX = self.mVContent.centerX
        title.textAlignment = .center
        self.efficacyGSCScrollV.addSubview(title)
        
        for i in 0...2 {
            let percentLabel = UILabel()
            percentLabel.textColor = UIColor.black
            percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
            percentLabel.textAlignment = .center
            percentLabel.frame = CGRect(x: Int(self.mVContent.centerX) - 230, y: 110 + (130 * i), width: 160, height: 82)
            let perY = Int(percentLabel.frame.origin.y)

            let perTexts: [Int: [String]] = [
                610: ["90%", "97%", "97%"],
                611: ["85%", "90%", "86%"]
            ]
            percentLabel.text = perTexts[productId]?[i]
            
            let description = UILabel()
            description.textColor = UIColor.black
            description.font = UIFont(name: "Reader", size: 20)
            description.numberOfLines = 0
            description.textAlignment = .left
            description.frame = CGRect(x: Int(self.mVContent.centerX) - 50, y: perY - 20, width: 350, height: 100)
            description.text = AppItemTable.getNameByItemId(itemId: itemId + i+1)

            self.efficacyGSCScrollV.addSubview(percentLabel)
            self.efficacyGSCScrollV.addSubview(description)
        }
        
        let text = UILabel()
        text.textColor = UIColor.lightGray
        text.font = UIFont(name: "Reader-Medium", size: 12)
        text.font = text.font.withSize(13)
        text.textAlignment = .center
        text.numberOfLines = 0
        text.frame = CGRect(x: 600, y: 500, width: 400, height: 60)
        text.text = AppItemTable.getNameByItemId(itemId: itemId + 4)
        self.efficacyGSCScrollV.addSubview(text)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if mIsUtm || mIsUtmEye || mIsNewUtm{
            mUtmFeaturesView.showAnimation()
        }
            mConstraintColorballHeight.constant = mColorballCollectionView.contentSize.height
		
		if let wasoFeatureView = self.mWasoFeatureView {
			wasoFeatureView.beginGuideFrameAnimation()
		}
        
        if self.isHowToUseView {
            if let scrollV =  mVCategoryImageBase.superview! as? UIScrollView {
                let offset = CGPoint(x: 0, y: scrollV.size.height * CGFloat(self.indexHowToUse))
                scrollV.setContentOffset(offset, animated: false)
            }
        }
        
        if [588, 593, 594].contains(self.product.productId) && showEfficacy == true{
            mBtnCurrentSelect?.selected = false
            let sender = self.mCategoryButtonEfficacy
            mBtnCurrentSelect = sender
            mBtnCurrentSelect?.selected = true
            
            showInfo(sender!)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        product = ProductDetailData(productId: productId)
        mTransitionView.isLikeItSelected(isSelected: Bool(product!.recommend as NSNumber))
    }
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if let avPlayerVc = object as? AVPlayerViewController {
			// AVPlayerViewControllerのdismiss間際にframeが1度変化する。このタイミングでオブザーバを削除する
			if keyPath == #keyPath(UIViewController.view.frame) {
				avPlayerVc.removeObserver(self, forKeyPath: #keyPath(UIViewController.view.frame))
				if let player = avPlayerVc.player, let observer = self.mAvPlayerObserver {
					player.removeTimeObserver(observer)
					self.mAvPlayerObserver = nil
				}
			}
		}
	}

    // MARK: - PrivateMethod

    private func makeRelationProducts() {
        if mVRelationProductBase.subviews.count != 0 {
            return
        }
        if relationProducts.count == 0 {
            let button: BaseButton = BaseButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = product.productId
            button.addTarget(
                self,
                action: #selector(onTapRelationProduct(_:)),
                for: .touchUpInside)
            let image = FileTable.getImage(product.image)
            button.setImage(image, for: UIControlState())
            mVRelationProductBase.addSubview(button)
        } else {
            for dataStructProduct in relationProducts {
                let button: BaseButton = BaseButton()
                button.translatesAutoresizingMaskIntoConstraints = false
                button.tag = dataStructProduct.productId
                button.addTarget(
                    self,
                    action: #selector(onTapRelationProduct(_:)),
                    for: .touchUpInside)
                let image = FileTable.getImage(dataStructProduct.image)
                button.setImage(image, for: UIControlState())
                mVRelationProductBase.addSubview(button)
            }
        }

        for subView in mVRelationProductBase.subviews {
            let top = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: mVRelationProductBase, attribute: .top, multiplier: 1.0, constant: 0)
            let bottom = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: mVRelationProductBase, attribute: .bottom, multiplier: 1.0, constant: 0)
            let aspect = NSLayoutConstraint(item: subView, attribute: .width, relatedBy: .equal, toItem: subView, attribute: .height, multiplier: 1012.0 / 964.0, constant: 0)
            mVRelationProductBase.addConstraints([top, bottom, aspect])
            if subView === mVRelationProductBase.subviews.first {
                let left = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .equal, toItem: mVRelationProductBase, attribute: .left, multiplier: 1.0, constant: 0)
                mVRelationProductBase.addConstraint(left)
            }
            if subView === mVRelationProductBase.subviews.last {
                let right = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .equal, toItem: mVRelationProductBase, attribute: .right, multiplier: 1.0, constant: 0)
                mVRelationProductBase.addConstraint(right)
            } else {
                let right = NSLayoutConstraint(item: mVRelationProductBase.subviews.after(subView)!, attribute: .left, relatedBy: .equal, toItem: subView, attribute: .right, multiplier: 1.0, constant: 0)
                mVRelationProductBase.addConstraint(right)
            }
        }
        self.view.layoutIfNeeded()
        if mRelationScrollV.width > mVRelationProductBase.width {
            let padding: CGFloat = (mRelationScrollV.width - mVRelationProductBase.width) / 2
            mConstraintLeft.constant = padding
            mConstraintRight.constant = padding
        }
    }

    private func setMakeUpHowToUse(_ imageIds: [Int]) {
        makeCategoryImages(imageIds)

        var contentText: String!
        
        var imageTitleItemIds: [Int] = []
        var imageDescriptItemIds: [Int] = []
        var imageTitleTexts: [String] = []
        var imageDescriptTexts: [String] = []
        
        if productId == 578 {
            contentText = AppItemTable.getNameByItemId(itemId: 7890)!
            imageTitleItemIds = [7898, 7969, 7971, 7973]
            imageDescriptItemIds = [7968, 7970, 7972, 7974]

        } else if productId == 572 {
            contentText = AppItemTable.getNameByItemId(itemId: 7976)!
            imageTitleItemIds = [7977, 7979, 7981, 7983]
            imageDescriptItemIds = [7978, 7980, 7982, 7984]
        } else {
            print("productId is not correct")
            exit(1)
        }
        for i in 0..<4 {
            if let text = AppItemTable.getNameByItemId(itemId: imageTitleItemIds[i]) {
                imageTitleTexts.append(text)
            }
            if let text = AppItemTable.getNameByItemId(itemId: imageDescriptItemIds[i]) {
                imageDescriptTexts.append(text)
            } else {
                imageDescriptTexts.append("")
            }
        }
        
        for i in 0..<imageIds.count {
            let contentLabel = UILabel(frame: CGRect(x: 30, y: CGFloat(30 + 513 * i), width: 575, height: 0))
            //行間
            let attributedText = NSMutableAttributedString(string: contentText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.2
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            contentLabel.attributedText = attributedText

            contentLabel.font = UIFont(name: "Reader", size: 14)
            contentLabel.numberOfLines = 0
            contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            contentLabel.centerX = mVCategoryImageBase.centerX
            contentLabel.sizeToFit()

            let imageTitleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: CGFloat(135 + 513 * i), width: 30, height: 0))
            imageTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            imageTitleLabel.font = UIFont(name: "Reader", size: 13)
            imageTitleLabel.text = imageTitleTexts[i]
            imageTitleLabel.sizeToFit()
            imageTitleLabel.centerX = mVCategoryImageBase.centerX

            let imageDescriptLabel: UILabel = UILabel(frame: CGRect(x: 0, y: CGFloat(375 + 513 * i), width: 0, height: 0))
            imageDescriptLabel.numberOfLines = 0
            imageDescriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            imageDescriptLabel.font = UIFont(name: "Reader", size: 13)
            imageDescriptLabel.text = imageDescriptTexts[i]
            imageDescriptLabel.textAlignment = .center
            imageDescriptLabel.sizeToFit()
            imageDescriptLabel.centerX = mVCategoryImageBase.centerX
            
            mVCategoryImageBase.addSubview(contentLabel)
            mVCategoryImageBase.addSubview(imageTitleLabel)
            mVCategoryImageBase.addSubview(imageDescriptLabel)
        }
    }
    
    private func makeCategoryImages(_ imageIds: [Int]) {
        for subview in mVCategoryImageBase.subviews {
            subview.removeFromSuperview()
        }

        for imageId in imageIds {
            let imgV: UIImageView = UIImageView()
            imgV.translatesAutoresizingMaskIntoConstraints = false
            imgV.contentMode = .scaleAspectFit
            let image = FileTable.getImage(imageId)
            imgV.image = image
            mVCategoryImageBase.addSubview(imgV)
        }

        for subView in mVCategoryImageBase.subviews {
            let left = NSLayoutConstraint(item: subView, attribute: .left, relatedBy: .equal, toItem: mVCategoryImageBase, attribute: .left, multiplier: 1.0, constant: 0)
            let right = NSLayoutConstraint(item: subView, attribute: .right, relatedBy: .equal, toItem: mVCategoryImageBase, attribute: .right, multiplier: 1.0, constant: 0)
            mVCategoryImageBase.addConstraints([left, right])
            if subView === mVCategoryImageBase.subviews.first {
                let top = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: mVCategoryImageBase, attribute: .top, multiplier: 1.0, constant: 0)
                mVCategoryImageBase.addConstraint(top)
            } else {
                let height = NSLayoutConstraint(item: mVCategoryImageBase.subviews.first!, attribute: .height, relatedBy: .equal, toItem: subView, attribute: .height, multiplier: 1.0, constant: 0)
                mVCategoryImageBase.addConstraint(height)
            }
            if subView === mVCategoryImageBase.subviews.last {
                let bottom = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: mVCategoryImageBase, attribute: .bottom, multiplier: 1.0, constant: 0)
                mVCategoryImageBase.addConstraint(bottom)
            } else {
                let bottom = NSLayoutConstraint(item: mVCategoryImageBase.subviews.after(subView)!, attribute: .top, relatedBy: .equal, toItem: subView, attribute: .bottom, multiplier: 1.0, constant: 0)
                mVCategoryImageBase.addConstraint(bottom)
            }
        }
        let height = NSLayoutConstraint(item: mVCategoryImageBase, attribute: .height, relatedBy: .equal, toItem: mVCategoryImageBase.superview!, attribute: .height, multiplier: CGFloat(imageIds.count), constant: 0)
        if let beforeHeight = NSLayoutConstraint.findEqualRelation(mVCategoryImageBase.superview!.constraints, constraint: height) {
            mVCategoryImageBase.superview!.removeConstraint(beforeHeight)
        }
        mVCategoryImageBase.superview!.addConstraint(height)
        self.view.layoutIfNeeded()
    }

    private func initTransitionView() {
        
        let item: [String: String]! = AppItemTable.getItems(screenId: Const.screenIdTop)
        
        var datas = [ProductDetailTransitionData]()
        
        datas.append(ProductDetailTransitionData(title: self.product.lineName, selector: #selector(self.onTapLineDetail(_:))))
        //　LifeStyleBuautyの表示がされない
        if Utility.getLifeStyleScreenIds(productId: self.productId) != nil {
            datas.append(ProductDetailTransitionData(title: item["02"]!, selector: #selector(self.onTapLifeStyleBeauty(_:))))
        }
        if Utility.isIconicProduct(productId: self.productId) {
            datas.append(ProductDetailTransitionData(title: item["04"]!, selector: #selector(self.onTapIconicBeauty(_:))))
        }
        if Utility.isOnTrendProduct(productId: self.productId) {
            datas.append(ProductDetailTransitionData(title: item["03"]!, selector: #selector(self.onTapOnTrendBeauty(_:))))
        }
		
        mTransitionView.setProductDetailTransitionData(datas, target: self)
        mTransitionView.cellHeight = 34
        mTransitionView.setLikeItSelector(#selector(self.onTapRecommend(_:)), target: self)
    }

    private func initSpecialView() {
        if mIsUtm || mIsUtmEye || mIsNewUtm {
            mUtmFeaturesView = UtmFeaturesView()
            mUtmFeaturesView.delegate = self
            mUtmFeaturesView.bottomPadding = 30
            var viewHeight = 300
            if [588, 593, 594].contains(self.product.productId) {
                mUtmFeaturesView.isNewUtm = true
                viewHeight = 240
            }
            
            self.setSpecialCaseConstraints(targetView: mUtmFeaturesView, viewHeight: CGFloat(viewHeight))
        } else if mIsIbuki {
            mIbukiFeaturesView = IbukiFeaturesView()
            mIbukiFeaturesView.delegate = self
            mIbukiFeaturesView.bottomPadding = 30

            self.setSpecialCaseConstraints(targetView: mIbukiFeaturesView, viewHeight: 211)
        } else if mIsWhiteLucentWhiteLucentAllDay {
            mWhiteLucentAllDayFeaturesView = WhiteLucentFeaturesView()
            mWhiteLucentAllDayFeaturesView.bottomPadding = 30

            self.setSpecialCaseConstraints(targetView: mWhiteLucentAllDayFeaturesView, viewHeight: 330)
        } else if mIsSunCareBBSports || mIsSunCarePerfectUv || mIsSunCareFragrance {
            mSuncareFeaturesView = SunCareFeaturesView()
            mSuncareFeaturesView.isGSC = mIsSunCareBBSports
            mSuncareFeaturesView.isSCP = mIsSunCarePerfectUv
            mSuncareFeaturesView.isGSCFragrance = mIsSunCareFragrance
            mSuncareFeaturesView.bottomPadding = 30

            self.setSpecialCaseConstraints(targetView: mSuncareFeaturesView, viewHeight: 300)
        } else if mIsWaso {
            mWasoFeatureView = WasoFeatureView()
            self.setWasoData()
            self.setSpecialCaseConstraints(targetView: mWasoFeatureView, viewHeight: 260)
            mWasoFeatureView.startAnimation()
            if productId == 570 || productId == 571 {
                mWasoFeatureView.hukidashi_tap_enable = false
            }
        }
    }

    private func setWasoData() {
        var itemId: Int?
        var image: UIImage?
        if productId == 504 {
            itemId = 7894
        } else if productId == 505 {
            itemId = 7894
        } else if productId == 506 {
            image = #imageLiteral(resourceName: "moisturizer oil free")
            itemId = 7896
        } else if productId == 507 {
            image =  #imageLiteral(resourceName: "day moisturizer")
            itemId = 7894
        } else if productId == 508 {
            image = #imageLiteral(resourceName: "color smart")
            itemId = 7896
        } else if productId == 509 {
            //TODO: 仮（修正平井20170307）
            image = #imageLiteral(resourceName: "hydrating cream")
            itemId = 7894
        } else if productId == 510 {
            image = #imageLiteral(resourceName: "polisher")
            itemId = 7893
        } else if productId == 511 {
            let apng = AppItemTable.getJsonByItemId(itemId: 7860)?.dictionary?["image"]?[0].dictionary?["main_image"]?[0].int
            mWasoFeatureView.apng = FileTable.getAImage(apng)
            image = #imageLiteral(resourceName: "Gentle Cleanser")
            itemId = 7891
        } else if productId == 512 {
            image = #imageLiteral(resourceName: "fresh jelly")
            itemId = 7892
        } else if productId == 570 {
            image = #imageLiteral(resourceName: "red_shiso")
            itemId = 7948
        } else if productId == 571 {
            image = #imageLiteral(resourceName: "yuzu")
            itemId = 7949
        } else if productId == 612 {
            image = #imageLiteral(resourceName: "WASO_19SS_KV_ING_MOCHI_SQUARE")
            itemId = 8020
        } else if productId == 613 {
            image = #imageLiteral(resourceName: "WASO_19SS_kanten")
            itemId = 8018
        }
        if itemId != nil {
            mWasoFeatureView.hukidashiText = AppItemTable.getJsonByItemId(itemId: itemId!)?.dictionary?["name"]?.string
        }
        mWasoFeatureView.image = image
    }

    //画像なし悩みId
    private func checkSpecialCase() {
        mIsUtm = Const.productIdUtm.contains(self.productId)
        mIsUtmEye = Const.productIdUtmEye == self.productId
        mIsIbuki = Const.productIdIbuki == self.productId
        mIsWhiteLucentOnMakeUp = Const.productIdWhiteLucentOnMakeUp == self.productId
        mIsWhiteLucentWhiteLucentAllDay = Const.productIdWhiteLucentAllDay == self.productId
        mIsSunCareBBSports = Const.productIdSunCareBBSports == self.productId
        mIsSunCareFragrance = Const.productIdSunCareFragrance.contains(self.productId)
        mIsSunCarePerfectUv = Const.productIdSunCarePerfectUv.contains(self.productId)
        mIsMakeUp = Const.productIdMakeUp == self.productId
        mIsWaso = Const.lineIdWASO == self.product.lineId
        mIsLatestMoisturizer = Const.latestMoisturizerList.contains(self.productId)
    }

    private func setSpecialMenu() {
        if mIsUtm {
            mCategoryButtonTechnologies.enabled = true
            mCategoryButtonEfficacy.enabled = true
            mCategoryButtonDefend.enabled = true
        } else if mIsUtmEye {
            mCategoryButtonTechnologies.enabled = true
            mCategoryButtonEfficacy.enabled = true
        } else if mIsIbuki {
            mCategoryButtonEfficacy.enabled = true
        } else if mIsWhiteLucentOnMakeUp {
            mCategoryButtonEfficacy.enabled = true
        } else if mIsWhiteLucentWhiteLucentAllDay {
            mCategoryButtonEfficacy.enabled = true
        } else if productId == 511 || productId == 506 || productId == 509 {
            mCategoryButtonEfficacy.enabled = true
        } else if self.product.spMovies.count != 0 {
            mCategoryButtonHowToUse.enabled = true
        } else if [588, 593, 594].contains(self.product.productId) {
            print("utm test")
            mCategoryButtonTechnologies.enabled = true
            mCategoryButtonEfficacy.enabled = true
            mCategoryButtonDefend.enabled = true
        }
        // 言語が英語の場合、特定(553,556)のproductIdに効果画面を追加
        // if LanguageConfigure.languageId == 19 {
        if productId == 553 || productId == 556 || productId == 554 || productId == 555 {
            self.mIsEE = true
            mCategoryButtonEfficacy.enabled = true
        } else if productId == 565 || productId == 566 || productId == 567 || productId == 568 || productId == 569 {
            self.mIsSDP = true
            mCategoryButtonEfficacy.enabled = true
            self.setSDPEfficacySCV()
        } else if productId == 1 || productId == 2 {
            
            mCategoryButtonEfficacy.enabled = false
        } else if productId == 564 {
            mCategoryButtonEfficacy.enabled = true
            mCategoryButtonTechnologies.enabled = true
            mCategoryButtonHowToUse.enabled = true
            self.mIsEEE = true
            self.setEEESCV()
        } else if productId == 570 {
            mCategoryButtonEfficacy.enabled = true
            mCategoryButtonHowToUse.enabled = true
            self.setWasoEfficacySCV()
        } else if productId == 571 {
            mCategoryButtonEfficacy.enabled = true
            self.setWasoEfficacySCV()
        } else if productId == 612 {
            mCategoryButtonEfficacy.enabled = true
            mCategoryButtonHowToUse.enabled = true
            mCategoryButtonTechnologies.enabled = true
        } else if productId == 613 {
            mCategoryButtonEfficacy.enabled = true
            mCategoryButtonDefend.enabled = true
            mCategoryButtonDefend.title = "Scent"
        } else if productId == 610 || productId == 611 {
            mCategoryButtonEfficacy.enabled = true
            self.setGSCEfficacySCV()
        } else if productId == 601 {
            mCategoryButtonEfficacy.enabled = true
            mCategoryButtonHowToUse.enabled = true
            self.mIsUtmMask = true
        } else if mIsLatestMoisturizer {
            mCategoryButtonTechnologies.enabled = true
        }
//        } else if productId == 588{
//            mCategoryButtonTechnologies.enabled = true
//            mCategoryButtonEfficacy.enabled = true
//            mCategoryButtonDefend.enabled = true
//        }
    }
    
    private func setCategoryButtonDefend(){
        let idArray = [28,359,588,553,554,555,556,564,593,594]
        if idArray.contains(productId){
         mCategoryButtonDefend.enabled = true
        }
    }

    private func setSpecialCaseConstraints(targetView: UIView, viewHeight: CGFloat) {
        targetView.translatesAutoresizingMaskIntoConstraints = false
        mVBaseFeaturesView.addSubview(targetView)

        let left = NSLayoutConstraint.equalLeftEdge(item: targetView, toItem: mVBaseFeaturesView)
        let right = NSLayoutConstraint.equalRightEdge(item: targetView, toItem: mVBaseFeaturesView)
        let top = NSLayoutConstraint.equalTopEdge(item: targetView, toItem: mVBaseFeaturesView)
        let bottom = NSLayoutConstraint.equalBottomEdge(item: targetView, toItem: mVBaseFeaturesView)
        let height = NSLayoutConstraint.makeHeight(item: targetView, constant: viewHeight)
        mVBaseFeaturesView.addConstraints([left, right, top, bottom, height])
    }
	
	/// waso用タップ案内view表示
	private func showWasoHukidashiGuideView() {
		if self.mWasoFeatureView == nil {
			return
		}
		
		let colorDic: [Int: UIColor] = [
			506: #colorLiteral(red: 0.9215686275, green: 0.9450980392, blue: 0.8431372549, alpha: 1),
			507: #colorLiteral(red: 1, green: 0.8823529412, blue: 0.7647058824, alpha: 1),
			508: #colorLiteral(red: 0.9215686275, green: 0.9450980392, blue: 0.8431372549, alpha: 1),
			509: #colorLiteral(red: 1, green: 0.8823529412, blue: 0.7647058824, alpha: 1),
			510: #colorLiteral(red: 0.9725490196, green: 0.968627451, blue: 0.9215686275, alpha: 1),
			511: #colorLiteral(red: 0.9921568627, green: 0.8980392157, blue: 0.737254902, alpha: 1),
			512: #colorLiteral(red: 0.8705882353, green: 0.9058823529, blue: 0.9411764706, alpha: 1),
            570: #colorLiteral(red: 0.9691396356, green: 0.8943914771, blue: 0.9179174304, alpha: 1),
            571: #colorLiteral(red: 0.8692010045, green: 0.918646872, blue: 0.8133074045, alpha: 1),
            612: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
            613: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
		]
		if let color = colorDic[self.productId] {
			self.mWasoFeatureView.showGuideView(frameColor: color)
		}
	}

    private func showUtmInfo(_ sender: CategoryButton) {
        if sender === mCategoryButtonFeatures {
            mVContent.isHidden = true
            mVCurrentSelect?.removeFromSuperview()
            mVCurrentSelect = nil
            
            if productId >= 553 && productId <= 556 {
                mImgVBackImage.image = UIImage(named: "")//FileTable.getImage(product.backImage)
                var image: UIImage = FileTable.getImage(6355)!
                let resize = CGSize(width: self.view.width, height: self.view.height + 200)
                UIGraphicsBeginImageContext(resize)
                image.draw(in: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height + 200))
                image = UIGraphicsGetImageFromCurrentImageContext()!
                self.view.backgroundColor = UIColor(patternImage: image)
                mRelationScrollV.backgroundColor = UIColor.clear
                mRelationPearentView.backgroundColor = UIColor.clear
                productDetailFeaturesView.isHidden = false
                productNamesView.isHidden = false
            }
            
            return
        }
        mVContent.isHidden = false
        mVCurrentSelect?.removeFromSuperview()
        if sender === mCategoryButtonTechnologies {
            let utmTechView = UtmTechnologiesView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            mVContent.addSubview(utmTechView!)
            utmTechView?.showTechnologiesDetail(mIsUtm)
            mVCurrentSelect = utmTechView
            
        } else if sender === mCategoryButtonHowToUse {
            if self.mIsUtmMask {
                let nib = UINib(nibName: "UtmMaskUsageView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let usageView = views[0] as? UtmMaskUsageView else { return }
                usageView.frame = mVContent.frame
                usageView.setView()
                mVContent.addSubview(usageView)
                mVCurrentSelect = usageView
            }
        } else if sender === mCategoryButtonEfficacy {
            if productId == 553 {
                productDetailFeaturesView.isHidden = true
                productNamesView.isHidden = true
                
                let utmEfficacyView = EssentialEnagyEfficacy(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                utmEfficacyView.isEssentialEnergyMoisturizingCream = true
                utmEfficacyView.backgroundColor = UIColor.clear
                mVContent.backgroundColor = UIColor.clear
                mVContent.addSubview(utmEfficacyView)
                utmEfficacyView.showEfficacyDetail()
                mVCurrentSelect = utmEfficacyView
            } else if productId == 554 {
                productDetailFeaturesView.isHidden = true
                productNamesView.isHidden = true
                
                let utmEfficacyView = EssentialEnagyEfficacy(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                utmEfficacyView.isEssentialEnergyMoisturizingGelCream = true
                utmEfficacyView.backgroundColor = UIColor.clear
                mVContent.backgroundColor = UIColor.clear
                mVContent.addSubview(utmEfficacyView)
                utmEfficacyView.showEfficacyDetail()
                mVCurrentSelect = utmEfficacyView
                
            } else if productId == 555 {
                productDetailFeaturesView.isHidden = true
                productNamesView.isHidden = true
                
                let utmEfficacyView = EssentialEnagyEfficacy(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                utmEfficacyView.isEssentialEnergyDayCX = true
                utmEfficacyView.backgroundColor = UIColor.clear
                mVContent.backgroundColor = UIColor.clear
                mVContent.addSubview(utmEfficacyView)
                utmEfficacyView.showEfficacyDetail()
                mVCurrentSelect = utmEfficacyView
                
            } else if productId == 556 {
                productDetailFeaturesView.isHidden = true
                productNamesView.isHidden = true
                
                let utmEfficacyView = EssentialEnagyEfficacy(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                utmEfficacyView.isEssentialEnergyDayCream = true
                utmEfficacyView.backgroundColor = UIColor.clear
                mVContent.backgroundColor = UIColor.clear
                mVContent.addSubview(utmEfficacyView)
                utmEfficacyView.showEfficacyDetail()
                mVCurrentSelect = utmEfficacyView
            } else if self.mIsUtmMask {
                
                let nib = UINib(nibName: "UtmMaskEfficacyView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let efficacyView = views[0] as? UtmMaskEfficacyView else { return }
                efficacyView.frame = mVContent.frame
                efficacyView.setView()
                efficacyView.mScrollV.delegate = self
                mVContent.addSubview(efficacyView)
                mVCurrentSelect = efficacyView
            }
            else {
                let utmEfficacyView = UtmEfficacyView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                utmEfficacyView?.isUtm = mIsUtm
                utmEfficacyView?.isUtmEye = mIsUtmEye
                utmEfficacyView?.isWhiteLucent = mIsWhiteLucentOnMakeUp
                utmEfficacyView?.isAllDayBright = mIsWhiteLucentWhiteLucentAllDay
                utmEfficacyView?.isIBUKI = mIsIbuki
                mVContent.addSubview(utmEfficacyView!)
                utmEfficacyView?.showEfficacyDetail()
                mVCurrentSelect = utmEfficacyView
                
                print(mVContent.size)
            }

        } else{
            let utmDefendView = UtmDefendView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            mVContent.addSubview(utmDefendView!)
            mVCurrentSelect = utmDefendView
        }
    }

    private func showSDPInfo(_ sender: CategoryButton) {
        if sender === mCategoryButtonFeatures {
            mVContent.isHidden = true
            mVCurrentSelect?.removeFromSuperview()
            mVCurrentSelect = nil
            return
        }
        mVContent.isHidden = false
        mVCurrentSelect?.removeFromSuperview()
        
        if sender === mCategoryButtonEfficacy {
            if productId == 565 || productId == 566 || productId == 567 || productId == 568 || productId == 569{
                mVContent.addSubview(self.efficacySDPScrollV)
                mVCurrentSelect = self.efficacySDPScrollV
            } 
        }
    }
    
    private func showWasoInfo(_ sender: CategoryButton) {
        if sender === mCategoryButtonFeatures {
            mVContent.isHidden = true
            mVCurrentSelect?.removeFromSuperview()
            mVCurrentSelect = nil
            return
        }
        
        if let bcV = mVContent.viewWithTag(9999){
            bcV.removeFromSuperview()
        }
        
        mVContent.isHidden = false
        mVCurrentSelect?.removeFromSuperview()
        
        let bcV = mImgVBackImage!
        let backgroundImage = bcV
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.tag = 9999
        self.mVContent.insertSubview(backgroundImage, at: 0)
        
        switch sender {
        case mCategoryButtonTechnologies:
            if productId == 612 {
                let nib = UINib(nibName: "WasoMochiTechView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let techView = views[0] as? WasoMochiTechView else { return }
                techView.frame = mVContent.frame
                mVContent.addSubview(techView)
                mVCurrentSelect = techView
            }
            
        case mCategoryButtonHowToUse:
            if productId == 570 || productId == 571 {
                let nib = UINib(nibName: "WASOPeelHowToUseResultView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let usageView = views[0] as? WASOPeelHowToUseResultView else { return }
                usageView.frame = CGRect(x: 0, y: 0, width: self.mVContent.frame.width, height: self.mVContent.height)
                mVContent.addSubview(usageView)
                mVCurrentSelect = usageView
                
            } else if productId == 612 {
                let nib = UINib(nibName: "WasoMochiUsageView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let usageView = views[0] as? WasoMochiUsageView else { return }
                usageView.frame = mVContent.frame
                mVContent.addSubview(usageView)
                mVCurrentSelect = usageView
            }
            
        case mCategoryButtonEfficacy:
            if productId == 511 {
                let nib = UINib(nibName: "EfficacyResultView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let efficacyView = views[0] as? EfficacyResultView else { return }
                efficacyView.frame = mVContent.frame
                mVContent.addSubview(efficacyView)
                mVCurrentSelect = efficacyView
            } else if productId == 506 || productId == 509 {
                let wasoEfficacyView = WasoGraphEfficacyView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                mVContent.addSubview(wasoEfficacyView)
                wasoEfficacyView.backImage = mImgVBackImage.image
                
                if productId == 506 {
                    wasoEfficacyView.setupGreen()
                } else {
                    wasoEfficacyView.setupOrange()
                }
                mVCurrentSelect = wasoEfficacyView
            } else if productId == 570 {
                mVContent.addSubview(self.efficacyWASOScrollV)
                mVCurrentSelect = self.efficacyWASOScrollV
                
                let efficacyV =  self.efficacyWASOScrollV.viewWithTag(65) as! WASOPeelFirstEfficacyResultView
                efficacyV.startAnimation()
                
            } else if productId == 571 {
                
                let nib = UINib(nibName: "WASOSleepingFirstEfficacyResultView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let efficacyView1 = views[0] as? WASOSleepingFirstEfficacyResultView else { return }
                efficacyView1.frame = CGRect(x: 0, y: 0, width: self.mVContent.frame.width, height: self.mVContent.height)
                
                self.mVContent.addSubview(efficacyView1)
                mVCurrentSelect = efficacyView1
                efficacyView1.startAnimation()
            } else if productId == 612 {
                let nib = UINib(nibName: "WasoMochiEfficacyView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let efficacyView = views[0] as? WasoMochiEfficacyView else { return }
                efficacyView.frame = mVContent.frame
                mVContent.addSubview(efficacyView)
                mVCurrentSelect = efficacyView
                
            } else if productId == 613 {
                let nib = UINib(nibName: "WasoCleanserEfficacyView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let efficacyView = views[0] as? WasoCleanserEfficacyView else { return }
                efficacyView.frame = mVContent.frame
                mVContent.addSubview(efficacyView)
                mVCurrentSelect = efficacyView
            }
            
        case mCategoryButtonDefend:
            if productId == 613 {
                let nib = UINib(nibName: "WasoCleanserScentView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let scentView = views[0] as? WasoCleanserScentView else { return }
                scentView.frame = mVContent.frame
                mVContent.addSubview(scentView)
                mVCurrentSelect = scentView
            }
            
        default:
            exit(1)
        }
    }

    private func showEEEInfo(_ sender: CategoryButton) {
        if sender === mCategoryButtonFeatures {
            mVContent.isHidden = true
            mVCurrentSelect?.removeFromSuperview()
            mVCurrentSelect = nil
            return
        }
        mVContent.isHidden = false
        mVCurrentSelect?.removeFromSuperview()
        
        if let bcV = mVContent.viewWithTag(9999){
            bcV.removeFromSuperview()
        }

        if sender === mCategoryButtonEfficacy {
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = FileTable.getImage(6355)!
            backgroundImage.contentMode = .scaleAspectFill
            backgroundImage.tag = 9999
            self.mVContent.insertSubview(backgroundImage, at: 0)
            
            mVContent.addSubview(self.efficacyEEEScrollV)
            mVCurrentSelect = self.efficacyEEEScrollV
        } else if sender === mCategoryButtonTechnologies {
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = FileTable.getImage(6355)!
            backgroundImage.contentMode = .scaleAspectFill
            backgroundImage.tag = 9999
            self.mVContent.insertSubview(backgroundImage, at: 0)
            
            mVContent.addSubview(self.technologyEEEScrollV)
            mVCurrentSelect = self.technologyEEEScrollV
        }  else if sender === mCategoryButtonHowToUse {
            mVContent.isHidden = false
            mVCurrentSelect?.removeFromSuperview()
            let makeupUsageView = MakeupUsageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            mVContent.addSubview(makeupUsageView)
            makeupUsageView.productId = productId
            mVCurrentSelect = makeupUsageView
        } else if sender === mCategoryButtonDefend {
            if product.makeupLook {
                makeCategoryImages(product.makeupLookImages)
            }
            let idArray = [28,359,588,553,554,555,556,564,593,594]
            
            if idArray.contains(productId){
                let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: NewApproachViewController.self) as! NewApproachViewController
                delegate?.nextVc(nextVc)
                
                //Feature画面再描画
                mBtnCurrentSelect?.selected = false
                mBtnCurrentSelect = mCategoryButtonFeatures
                mBtnCurrentSelect?.selected = true
                
                mVContent.isHidden = true
                mVCurrentSelect?.removeFromSuperview()
                mVCurrentSelect = nil
            }
        }
    }
    
    private func showInfo(_ sender: CategoryButton) {
        
        if [588, 593, 594].contains(self.product.productId){
            mVContent.isHidden = true
            mVCurrentSelect?.removeFromSuperview()
            
            if sender === mCategoryButtonTechnologies {
                mVContent.isHidden = false
                print("technology")
                
                self.didTapTechnology()
                
            } else if sender === mCategoryButtonEfficacy {
                mVContent.isHidden = false
                print("effect")
                
                self.didTapEfficacyResults()
                
            } else if sender === mCategoryButtonDefend {
                let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: NewApproachViewController.self) as! NewApproachViewController
                delegate?.nextVc(nextVc)
                
                //Feature画面再描画
                mBtnCurrentSelect?.selected = false
                mBtnCurrentSelect = mCategoryButtonFeatures
                mBtnCurrentSelect?.selected = true
                
                mVCurrentSelect?.removeFromSuperview()
                mVCurrentSelect = nil
            }
            return
        }
        
        mVCurrentSelect?.removeFromSuperview()
        mVContent.isHidden = false
        
        switch sender {
        case mCategoryButtonFeatures:
            mVContent.isHidden = true
            mVCurrentSelect = nil
            return
            
        case mCategoryButtonTechnologies:
            if mIsLatestMoisturizer {
                let nib = UINib(nibName: "LatestMoisturizerTechView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                
                guard let techView = views[0] as? LatestMoisturizerTechView else { return }
                techView.frame = mVContent.frame
                techView.setView(productId: self.productId)
                mVContent.addSubview(techView)
                mVCurrentSelect = techView
            } else {
                makeCategoryImages(product.technologyImage)
            }
        case mCategoryButtonHowToUse:
            setMakeUpHowToUse(product.usageImage)
            //            makeCategoryImages(product.usageImage)
            
        case mCategoryButtonEfficacy:
            makeCategoryImages(product.effectImage)
            if productId == 610 || productId == 611 {
                mVContent.isHidden = false
                mVContent.addSubview(self.efficacyGSCScrollV)
                mVCurrentSelect = self.efficacyGSCScrollV
            }
            
        case mCategoryButtonDefend:
            if product.makeupLook {
                makeCategoryImages(product.makeupLookImages)
            }
            let idArray = [28,359,588,553,554,555,556,564,593,594]
            if idArray.contains(productId){
                let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: NewApproachViewController.self) as! NewApproachViewController
                delegate?.nextVc(nextVc)
                
                //Feature画面再描画
                mVCategoryImage.isHidden = true
                mBtnCurrentSelect?.selected = false
                mBtnCurrentSelect = mCategoryButtonFeatures
                mBtnCurrentSelect?.selected = true
                
                mVContent.isHidden = true
                mVCurrentSelect?.removeFromSuperview()
                mVCurrentSelect = nil
            }
            
        default:
            print("error: CategoryButton in not found")
            exit(1)
        }
    }


	private var mAvPlayerObserver: Any? = nil

    private func showMovie(movieId: Int) {
        let avPlayer: AVPlayer = AVPlayer(url: FileTable.getPath(movieId))
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
		self.present(avPlayerVc, animated: true, completion: {
			// dismissを監視するため、オブザーバ登録する
			avPlayerVc.addObserver(self, forKeyPath: #keyPath(UIViewController.view.frame), options: [.old, .new], context: nil)
		})
		avPlayer.play()
		
		// テロップ表示用ラベル
		let telopLabel = UILabel()
		telopLabel.numberOfLines = 0
		telopLabel.lineBreakMode = .byWordWrapping
		telopLabel.backgroundColor = .clear
        telopLabel.font = UIFont(name:"Reader-Regure", size: 24.0)
        //telopLabel.font = UIFont.systemFont(ofSize: 24.0)
		telopLabel.adjustsFontSizeToFitWidth = true
		telopLabel.minimumScaleFactor = 0.6
		telopLabel.textColor = .white
		telopLabel.textAlignment = .center
		let labelWidth = self.view.width * 0.9
		telopLabel.frame = CGRect(x: (self.view.width - labelWidth) / 2.0, y: self.view.height - 60.0, width: labelWidth, height: 130.0)
		avPlayerVc.contentOverlayView?.addSubview(telopLabel)
		
		// 再生位置を監視し、テロップを表示する
		let detectionInterval = CMTime(seconds: 1.0, preferredTimescale: 10)
		self.mAvPlayerObserver = avPlayer.addPeriodicTimeObserver(forInterval: detectionInterval, queue: nil, using: { time in
			// 内部関数: 該当のテロップデータを検索する
			func searchTelop(playbackPosition: Float64) -> TelopData.DataStructTerop? {
				var result: TelopData.DataStructTerop? = nil
				for data in self.movieTelop.datas {
					if data.startTime <= playbackPosition && data.endTime >= playbackPosition {
						result = data
						break
					}
				}
				
				return result
			}
			
			// 内部関数: テロップラベルの更新
			func updateTelopLabel() {
				if let current = self.currentMovieTelop {
					telopLabel.text = current.content
				} else {
					telopLabel.text = nil
				}
			}
			
			let playbackPosition = CMTimeGetSeconds(time)
			if let current = self.currentMovieTelop {
				if current.startTime > playbackPosition || current.endTime < playbackPosition {
					self.currentMovieTelop = searchTelop(playbackPosition: playbackPosition)
					updateTelopLabel()
				}
			} else {
				self.currentMovieTelop = searchTelop(playbackPosition: playbackPosition)
				updateTelopLabel()
			}
		})
    }
	
	/// 初期特殊遷移
	private func initialTransition() {
		if let transition = self.initialTransitionDic[self.product.productId] {
			switch transition {
			case .howTowUse:
				self.didTap(self.mCategoryButtonHowToUse)
			}
		}
	}

    @objc private func onTapRelationProduct(_ sender: BaseButton) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        nextVc.productId = sender.tag
        nextVc.relationProducts = self.relationProducts
        
        if fromGscVc {
            nextVc.fromGscVc = true
            gscDelegate?.nextVc(nextVc)
        } else {
            delegate?.nextVc(nextVc)
        }
    }

    // MARK: - IBAction

    @IBAction private func onTapRecommend(_ sender: AnyObject) {
        let btnRecommend = sender as! UIButton
        btnRecommend.isSelected = !btnRecommend.isSelected
                                           
        if btnRecommend.isSelected {
            //insert
            if RecommendTable.check(product.productId) == 0 {
                var value: DBInsertValueRecommend = DBInsertValueRecommend()
                value.product = product.productId
                value.line = product.lineId
                value.beautySecond = product.beautySecondId
                RecommendTable.insert(value)
                LogManager.tapProductReccomend(recommedFlg: 1, productId: product!.productId, screenCode: self.mScreen.code)
            }
        } else {
            //delete
            RecommendTable.delete(product.productId)
            LogManager.tapProductReccomend(recommedFlg: -1, productId: product!.productId, screenCode: self.mScreen.code)
        }
    }

    @IBAction private func onTapLineDetail(_ sender: AnyObject) {
        let line = LineDetailData(lineId: self.product.lineId)
        if line.feature != "" && Bool(line.lineStepFlg as NSNumber) {
            let lineDetailVc = UIViewController.GetViewControllerFromStoryboard("LineDetailViewController", targetClass: LineDetailViewController.self) as! LineDetailViewController
            lineDetailVc.lineId = self.product.lineId
            lineDetailVc.beautySecondId = self.product.beautySecondId
            lineDetailVc.backgroundImage = FileTable.getImage(product.backImage)
            
            if fromGscVc {
                lineDetailVc.fromGscVc = true
                gscDelegate?.nextVc(lineDetailVc)
            } else {
                delegate?.nextVc(lineDetailVc)
            }
        } else {
            let lineListVc = UIViewController.GetViewControllerFromStoryboard("LineListViewController", targetClass: LineListViewController.self) as! LineListViewController
            lineListVc.line = line
            
            if fromGscVc {
                lineListVc.fromGscVc = true
                gscDelegate?.nextVc(lineListVc)
            } else {
                delegate?.nextVc(lineListVc)
            }
        }
    }

    @IBAction private func onTapOnTrendBeauty(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: OnTrendViewController.self) as! OnTrendViewController
        delegate?.nextVc(nextVc)
    }

    @IBAction private func onTapIconicBeauty(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IconicViewController.self) as! IconicViewController
        delegate?.nextVc(nextVc)
    }

    @IBAction private func onTapLifeStyleBeauty(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: LifeStyleViewController.self) as! LifeStyleViewController
        nextVc.focusScreenIds = Utility.getLifeStyleScreenIds(productId: self.productId)
        nextVc.isShowVideo = false
        nextVc.isEnterWithNavigationView = true
        delegate?.nextVc(nextVc)
    }

    @IBAction private func onTapMovie(_ sender: AnyObject) {
        self.showMovie(movieId: product.movie)
    }
    @IBAction private func onTapBrush(_ sender: AnyObject) {
        guard let item = mItems["13"],
            let json = Utility.parseJson(item),
            let productId = json["productId"].int else {
                return
        }
        let nextVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        nextVc.productId = productId
        
        if fromGscVc {
            gscDelegate?.nextVc(nextVc)
        } else {
            delegate?.nextVc(nextVc)
        }
    }

    @IBAction private func onTapMakeUpMorning(_ sender: AnyObject) {
        self.showMovie(movieId: Const.movieIdMakeUpMorning)
    }

    @IBAction private func onTapMakeUpEvening(_ sender: AnyObject) {
        self.showMovie(movieId: Const.movieIdMakeUpEvening)
    }

    @IBAction private func onTapMakeUpNight(_ sender: AnyObject) {
        self.showMovie(movieId: Const.movieIdMakeUpNight)
    }

    // MARK: - CategoryButtonDelegate
    func didTap(_ sender: CategoryButton) {

        if sender === mBtnCurrentSelect {
            return
        }
        mBtnCurrentSelect?.selected = false
        mBtnCurrentSelect = sender
        mBtnCurrentSelect?.selected = true
        if self.product.spMovies.count != 0 && sender === mCategoryButtonHowToUse {
            mVContent.isHidden = false
            mVCurrentSelect?.removeFromSuperview()
            let makeupUsageView = MakeupUsageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            mVContent.addSubview(makeupUsageView)
            makeupUsageView.productId = productId
            mVCurrentSelect = makeupUsageView
        } else {
            if mIsWaso {
                showWasoInfo(sender)
            }else if mIsUtm || mIsUtmEye || mIsWhiteLucentOnMakeUp || mIsWhiteLucentWhiteLucentAllDay || mIsIbuki || mIsEE || mIsUtmMask {
                showUtmInfo(sender)
            } else if mIsSDP {
                showSDPInfo(sender)
            } else if mIsEEE {
                showEEEInfo(sender)
            }  else {
                showInfo(sender)
            }
        }
    }

    // MARK: - UtmFeaturesViewDelegate

    func didTapTech() {
        showUtmInfo(mCategoryButtonTechnologies)
        mBtnCurrentSelect?.selected = false
        mBtnCurrentSelect = mCategoryButtonTechnologies
        mBtnCurrentSelect?.selected = true
    }

    func didTapEfficacy() {
        showUtmInfo(mCategoryButtonEfficacy)
        mBtnCurrentSelect?.selected = false
        mBtnCurrentSelect = mCategoryButtonEfficacy
        mBtnCurrentSelect?.selected = true
    }

    func didTapClose() {
        mTroubleView.isHidden = true
    }
    func didTapTrouble(_ trouble: DataStructTrouble) {
        mTroubleView.image = FileTable.getImage(trouble.image)
        mTroubleView.isHidden = false
    }

    // MARK: - UIScrollViewDelegate

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        mVMain.isUserInteractionEnabled = (scrollView.zoomScale == 1.0)
    }
    
    //*UTM2.0 add
    //Technology top
    func didTapTechnology(){
        let generateV = UIView()
        generateV.frame = CGRect(x: 0, y: 0, width: mVContent.frame.width, height: mVContent.frame.height)
        //generateV.backgroundColor = UIColor.lightGray

        let red = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 20 , y: 60, width: 600, height: 30)
        titleLabel.text = mUtmArr["1"] // "ImuGeneration Technology"
        titleLabel.font = UIFont(name: "Reader-Bold", size: 18)
        titleLabel.textColor = red
        
        let titleDescription = UILabel()
        titleDescription.frame = CGRect(x: 0, y: 420, width: 900, height: 100)
        titleDescription.centerX = self.mVContent.centerX
        titleDescription.text = mUtmArr["8"] // "To continuously generate new Langerhans cells and enhance their strength,\nShiseido’s ImuGenerationTM Technology involves three distinct ingredient combinations.\nThis triple system supports skin’s inner defenses and calms damage factors."
        titleDescription.font = UIFont(name: "Reader-Bold", size: 16)
        titleDescription.numberOfLines = 0
        titleDescription.textAlignment = NSTextAlignment.center
        titleDescription.textColor = UIColor.black
        
        generateV.addSubview(titleLabel)
        generateV.addSubview(titleDescription)
        
        for i in 0...2{

            let circleBtn = UIButton()
            circleBtn.setTitleColor(UIColor.black, for: .normal)
            circleBtn.frame = CGRect(x: 80 + (i * 280), y: 110, width: 300, height: 300)
            circleBtn.tag = i + 1
            circleBtn.addTarget(self, action: #selector(self.onTapMenu(_:)), for: .touchUpInside)
            circleBtn.layer.borderWidth = 2.0
            circleBtn.layer.borderColor = red.cgColor
            circleBtn.frame.size.height = circleBtn.frame.width
            circleBtn.layer.cornerRadius = circleBtn.frame.width/2
            print("center:*\(circleBtn.centerX)")
            
            let topicTitle = UILabel()
            topicTitle.frame = CGRect(x: 230 - 100 + (i * 280), y: 320, width: 200, height: 30)
            topicTitle.font = UIFont(name: "Reader-Bold", size: 22)

            let topicDesctription = UILabel()
            topicDesctription.frame = CGRect(x: 230 - 100 + (i * 280), y: 347, width: 200, height: 40)
            topicDesctription.textAlignment = .center
            topicDesctription.font = UIFont(name: "Reader-Medium", size: 13)
            
            self.setInsideCircle(i: i, titleText: topicTitle, descriptionText: topicDesctription, generateV:generateV)

            generateV.addSubview(circleBtn)
            generateV.addSubview(topicTitle)
            generateV.addSubview(topicDesctription)
            
        }
        // TechnologiesのTopをスクロールビューに追加
        techScrollV.addSubview(generateV)
        mVContent.addSubview(techScrollV)
        mVCurrentSelect = techScrollV
    }
    
    func setInsideCircle(i:Int, titleText:UILabel, descriptionText:UILabel, generateV: UIView){
        titleText.textColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        titleText.numberOfLines = 0
        titleText.textAlignment = NSTextAlignment.center
        
        descriptionText.textColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        descriptionText.numberOfLines = 0
        descriptionText.textAlignment = NSTextAlignment.center

        if i == 0{
            titleText.text = mUtmArr["2"] // "1. Generating"
            descriptionText.text = mUtmArr["3"] // "Langerhans cells"
           
            let image1:UIImage = UIImage(named:"Reishi_2_cmyk.png")!
            let imageView = UIImageView(image:image1)
            imageView.frame = CGRect(x: 113, y: 200, width: 115, height: 115)
            imageView.contentMode = .scaleToFill
            generateV.addSubview(imageView)

            let image2:UIImage = UIImage(named:"Iris_1_cmyk.png")!
            let imageView2 = UIImageView(image:image2)
            imageView2.frame = CGRect(x: 232, y: 200, width: 115, height: 115)
            imageView2.contentMode = .scaleToFill
            generateV.addSubview(imageView2)
            
        }else if i == 1{
            titleText.text = mUtmArr["4"] // "2. Enhances"
            descriptionText.text = mUtmArr["5"] // "the powers of\nLangerhans cells"
            
            let image1:UIImage = UIImage(named:"Rose-Water_image.png")!
            let imageView = UIImageView(image:image1)
            imageView.frame = CGRect(x: 465, y: 130, width: 90, height: 90)
            imageView.contentMode = .scaleToFill
            generateV.addSubview(imageView)
            
            let image2:UIImage = UIImage(named:"b-Glutan.png")!
            let imageView2 = UIImageView(image:image2)
            imageView2.frame = CGRect(x: 418, y: 225, width: 90, height: 90)
            imageView2.contentMode = .scaleToFill
            generateV.addSubview(imageView2)

            let image3:UIImage = UIImage(named:"Water_image_CMYK.png")!
            let imageView3 = UIImageView(image:image3)
            imageView3.frame = CGRect(x: 512, y: 225, width: 90, height: 90)
            imageView3.contentMode = .scaleToFill
            generateV.addSubview(imageView3)

        }else if i == 2{
            titleText.text = mUtmArr["6"] // "3. Improving"
            descriptionText.text = mUtmArr["7"] // "the environment for\nLangerhans cell\nfunctions"
            
            let image1:UIImage = UIImage(named:"Ginko.png")!
            let imageView = UIImageView(image:image1)
            imageView.frame = CGRect(x: 708, y: 150, width: 80, height: 80)
            imageView.contentMode = .scaleToFill
            generateV.addSubview(imageView)
            
            let image2:UIImage = UIImage(named:"LOTUS-GERM_cmyk.png")!
            let imageView2 = UIImageView(image:image2)
            imageView2.frame = CGRect(x: 792, y: 150, width: 80, height: 80)
            imageView2.contentMode = .scaleToFill
            generateV.addSubview(imageView2)
            
            let image3:UIImage = UIImage(named:"Rerilla.png")!
            let imageView3 = UIImageView(image:image3)
            imageView3.frame = CGRect(x: 708, y: 234, width: 80, height: 80)
            imageView3.contentMode = .scaleToFill
            generateV.addSubview(imageView3)
            
            let image4:UIImage = UIImage(named:"Tyme.png")!
            let imageView4 = UIImageView(image:image4)
            imageView4.frame = CGRect(x: 792, y: 234, width: 80, height: 80)
            imageView4.contentMode = .scaleToFill
            generateV.addSubview(imageView4)
        }
    }
    
    // Technologiesのスクロールボタン
    @objc private func onTapMenu(_ sender: AnyObject){
        
        var offset = CGPoint()
        if sender.tag == 1{
            print("tag:*\(sender.tag)")
            offset = CGPoint(x: 0, y: self.techScrollV.frame.height)
        } else if sender.tag == 2{
            print("tag:*\(sender.tag)")
            offset = CGPoint(x: 0, y: self.techScrollV.frame.height*2)
        } else if sender.tag == 3{
            print("tag:*\(sender.tag)")
            offset = CGPoint(x: 0, y: self.techScrollV.frame.height*3)
        }
        self.techScrollV.setContentOffset(offset, animated: true)
    }
    

    //*GeneratiogView
    func setGeneratingView(){
        let generateV = UIView()
        generateV.frame = CGRect(x: 0, y: mVContent.frame.height, width: mVContent.frame.width, height: mVContent.frame.height)
        
        let red = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        
        let mark:UIImage = UIImage(named:"point_01")!
        let markV = UIImageView(image:mark)
        markV.frame = CGRect(x: 80, y: 90, width: 1, height: 50)
        markV.contentMode = .scaleToFill
        generateV.addSubview(markV)
        
        let image1:UIImage = UIImage(named:"Reishi_2_cmyk.png")!
        let imageView1 = UIImageView(image:image1)
        imageView1.frame = CGRect(x: 100, y: 240, width: 180, height: 120)
        imageView1.contentMode = .scaleToFill
        generateV.addSubview(imageView1)
        
        let image2:UIImage = UIImage(named:"Iris_1_cmyk.png")!
        let imageView2 = UIImageView(image:image2)
        imageView2.frame = CGRect(x: 290, y: 240, width: 180, height: 120)
        imageView2.contentMode = .scaleToFill
        generateV.addSubview(imageView2)
        
        for i in 1...5{
            let text = UILabel()
            text.textColor = UIColor.black
            text.numberOfLines = 0
            text.textAlignment = NSTextAlignment.left
            
            if i == 1{
                text.frame = CGRect(x: 20 , y: 5, width: 400, height: 60)
                text.text = mUtmArr["9"] // "Ingredients that generate\nmore Langerhans cells"
                text.font = UIFont(name: "Reader-Bold", size: 21)
            }else if i == 2{
                text.frame = CGRect(x: 100 , y: 90, width: 500, height: 50)
                text.text = mUtmArr["10"] // "Even when exposed to damage-inducing factors, the combination of Reishi Extract and Iris\nRoot Extract help precursor cells grow into Langerhans cells and increase their numbers.*"
                text.font = UIFont(name: "Reader-Medium", size: 12)
            }else if i == 3{
                text.frame = CGRect(x: 100 , y:180, width: 320, height: 50) // width: 300, height: 50)
                text.text = mUtmArr["11"] // "Ingredients nurture\nLangerhans cell growth."
                text.font = UIFont(name: "Reader-Bold", size: 16) //18
                text.textColor = red
            }else if i == 4{
                text.frame = CGRect(x: 0 , y:365, width: 120, height: 50)
                text.centerX = imageView1.centerX
                text.text = mUtmArr["12"] // "Reishi Extract"
                text.font = UIFont(name: "Reader-Medium", size: 12)
            }else if i == 5{
                text.frame = CGRect(x: 0 , y:365, width: 130, height: 50)
                text.centerX = imageView2.centerX
                text.text = mUtmArr["13"] // "Iris Root Extract"
                text.font = UIFont(name: "Reader-Medium", size: 12)
            }

            generateV.addSubview(text)
        }
        
        //graphImage
        for i in 1...7{
            let image:UIImage = UIImage(named:"graph_0\(i).png")!
            let graphV = UIImageView(image:image)
            graphV.contentMode = .scaleToFill
            
            if i == 1{
                graphV.frame = CGRect(x: 570, y: 180, width: 400, height: 250)//graph
            }else if i == 2{
                graphV.frame = CGRect(x: 610, y: 275, width: 60, height: 154)//gray
            }else if i == 3{
                graphV.frame = CGRect(x: 800, y: 219, width: 60, height: 210)//red
            }else if i == 4{
                graphV.frame = CGRect(x: 525, y: 190, width: 20, height: 26)//high
            }else if i == 5{
                graphV.frame = CGRect(x: 840, y: 240, width: 82, height: 200)//item
            }else if i == 6{
                graphV.frame = CGRect(x: 580, y: 440, width:390, height: 10)//under
            }else if i == 7{
                graphV.frame = CGRect(x: 675, y: 220, width:116, height: 50)//up
            }
            
            generateV.addSubview(graphV)
        }
        
        //graphText
        for i in 1...5{
            let graphLabel = UILabel()
            graphLabel.textColor = UIColor.black
            graphLabel.numberOfLines = 0
            graphLabel.textAlignment = NSTextAlignment.left
            graphLabel.font = UIFont(name: "Reader-Medium", size: 12)

            
            if i == 1{
                graphLabel.frame = CGRect(x: 520, y:220, width: 40, height: 20)
                graphLabel.text = mUtmArr["14"] // "High"
                graphLabel.font = graphLabel.font.withSize(16)
                
            }else if i == 2{
                graphLabel.frame = CGRect(x: 590 , y:160, width: 200, height: 100)
                graphLabel.text = mUtmArr["15"] // "Growth rate of\nprecursor cells into\nLangerhans cells"
                
            }else if i == 3{
                graphLabel.frame = CGRect(x: 600 , y:450, width: 170, height: 80)
                graphLabel.text = mUtmArr["16"] // "Under high\nstress*"
                graphLabel.font = graphLabel.font.withSize(14)
                graphLabel.sizeToFit()
                graphLabel.textAlignment = NSTextAlignment.center

            }else if i == 4{
                graphLabel.frame = CGRect(x: 770 , y:450, width: 170, height: 80)
                graphLabel.text = mUtmArr["17"] // "Under high stress**\nwith Ultimune"
                graphLabel.font = graphLabel.font.withSize(14)
                graphLabel.sizeToFit()
                graphLabel.textAlignment = NSTextAlignment.center
            }else if i == 5{
                graphLabel.frame = CGRect(x: 650 , y:490, width: 500, height: 20) //t-hirai
                graphLabel.text = mUtmArr["18"] // "*in vitro **By adding a stress hormone in vitro data"
                graphLabel.font = UIFont(name: "Reader-Bold", size: 13)
                graphLabel.textColor = UIColor.lightGray
                graphLabel.numberOfLines = 3
            }
        
            generateV.addSubview(graphLabel)
        }

        self.techScrollV.addSubview(generateV)
    }
    
    //enhanceView
    func setEnhanceView(){
        let enhanceV = UIView()
        enhanceV.frame = CGRect(x: 0, y: mVContent.frame.height*2, width: self.techScrollV.frame.width, height: mVContent.frame.height)
        let red = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        
        //text
        for i in 1...5{
            let pageText = UILabel()
            pageText.textColor = UIColor.black
            pageText.numberOfLines = 0
            pageText.textAlignment = NSTextAlignment.left
            
            if i == 1{
                pageText.frame = CGRect(x: 20, y:5, width: 400, height: 60)
                pageText.text = mUtmArr["19"] // "Ingredients enhance\nstress-calming power"
                pageText.font = UIFont(name: "Reader-Bold", size: 22)
                
            }else if i == 2{
                pageText.frame = CGRect(x: 100 , y: 85, width: 500, height: 20)
                pageText.text = mUtmArr["20"] // "Ultimune ComplexTM"
                pageText.font = UIFont(name: "Reader-Bold", size: 18)
                pageText.textColor = red

            }else if i == 3{
                pageText.frame = CGRect(x: 100 , y: 95, width: 500, height: 100)
                pageText.text = mUtmArr["21"] // "Ultimune ComplexTM contains highly effective stress-reducers, such as ß-glucan, which is\nextracted from bread yeast. The most effective ingredient for active fermentation, it has an\neffect on Langerhans cells as well. It also provides a rich source of nutrients."
                pageText.font = UIFont(name: "Reader-Medium", size: 12)
            }else if i == 4{
                pageText.frame = CGRect(x: 210 , y: 290, width: 150, height: 100)
                pageText.textAlignment = NSTextAlignment.center
                pageText.text = mUtmArr["20"] // "Ultimune\nComplexTM"
                pageText.font = UIFont(name: "Reader-Bold", size: 17)
                pageText.textColor = red
            }else if i == 5{
                pageText.frame = CGRect(x: 20 , y: 470, width: 400, height: 40)
                //pageText.text = mUtmArr["25"] // "Shiseido is the first company to test a skin-care\nproduct on women experiencing con" //t-hirai
                pageText.font = UIFont(name: "Reader-Medium", size: 11)
                pageText.font = UIFont(name: "Reader-Bold", size: 13)
                pageText.textColor = UIColor.lightGray
            }
            
            enhanceV.addSubview(pageText)
            
        }
        
        for i in 1...2{
            let image:UIImage = UIImage(named:"page_0\(i).png")!
            let pageImageV = UIImageView(image:image)
            pageImageV.contentMode = .scaleToFill
            
            if i == 1{
                pageImageV.frame = CGRect(x: 80, y: 83, width: 1, height: 100)//point
            }else if i == 2{
                pageImageV.frame = CGRect(x: 150, y: 200, width: 265, height: 248)//triangle
            }
            
            enhanceV.addSubview(pageImageV)
        }
        
        //graph image
        
        for i in 1...7{
            let image:UIImage = UIImage(named:"enhanceGraph_0\(i).png")!
            let graphImageV = UIImageView(image:image)
            graphImageV.contentMode = .scaleToFill
            
            if i == 1{
                graphImageV.frame = CGRect(x: 510, y: 210, width: 400, height: 250)//graph
            }else if i == 2{
                graphImageV.frame = CGRect(x: 600, y: 325, width: 60, height: 134)//gray
            }else if i == 3{
                graphImageV.frame = CGRect(x: 770, y: 240, width: 60, height: 219)//red
            }else if i == 4{
                graphImageV.frame = CGRect(x: 485, y: 210, width: 18, height: 24)//high
            }else if i == 5{
                graphImageV.frame = CGRect(x: 550, y: 200, width: 115, height: 115)//64%
            }else if i == 6{
                graphImageV.frame = CGRect(x: 670, y: 250, width: 90, height: 58)//up
            }else if i == 7{
                graphImageV.frame = CGRect(x: 825, y: 260, width: 86, height: 210)//item
            }
            
           enhanceV.addSubview(graphImageV)

        }
        
        //graph text
        for i in 1...4{
            let graphText = UILabel()
            graphText.textColor = UIColor.black
            graphText.numberOfLines = 0
            graphText.textAlignment = NSTextAlignment.center
            graphText.textColor = UIColor.black
            graphText.font = UIFont(name: "Reader-Medium", size: 12)
            graphText.font = graphText.font.withSize(14)

            
            if i == 1{
                graphText.frame = CGRect(x: 475, y: 232, width: 40, height: 40)
                graphText.text = mUtmArr["14"] // "High"
            }else if i == 2{
                graphText.frame = CGRect(x: 470, y: 315, width: 40, height: 40)
                graphText.text = mUtmArr["22"] // "100%"
            }else if i == 3{
                graphText.frame = CGRect(x: 590, y: 453, width: 120, height: 60)
                graphText.text = mUtmArr["23"] // "without Ultimune\ncomplex"
            }else if i == 4{
                graphText.frame = CGRect(x: 760, y: 453, width: 120, height: 60)
                graphText.text = mUtmArr["24"] // "with Ultimune\ncomplex"
            }
            
            enhanceV.addSubview(graphText)

        }
        
        
        self.techScrollV.addSubview(enhanceV)
    }
    
    
    //ImucalmView
    func setImucalmView(){

        mUtmTechV = UtmTechnologiesView(frame: CGRect(origin: CGPoint(x: 0, y: mVContent.frame.height*3), size: self.techScrollV.size))
        //mVContent.addSubview(utmTechView!)
        //mVCurrentSelect = utmTechView
        
        mUtmTechV?.showImucalmCompound(mIsUtm)
        self.techScrollV.addSubview(mUtmTechV!)

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.techScrollV.contentOffset.y >= self.techScrollV.frame.height*2{
            mUtmTechV?.showImucalmArrowEffect(mIsUtm)
        }
    }

    
    func didTapEfficacyResults(){
        print("Efficacy")
    
        //初期位置
        for i in 0...1{
            if let beforeBtn = self.efficacyScrollV.viewWithTag(10 + i) as? UIButton {
                beforeBtn.isEnabled = false
                beforeBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
                beforeBtn.setTitleColor(UIColor.white, for: .normal)
            }
            if let afterBtn = self.efficacyScrollV.viewWithTag(20 + i) as? UIButton {
                afterBtn.isEnabled = true
                afterBtn.backgroundColor = UIColor.clear
                afterBtn.setTitleColor(UIColor.black, for: .normal)
            }
            let imageNum = i + 1
            if let imageView = self.efficacyScrollV.viewWithTag(30 + i) as? UIImageView{
                imageView.image = UIImage(named: "before_0\(imageNum).png")
            }
        }
        self.efficacyScrollV.contentOffset = CGPoint(x: 0, y: 0)
        
        mVContent.addSubview(efficacyScrollV)
        mVCurrentSelect = efficacyScrollV
    }
    
    func setEfficacyView(){
        //1~3枚め
        for i in 0...1 {
            let title = UILabel()
            title.textColor = UIColor.black
            title.font = UIFont(name: "Reader-Bold", size: 22)
            title.numberOfLines = 3 //t-hirai
            title.frame = CGRect(x: 0, y: 0+(Int(self.efficacyScrollV.frame.height)*i), width: 700, height: 80)//t-hirai
            title.centerX = self.mVContent.centerX
            title.textAlignment = .center
            
            if i == 0{
                title.text =  mUtmArr["26"] 

            }else if i == 1{
                title.text = mUtmArr["32"] // "Skin looks smoother, more dewy and radiant."

            }
            
            let imageNum = i + 1
            let image_after = UIImage(named: "after_0\(imageNum).png")
            let faceImageV_after = UIImageView(image:image_after)
            faceImageV_after.contentMode = .scaleAspectFit
            faceImageV_after.clipsToBounds = true
            faceImageV_after.frame = CGRect(x: 0, y: 70+(Int(self.efficacyScrollV.frame.height)*i), width: 300, height: 300)
            faceImageV_after.centerX = self.mVContent.centerX
            faceImageV_after.backgroundColor = UIColor.clear
            
            let image = UIImage(named: "before_0\(imageNum).png")
            let faceImageV = UIImageView(image:image)
            faceImageV.contentMode = .scaleAspectFit
            faceImageV.tag = 30 + i//300
            faceImageV.clipsToBounds = true
            faceImageV.frame = CGRect(x: 0, y: 70+(Int(self.efficacyScrollV.frame.height)*i), width: 300, height: 300)
            faceImageV.centerX = self.mVContent.centerX
            faceImageV.backgroundColor = UIColor.clear
            
            let beforeBtn = UIButton()
            beforeBtn.isEnabled = false
            beforeBtn.frame = CGRect(x: 0, y: 400+(Int(self.efficacyScrollV.frame.height)*i), width: 145, height: 30)
            beforeBtn.origin.x = self.mVContent.centerX - beforeBtn.frame.width - 10
            beforeBtn.setTitle(mUtmArr["27"], for: .normal) // "Before"
            beforeBtn.isEnabled = false
            beforeBtn.setTitleColor(UIColor.white, for: .normal)
            beforeBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            beforeBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 12)
            beforeBtn.tag = 10 + i//100
            beforeBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            let afterBtn = UIButton()
            afterBtn.isEnabled = true
            afterBtn.frame = CGRect(x: 0, y: 400+(Int(self.efficacyScrollV.frame.height)*i), width: 145, height: 30)
            afterBtn.origin.x = self.mVContent.centerX + 10
            afterBtn.setTitle(mUtmArr["28"], for: .normal) // "After 4 Weeks"
            afterBtn.isEnabled = true
            afterBtn.setTitleColor(UIColor.white, for: .normal)
            afterBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            
            afterBtn.setTitleColor(UIColor.black, for: .normal)
            afterBtn.backgroundColor = UIColor.white
            afterBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 12)
            afterBtn.tag = 20 + i//200
            afterBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            
            for j in 0...2{
                let image:UIImage = UIImage(named:"point_01.png")!
                let border = UIImageView(image:image)
                border.contentMode = .scaleToFill
                
                if j == 0{
                    border.frame = CGRect(x: Int(self.mVContent.centerX) - Int(beforeBtn.frame.width) - 20, y: 398+(Int(self.efficacyScrollV.frame.height)*i), width: 1, height: 34)
                }else if j == 1{
                    border.frame = CGRect(x: Int(self.mVContent.centerX), y: 398+(Int(self.efficacyScrollV.frame.height)*i), width: 1, height: 34)
                    
                }else if j == 2{
                    border.frame = CGRect(x: Int(self.mVContent.centerX) + Int(afterBtn.frame.width) + 20, y: 398+(Int(self.efficacyScrollV.frame.height)*i), width: 1, height: 34)

                }
                self.efficacyScrollV.addSubview(border)

            }
            
            self.efficacyScrollV.addSubview(title)
            self.efficacyScrollV.addSubview(faceImageV_after)
            self.efficacyScrollV.addSubview(faceImageV)
            self.efficacyScrollV.addSubview(beforeBtn)
            self.efficacyScrollV.addSubview(afterBtn)

        }
        
        //4枚め
        
        let title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont(name: "Reader-Bold", size: 22)
        title.text = mUtmArr["34"] // "After 4 weeks of use:"
        title.frame = CGRect(x: 0, y: 10+(Int(self.efficacyScrollV.frame.height)*2), width: 700, height: 40)
        title.centerX = self.mVContent.centerX
        title.textAlignment = .center
        self.efficacyScrollV.addSubview(title)
        
        for i in 1...3{
            // 画像の場合
            // let image:UIImage = UIImage(named:"percent_0\(i).png")!
            // let percentImageV = UIImageView(image:image)
            // percentImageV.contentMode = .scaleToFill
            // percentImageV.frame = CGRect(x: Int(self.mVContent.centerX) - 230, y: 110 + Int(self.efficacyScrollV.frame.height)*3+(130*(i-1)), width: 150, height: 59)
            
            // self.efficacyScrollV.addSubview(percentImageV)
            
            // テキストの場合
            let percentLabel = UILabel()
            percentLabel.textColor = UIColor.black
            percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
            if i == 1 {
                percentLabel.text = mUtmArr["35"]
            } else if i == 2 {
                percentLabel.text = mUtmArr["37"]
            } else {
                percentLabel.text = mUtmArr["39"]
            }
            percentLabel.frame = CGRect(x: Int(self.mVContent.centerX) - 230, y: 110 + Int(self.efficacyScrollV.frame.height)*2+(130*(i-1)), width: 160, height: 82)
            percentLabel.textAlignment = .center
            self.efficacyScrollV.addSubview(percentLabel)
        }
        
        for i in 1...3{
            let description = UILabel()
            description.textColor = UIColor.black
            description.font = UIFont(name: "Reader-Medium", size: 12)
            description.numberOfLines = 0
            description.textAlignment = .left
            description.frame = CGRect(x: Int(self.mVContent.centerX) - 50, y: 70 + Int(self.efficacyScrollV.frame.height)*2+(130*(i-1)), width: 200, height: 150)

            
            if i == 1{
                description.text = mUtmArr["36"] // "of women felt that the product\nwas effective overall"
            }else if i == 2{
                description.text = mUtmArr["38"] // "of women felt their skin was\ndefended against harsh\nenvironments"
            }else if i == 3{
                description.text = mUtmArr["40"] // "of women said their skin\nquality was improved overall"
            }
            self.efficacyScrollV.addSubview(description)
        }
        
        //右下テキスト
        for i in 1...3{
            let text = UILabel()
            text.textColor = UIColor.lightGray
            text.font = UIFont(name: "Reader-Medium", size: 12)
            text.font = text.font.withSize(13)
            text.textAlignment = .center
            text.numberOfLines = 0
            text.frame = CGRect(x: 800, y: 450+(Int(self.efficacyScrollV.frame.height)*(i - 1)), width: 200, height: 40)
            
            if i == 1{
                text.text = mUtmArr["29"] // "*28-year-old"

            } else if i == 2{
                text.text = mUtmArr["31"] // "*39-year-old"

            } else if i == 3{
                text.frame = CGRect(x: 700, y: 450+(Int(self.efficacyScrollV.frame.height)*(i - 1)), width: 300, height: 60)
                text.text = mUtmArr["42"] //"*100 women of age 25-39 after 4 weeks of use.\n2017/1/10-2/7 in Singapore"
            }
            
            self.efficacyScrollV.addSubview(text)
        }

    }
    
    @objc private func onTapBeforeAfterBtn(_ sender: UIButton){
        print("tag:*\(sender.tag)")
        
        if mIsEEE {
            if sender.tag < 20{//Before
                
                sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.isEnabled = false
                if let afterBtn = self.efficacyEEEScrollV.viewWithTag(sender.tag + 10) as? UIButton {
                    afterBtn.isEnabled = true
                    afterBtn.backgroundColor = UIColor.clear
                    afterBtn.setTitleColor(UIColor.black, for: .normal)
                }
                if let imageView = self.efficacyEEEScrollV.viewWithTag(sender.tag + 20) as? UIImageView{
                    UIView.animate(withDuration: 1.0) {
                        imageView.alpha = 1
                    }
                }
                
            }else{//After
                
                sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.isEnabled = false
                if let beforeBtn = self.efficacyEEEScrollV.viewWithTag(sender.tag - 10) as? UIButton {
                    beforeBtn.isEnabled = true
                    beforeBtn.backgroundColor = UIColor.clear
                    beforeBtn.setTitleColor(UIColor.black, for: .normal)
                }
                if let imageView = self.efficacyEEEScrollV.viewWithTag(sender.tag + 10) as? UIImageView{
                    UIView.animate(withDuration: 1.0) {
                        imageView.alpha = 0
                    }
                }
                
            }
        }  else if self.mIsWaso{
            if sender.tag < 20{//Before
                
                sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.isEnabled = false
                if let afterBtn = self.efficacyWASOScrollV.viewWithTag(sender.tag + 10) as? UIButton {
                    afterBtn.isEnabled = true
                    afterBtn.backgroundColor = UIColor.clear
                    afterBtn.setTitleColor(UIColor.black, for: .normal)
                }
                if let imageView = self.efficacyWASOScrollV.viewWithTag(sender.tag + 20) as? UIImageView{
                    UIView.animate(withDuration: 1.0) {
                        imageView.alpha = 1
                    }
                }
                
            }else{//After
                
                sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.isEnabled = false
                if let beforeBtn = self.efficacyWASOScrollV.viewWithTag(sender.tag - 10) as? UIButton {
                    beforeBtn.isEnabled = true
                    beforeBtn.backgroundColor = UIColor.clear
                    beforeBtn.setTitleColor(UIColor.black, for: .normal)
                }
                if let imageView = self.efficacyWASOScrollV.viewWithTag(sender.tag + 10) as? UIImageView{
                    UIView.animate(withDuration: 1.0) {
                        imageView.alpha = 0
                    }
                }
                
            }
        }   
        else{
        if sender.tag < 20{//Before
            
            sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.isEnabled = false
            if let afterBtn = self.efficacyScrollV.viewWithTag(sender.tag + 10) as? UIButton {
                afterBtn.isEnabled = true
                afterBtn.backgroundColor = UIColor.clear
                afterBtn.setTitleColor(UIColor.black, for: .normal)
            }
            if let imageView = self.efficacyScrollV.viewWithTag(sender.tag + 20) as? UIImageView{
                UIView.animate(withDuration: 1.0) {
                    imageView.alpha = 1
                }
            }
            
        }else{//After
        
            sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.isEnabled = false
            if let beforeBtn = self.efficacyScrollV.viewWithTag(sender.tag - 10) as? UIButton {
                beforeBtn.isEnabled = true
                beforeBtn.backgroundColor = UIColor.clear
                beforeBtn.setTitleColor(UIColor.black, for: .normal)
            }
            if let imageView = self.efficacyScrollV.viewWithTag(sender.tag + 10) as? UIImageView{
                UIView.animate(withDuration: 1.0) {
                    imageView.alpha = 0
                }
            }
            
        }
        }   
    }
    

}
