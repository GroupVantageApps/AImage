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

class ProductDetailViewController: UIViewController, NavigationControllerAnnotation, CategoryButtonDelegate, UtmFeaturesViewDelegate, TroubleViewDelegate, TroubleSelectViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak private var mImgVProduct: UIImageView!
    @IBOutlet weak private var mImgVFirstDailyCare: UIImageView!
    @IBOutlet weak private var mImgVSecondDailyCare: UIImageView!

    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mVBaseIbukiBtn: UIView!
    @IBOutlet weak private var mVBaseFeaturesView: UIView!
    @IBOutlet weak private var mRelationScrollV: UIScrollView!
    @IBOutlet weak private var mVScrollContent: UIView!
    @IBOutlet weak private var mVSkinConcern: ProductDetailSkinConcernView!
    @IBOutlet weak private var mTroubleSelectView: TroubleSelectView!
    @IBOutlet weak private var mColorballCollectionView: ColorballCollectionView!
    @IBOutlet weak private var mVRelationProductBase: UIView!
    @IBOutlet weak private var mVCategoryImage: UIView!
    @IBOutlet weak private var mVCategoryImageBase: UIView!
    @IBOutlet weak private var mTroubleView: TroubleView!
    @IBOutlet weak private var mVColorBall: UIView!

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
    @IBOutlet weak private var mConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintRight: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintColorballHeight: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintColorballBottom: NSLayoutConstraint!

    @IBOutlet weak private var mImageBackgroundDot: UIImageView!        //17SS移植用 水玉背景画像

    @IBOutlet weak private var mTransitionView: ProductDetailTransitionView!

    @IBOutlet weak private var mScrollVPinch: UIScrollView!
    @IBOutlet weak private var mVMain: UIView!
    @IBOutlet weak private var mImgVBackImage: UIImageView!

    private let mScreen = ScreenData(screenId: Const.screenIdProductDetail)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    var productId: Int!

    var mIsUtm: Bool = false
    var mIsUtmEye: Bool = false
    var mIsIbuki: Bool = false
    var mIsWhiteLucentOnMakeUp: Bool = false
    var mIsWhiteLucentWhiteLucentAllDay: Bool = false
    var mIsSunCareBBSports: Bool = false
    var mIsSunCarePerfectUv: Bool = false
    var mIsMakeUp: Bool = false
    var mIsWaso: Bool = false

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
        mCategoryButtonDefend.title = mItemsSideMenu["16"]
        mTransitionView.setLikeItText(text: mItemsSideMenu["09"])

        mImgVProduct.image = FileTable.getImage(product.image)
        mImgVBackImage.image = FileTable.getImage(product.backImage)
        mLblBeautyName.text = product.beautyName
        mLblLineName.text = product.lineName
        mLblProductName.text = product.productName
        mLblFeature.text = product.feature
        mLblHowToUse.text = product.howToUse
        mLblUnit.text = product.spec

        mCategoryButtonTechnologies.enabled = (product.technologyImage.count != 0)
        mCategoryButtonHowToUse.enabled = (product.usageImage.count != 0)
        mCategoryButtonEfficacy.enabled = (product.effectImage.count != 0)
        mCategoryButtonDefend.enabled = mIsUtm

        self.setSpecialMenu()

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
        mVSkinConcern.troubles = product.troubles
        mTroubleSelectView.troubles = product.troubles

        print("++++++++++++++++++++++++++++++++++++++++++++++++")
        print(self.product.colorballs)
        print(self.product.productId)
        print("++++++++++++++++++++++++++++++++++++++++++++++++")

        mVBaseIbukiBtn.isHidden = !mIsMakeUp

        //#804 スライド5.6の背景の水玉表示
        if self.product.productId == 498 || self.product.productId == 499 {
            mImageBackgroundDot.isHidden = false
        } else {
            mImageBackgroundDot.isHidden = true
        }

        self.initTransitionView()

        mScrollVPinch.delegate = self
		
		// 動画テロップデータ読み込み
		self.movieTelop = TelopData(movieId: product.movie)
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

    override func viewDidAppear(_ animated: Bool) {
        if mIsUtm || mIsUtmEye {
            mUtmFeaturesView.showAnimation()
        }
            mConstraintColorballHeight.constant = mColorballCollectionView.contentSize.height
		
		self.mWasoFeatureView.beginGuideFrameAnimation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        product = ProductDetailData(productId: productId)
        mTransitionView.isLikeItSelected(isSelected: Bool(product!.recommend as NSNumber))
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
        var datas = [ProductDetailTransitionData]()
        datas.append(ProductDetailTransitionData(title: self.product.lineName, selector: #selector(self.onTapLineDetail(_:))))
        if Utility.getLifeStyleScreenIds(productId: self.productId) != nil {
            datas.append(ProductDetailTransitionData(title: "Life Style Beauty", selector: #selector(self.onTapLifeStyleBeauty(_:))))
        }
        if Utility.isIconicProduct(productId: self.productId) {
            datas.append(ProductDetailTransitionData(title: "Iconic Beauty", selector: #selector(self.onTapIconicBeauty(_:))))
        }
        if Utility.isOnTrendProduct(productId: self.productId) {
            datas.append(ProductDetailTransitionData(title: "Latest Beauty", selector: #selector(self.onTapOnTrendBeauty(_:))))
        }
		
        mTransitionView.setProductDetailTransitionData(datas, target: self)
        mTransitionView.cellHeight = 34
        mTransitionView.setLikeItSelector(#selector(self.onTapRecommend(_:)), target: self)
    }

    private func initSpecialView() {
        if mIsUtm || mIsUtmEye {
            mUtmFeaturesView = UtmFeaturesView()
            mUtmFeaturesView.delegate = self
            mUtmFeaturesView.bottomPadding = 30

            self.setSpecialCaseConstraints(targetView: mUtmFeaturesView, viewHeight: 300)
        } else if mIsIbuki {
            mIbukiFeaturesView = IbukiFeaturesView()
            mIbukiFeaturesView.delegate = self
            mIbukiFeaturesView.bottomPadding = 30

            self.setSpecialCaseConstraints(targetView: mIbukiFeaturesView, viewHeight: 211)
        } else if mIsWhiteLucentWhiteLucentAllDay {
            mWhiteLucentAllDayFeaturesView = WhiteLucentFeaturesView()
            mWhiteLucentAllDayFeaturesView.bottomPadding = 30

            self.setSpecialCaseConstraints(targetView: mWhiteLucentAllDayFeaturesView, viewHeight: 330)
        } else if mIsSunCareBBSports || mIsSunCarePerfectUv {
            mSuncareFeaturesView = SunCareFeaturesView()
            mSuncareFeaturesView.isGSC = mIsSunCareBBSports
            mSuncareFeaturesView.isSCP = mIsSunCarePerfectUv
            mSuncareFeaturesView.bottomPadding = 30

            self.setSpecialCaseConstraints(targetView: mSuncareFeaturesView, viewHeight: 300)
        } else if mIsWaso {
            mWasoFeatureView = WasoFeatureView()
            self.setWasoData()
            self.setSpecialCaseConstraints(targetView: mWasoFeatureView, viewHeight: 260)
            mWasoFeatureView.startAnimation()
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
        }
        if itemId != nil {
            mWasoFeatureView.hukidashiText = AppItemTable.getJsonByItemId(itemId: itemId!)?.dictionary?["name"]?.string
        }
        mWasoFeatureView.image = image
    }

    private func checkSpecialCase() {
        mIsUtm = Const.productIdUtm == self.productId
        mIsUtmEye = Const.productIdUtmEye == self.productId
        mIsIbuki = Const.productIdIbuki == self.productId
        mIsWhiteLucentOnMakeUp = Const.productIdWhiteLucentOnMakeUp == self.productId
        mIsWhiteLucentWhiteLucentAllDay = Const.productIdWhiteLucentAllDay == self.productId
        mIsSunCareBBSports = Const.productIdSunCareBBSports == self.productId
        mIsSunCarePerfectUv = Const.productIdSunCarePerfectUv == self.productId
        mIsMakeUp = Const.productIdMakeUp == self.productId
        mIsWaso = Const.lineIdWASO == self.product.lineId
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
			512: #colorLiteral(red: 0.8705882353, green: 0.9058823529, blue: 0.9411764706, alpha: 1)
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
            return
        }
        mVContent.isHidden = false
        mVCurrentSelect?.removeFromSuperview()
        if sender === mCategoryButtonTechnologies {
            let utmTechView = UtmTechnologiesView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            mVContent.addSubview(utmTechView!)
            utmTechView?.showTechnologiesDetail(mIsUtm)
            mVCurrentSelect = utmTechView
        } else if sender === mCategoryButtonEfficacy {
            if productId == 511 {
                let nib = UINib(nibName: "EfficacyResultView", bundle: nil)
                let views = nib.instantiate(withOwner: self, options: nil)
                guard let efficacyView = views[0] as? EfficacyResultView else { return }
                efficacyView.frame = mVContent.frame
                mVContent.addSubview(efficacyView)
                mVCurrentSelect = efficacyView
            }else if productId == 506 || productId == 509 {
                let wasoEfficacyView = WasoGraphEfficacyView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                mVContent.addSubview(wasoEfficacyView)
                wasoEfficacyView.backImage = mImgVBackImage.image

                if productId == 506 {
                    wasoEfficacyView.setupGreen()
                } else {
                    wasoEfficacyView.setupOrange()
                }
                mVCurrentSelect = wasoEfficacyView
            } else {
                let utmEfficacyView = UtmEfficacyView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
                utmEfficacyView?.isUtm = mIsUtm
                utmEfficacyView?.isUtmEye = mIsUtmEye
                utmEfficacyView?.isWhiteLucent = mIsWhiteLucentOnMakeUp
                utmEfficacyView?.isAllDayBright = mIsWhiteLucentWhiteLucentAllDay
                utmEfficacyView?.isIBUKI = mIsIbuki
                mVContent.addSubview(utmEfficacyView!)
                utmEfficacyView?.showEfficacyDetail()
                mVCurrentSelect = utmEfficacyView
            }

        } else if sender === mCategoryButtonDefend {
            let utmDefendView = UtmDefendView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            mVContent.addSubview(utmDefendView!)
            mVCurrentSelect = utmDefendView
        }
    }

    private func showInfo(_ sender: CategoryButton) {
        mVContent.isHidden = true
        mVCurrentSelect?.removeFromSuperview()
        mVCurrentSelect = nil
        if sender === mCategoryButtonFeatures {
            mVCategoryImage.isHidden = true
            return
        }
        mVCategoryImage.isHidden = false
        if sender === mCategoryButtonTechnologies {
            makeCategoryImages(product.technologyImage)
        } else if sender === mCategoryButtonHowToUse {
            makeCategoryImages(product.usageImage)
        } else if sender === mCategoryButtonEfficacy {
            makeCategoryImages(product.effectImage)
        } else if sender === mCategoryButtonDefend {

        }
    }

    private func showMovie(movieId: Int) {
        let avPlayer: AVPlayer = AVPlayer(url: FileTable.getPath(movieId))
        let avPlayerVc: AVPlayerViewController = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        self.present(avPlayerVc, animated: true, completion: nil)
        avPlayer.play()
		
		// テロップ表示用ラベル
		let telopLabel = UILabel()
		telopLabel.numberOfLines = 0
		telopLabel.lineBreakMode = .byWordWrapping
		telopLabel.backgroundColor = .clear
		telopLabel.font = UIFont.systemFont(ofSize: 24.0)
		telopLabel.adjustsFontSizeToFitWidth = true
		telopLabel.minimumScaleFactor = 0.6
		telopLabel.textColor = .white
		telopLabel.textAlignment = .center
		let labelWidth = self.view.width * 0.9
		telopLabel.frame = CGRect(x: (self.view.width - labelWidth) / 2.0, y: self.view.height - 60.0, width: labelWidth, height: 130.0)
		avPlayerVc.contentOverlayView?.addSubview(telopLabel)
		
		// 再生位置を監視し、テロップを表示する
		let detectionInterval = CMTime(seconds: 1.0, preferredTimescale: 10)
		avPlayer.addPeriodicTimeObserver(forInterval: detectionInterval, queue: nil, using: { time in
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
        delegate?.nextVc(nextVc)
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
            }
        } else {
            //delete
            RecommendTable.delete(product.productId)
        }
    }

    @IBAction private func onTapLineDetail(_ sender: AnyObject) {
        let line = LineDetailData(lineId: self.product.lineId)
        if line.feature != "" && Bool(line.lineStepFlg as NSNumber) {
            let lineDetailVc = UIViewController.GetViewControllerFromStoryboard("LineDetailViewController", targetClass: LineDetailViewController.self) as! LineDetailViewController
            lineDetailVc.lineId = self.product.lineId
            lineDetailVc.beautySecondId = self.product.beautySecondId
            delegate?.nextVc(lineDetailVc)
        } else {
            let lineListVc = UIViewController.GetViewControllerFromStoryboard("LineListViewController", targetClass: LineListViewController.self) as! LineListViewController
            lineListVc.line = line
            delegate?.nextVc(lineListVc)
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
        delegate?.nextVc(nextVc)
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
            if mIsUtm || mIsUtmEye || mIsWhiteLucentOnMakeUp || mIsWhiteLucentWhiteLucentAllDay || mIsIbuki || mIsWaso {
                showUtmInfo(sender)
            } else {
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
}
