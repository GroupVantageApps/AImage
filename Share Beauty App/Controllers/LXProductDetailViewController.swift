//
//  ProductDetailViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
// sharedBeauty(白)から遷移する用のLX詳細画面

import UIKit
import AVFoundation
import AVKit
import SwiftyJSON

class LXProductDetailViewController: UIViewController, NavigationControllerAnnotation, LXCategoryButtonDelegate, UtmFeaturesViewDelegate, TroubleViewDelegate, LXTroubleSelectViewDelegate, MoviePlayerViewDelegate, IngredientSkinGraphViewDelegate, LXIngredientViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak private var mImgVProduct: UIImageView!
    @IBOutlet weak private var mImgVFirstDailyCare: UIImageView!
    @IBOutlet weak private var mImgVSecondDailyCare: UIImageView!

    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mVBaseIbukiBtn: UIView!
    @IBOutlet weak private var mVBaseFeaturesView: UIView!
    @IBOutlet weak private var mRelationScrollV: UIScrollView!
    @IBOutlet weak private var mVScrollContent: UIView!

    @IBOutlet weak private var mVSkinConcern: LXProductDetailSkinConcernView!
    @IBOutlet weak private var mTroubleSelectView: LXTroubleSelectView!
    @IBOutlet weak private var mColorballCollectionView: ColorballCollectionView!
    @IBOutlet weak private var mVRelationProductBase: UIView!
    @IBOutlet weak private var mVCategoryImage: UIView!
    @IBOutlet weak private var mVCategoryImageBase: UIView!
    @IBOutlet weak private var mTroubleView: TroubleView!
    @IBOutlet weak private var mVColorBall: UIView!

    @IBOutlet weak private var mCategoryButtonFeatures: LXCategoryButton!
    @IBOutlet weak private var mCategoryButtonTechnologies: LXCategoryButton!
    @IBOutlet weak private var mCategoryButtonHowToUse: LXCategoryButton!
    @IBOutlet weak private var mCategoryButtonEfficacy: LXCategoryButton!
    @IBOutlet weak private var mCategoryButtonDefend: LXCategoryButton!
    @IBOutlet weak private var mBtnMovie: UIButton!
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

    @IBOutlet weak private var mImageBackgroundDot: UIImageView!        //17SS移植用 水玉背景画像

    @IBOutlet weak private var mTransitionView: LXProductDetailTransitionView!

    @IBOutlet weak private var mScrollVPinch: UIScrollView!
    @IBOutlet weak private var mVMain: UIView!

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

    var product: ProductDetailData!
    var relationProducts: [ProductData] = []
    private var mItems: [String: String]!
    private var mItemsSideMenu: [String: String]!
    private var mItemsCommon: [String: String]!

    private var mBtnCurrentSelect: LXCategoryButton?
    private var mVCurrentSelect: UIView?

    private var mUtmFeaturesView: UtmFeaturesView!
    private var mIbukiFeaturesView: IbukiFeaturesView!
    private var mWhiteLucentAllDayFeaturesView: WhiteLucentFeaturesView!
    private var mSuncareFeaturesView: SunCareFeaturesView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }
    private static let outAppInfos = [Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    override func viewDidLoad() {
        super.viewDidLoad()

        product = ProductDetailData(productId: productId)
        self.checkSpecialCase()
        print("product.image:", productId)

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

        if ((mItems["08"]?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {    
            
            mItemFeature.text = mItems["08"]
            mItemHowToUse.text = mItems["09"]
            mItemDailyCare.text = mItems["11"]
            
            mLblBeautyName.text = product.beautyName
            mLblLineName.text = product.lineName
            mLblProductName.text = product.productName
            
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = 18
            style.maximumLineHeight = 18
            
            let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size:15)   
            let mLblFeatureString: NSMutableAttributedString = NSMutableAttributedString(string: product.feature, attributes: [NSFontAttributeName: font!])
            mLblFeatureString.setAttributes([NSFontAttributeName: font!,NSParagraphStyleAttributeName : style], range: NSRange(location:0,length: product.feature.count))
            mLblFeature.attributedText = mLblFeatureString
            
            let mLblHowToUseString: NSMutableAttributedString = NSMutableAttributedString(string: product.howToUse, attributes: [NSFontAttributeName: font!])
            mLblHowToUseString.setAttributes([NSFontAttributeName: font!,NSParagraphStyleAttributeName : style], range: NSRange(location:0,length: product.howToUse.count))
            mLblHowToUse.attributedText = mLblHowToUseString
            
            let mLblUnitString: NSMutableAttributedString = NSMutableAttributedString(string: product.unitName, attributes: [NSFontAttributeName: font!])
            mLblUnitString.setAttributes([NSFontAttributeName: font!,NSParagraphStyleAttributeName : style], range: NSRange(location:0,length: product.unitName.count))
            mLblUnit.attributedText = mLblUnitString
            
        } else {   
            let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size:15)    
            let mItemFeatureString: NSMutableAttributedString = NSMutableAttributedString(string: mItems["08"]!, attributes: [NSFontAttributeName:font!])
            mItemFeatureString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (mItems["08"]?.count)!))
            mItemFeature.attributedText = mItemFeatureString
            
            let mItemHowToUseString: NSMutableAttributedString = NSMutableAttributedString(string: mItems["09"]!, attributes: [NSFontAttributeName:font!])
            mItemHowToUseString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (mItems["09"]?.count)!))
            mItemHowToUse.attributedText = mItemHowToUseString
            
            let mItemDailyCareString: NSMutableAttributedString = NSMutableAttributedString(string: mItems["11"]!, attributes: [NSFontAttributeName:font!])
            mItemDailyCareString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (mItems["11"]?.count)!))
            mItemDailyCare.attributedText = mItemDailyCareString
            
            
            
            let mLblBeautyNameString: NSMutableAttributedString = NSMutableAttributedString(string: product.beautyName, attributes: [NSFontAttributeName:font!])
            mLblBeautyNameString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: product.beautyName.count))
            mLblBeautyName.attributedText = mLblBeautyNameString
            
            mLblLineName.text = product.lineName
            mLblProductName.text = product.productName
            
            let style = NSMutableParagraphStyle()
            style.minimumLineHeight = 18
            style.maximumLineHeight = 18
            
            let mLblFeatureString: NSMutableAttributedString = NSMutableAttributedString(string: product.feature, attributes: [NSFontAttributeName: font!])
            mLblFeatureString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1,NSParagraphStyleAttributeName : style], range: NSRange(location:0,length: product.feature.count))
            mLblFeature.attributedText = mLblFeatureString
            
            let mLblHowToUseString: NSMutableAttributedString = NSMutableAttributedString(string: product.howToUse, attributes: [NSFontAttributeName: font!])
            mLblHowToUseString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1,NSParagraphStyleAttributeName : style], range: NSRange(location:0,length: product.howToUse.count))
            mLblHowToUse.attributedText = mLblHowToUseString
            
            let mLblUnitString: NSMutableAttributedString = NSMutableAttributedString(string: product.unitName, attributes: [NSFontAttributeName: font!])
            mLblUnitString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1,NSParagraphStyleAttributeName : style], range: NSRange(location:0,length: product.unitName.count))
            mLblUnit.attributedText = mLblUnitString
            
        }
        
        mCategoryButtonFeatures.title = mItemsCommon["01"]
        mCategoryButtonHowToUse.title = mItemsCommon["02"]
        mCategoryButtonEfficacy.title = mItemsCommon["03"]
        mCategoryButtonTechnologies.title = "Technology"
        mCategoryButtonDefend.title = "Skingencel Enmei"
        mTransitionView.setLikeItText(text: mItemsSideMenu["09"])
        
        mImgVProduct.image = FileTable.getImage(product.image)
        
        
        if productId == 516 || productId == 517 || productId == 520 || productId == 521 || productId == 519 || productId == 522 || productId == 523 || productId == 524 || productId == 525 {
            mCategoryButtonTechnologies.enabled = true
            mCategoryButtonDefend.enabled = true
        } else {
            mCategoryButtonTechnologies.enabled = (product.technologyImage.count != 0)
            mCategoryButtonDefend.enabled = mIsUtm
        }
        if productId == 516 || productId == 517 || productId == 519 || productId == 522 || productId == 523 {
            mCategoryButtonEfficacy.enabled = true
        } else {
            mCategoryButtonEfficacy.enabled = (product.effectImage.count != 0)
        }
        if productId == 516 || productId == 517 || productId == 520 || productId == 521 || productId == 522{
            self.mBtnMovie.isEnabled = true
        } else {
            self.mBtnMovie.isEnabled = false
        }
        if productId == 39  || productId == 521{
            mCategoryButtonEfficacy.enabled = false
        }
        
        if productId == 522 || productId == 523 {
            mCategoryButtonHowToUse.enabled = true
        } else {
            mCategoryButtonHowToUse.enabled = (product.usageImage.count != 0)
        }
        
        mImgVProduct.image = FileTable.getImage(product.image)

        if Bool(product.day as NSNumber) {
            mImgVFirstDailyCare.image = UIImage(named: "lx_icon_day")!
        }
        if Bool(product.night as NSNumber) {
            let imgNight = UIImage(named: "lx_icon_night")!
            if mImgVFirstDailyCare.image == nil {
                mImgVFirstDailyCare.image = imgNight
            } else {
                mImgVSecondDailyCare.image = imgNight
            }
        }
//        mBtnMovie.isEnabled = (product.movie != 0)
//        mBtnBrush.isEnabled = Bool(product.brush as NSNumber)
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
        }
        print(product.troubles)
        
        mVSkinConcern.troubles = product.troubles
        mTroubleSelectView.troubles = product.troubles
        
        mItemSkinConcern.text = AppItemTable.getNameByItemId(itemId: 54)
        mItemColorVariation.text = AppItemTable.getNameByItemId(itemId: 87)
        
        mVBaseIbukiBtn.isHidden = !mIsMakeUp

        //#804 スライド5.6の背景の水玉表示
        if self.product.productId == 498 || self.product.productId == 499 {
            mImageBackgroundDot.isHidden = false
        } else {
            mImageBackgroundDot.isHidden = true
        }

        var datas = [LXProductDetailTransitionData]()
        datas.append(LXProductDetailTransitionData(title: product.lineName, selector: #selector(self.onTapLineDetail(_:))))
        if Utility.getLifeStyleScreenIds(productId: self.productId) != nil {
            datas.append(LXProductDetailTransitionData(title: "Life Style Beauty", selector: #selector(self.onTapLifeStyleBeauty(_:))))
        }
        if Utility.isIconicProduct(productId: self.productId) {
            datas.append(LXProductDetailTransitionData(title: "Iconic Beauty", selector: #selector(self.onTapIconicBeauty(_:))))
        }
        if Utility.isOnTrendProduct(productId: self.productId) {
            datas.append(LXProductDetailTransitionData(title: "On Trend Beauty", selector: #selector(self.onTapOnTrendBeauty(_:))))
        }

        mTransitionView.setProductDetailTransitionData(datas, target: self)
        mTransitionView.cellHeight = 34
        mTransitionView.setLikeItSelector(#selector(self.onTapRecommend(_:)), target: self)

        mScrollVPinch.delegate = self
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
    }

    override func viewDidAppear(_ animated: Bool) {
        if mIsUtm || mIsUtmEye {
            mUtmFeaturesView.showAnimation()
        }
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

    private func checkSpecialCase() {
        mIsUtm = Const.productIdUtm == self.productId
        mIsUtmEye = Const.productIdUtmEye == self.productId
        mIsIbuki = Const.productIdIbuki == self.productId
        mIsWhiteLucentOnMakeUp = Const.productIdWhiteLucentOnMakeUp == self.productId
        mIsWhiteLucentWhiteLucentAllDay = Const.productIdWhiteLucentAllDay == self.productId
        mIsSunCareBBSports = Const.productIdSunCareBBSports == self.productId
        mIsSunCarePerfectUv = Const.productIdSunCarePerfectUv == self.productId
        mIsMakeUp = Const.productIdMakeUp == self.productId
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

    private func showUtmInfo(_ sender: LXCategoryButton) {
        if sender === mCategoryButtonFeatures {
            mVContent.isHidden = true
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
            let utmEfficacyView = UtmEfficacyView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            utmEfficacyView?.isUtm = mIsUtm
            utmEfficacyView?.isUtmEye = mIsUtmEye
            utmEfficacyView?.isWhiteLucent = mIsWhiteLucentOnMakeUp
            utmEfficacyView?.isAllDayBright = mIsWhiteLucentWhiteLucentAllDay
            utmEfficacyView?.isIBUKI = mIsIbuki
            mVContent.addSubview(utmEfficacyView!)
            utmEfficacyView?.showEfficacyDetail()
            mVCurrentSelect = utmEfficacyView
        } else if sender === mCategoryButtonDefend {
            let utmDefendView = UtmDefendView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mVContent.size))
            mVContent.addSubview(utmDefendView!)
            mVCurrentSelect = utmDefendView
        }
    }

    private func showInfo(_ sender: LXCategoryButton) {
        if sender === mCategoryButtonFeatures {
            mVCategoryImage.isHidden = true
            return
        }
        mCategoryButtonFeatures.selected = true
        sender.selected = false
        sender.enabled = true
        mBtnCurrentSelect = mCategoryButtonFeatures

        mVCategoryImage.isHidden = false
        if sender === mCategoryButtonTechnologies {
            mVCategoryImage.isHidden = true
            let technologyV: LXProductTechnologyView = UINib(nibName: "LXProductTechnologyView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductTechnologyView
            technologyV.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
            technologyV.setUI(productId: productId)
            technologyV.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
            self.view.addSubview(technologyV)
        } else if sender === mCategoryButtonHowToUse {
            mVCategoryImage.isHidden = true
            let popup: LXProductHowToUseView = UINib(nibName: "LXProductHowToUseView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductHowToUseView
            popup.setUI(productId: productId)
            popup.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
            popup.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
            self.view.addSubview(popup)
            
        } else if sender === mCategoryButtonEfficacy {

            mVCategoryImage.isHidden = true
            let popup: LXProductEfficacyView = UINib(nibName: "LXProductEfficacyView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductEfficacyView
            popup.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
            popup.setUI(productId: productId)
            popup.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
            self.view.addSubview(popup)
            if productId == 519 {
                popup.startAnimation(tag: 202)
            } else if productId == 522  {
                popup.startAnimation(tag: 205)
            }
        } else if sender === mCategoryButtonDefend {
            mVCategoryImage.isHidden = true
            let popup: LXIngredientView = UINib(nibName: "LXIngredientView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXIngredientView
            popup.delegate = self
            popup.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
            popup.setAction()
            popup.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
            self.view.addSubview(popup)
        }
    }

    private func showMovie(movieId: Int) {
        
        let movieName = String(format: "%d_17AWLX", productId)
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/%@.mp4",movieName))
        let videoURL = NSURL(fileURLWithPath: path)
        let avPlayer: AVPlayer = AVPlayer(url: videoURL as URL)
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        self.present(avPlayerVc, animated: true, completion: {
            // dismissを監視するため、オブザーバ登録する
//            avPlayerVc.addObserver(self, forKeyPath: #keyPath(UIViewController.view.frame), options: [.old, .new], context: nil)
        })
        avPlayer.play()
        

    }

    @objc private func onTapRelationProduct(_ sender: BaseButton) {
        let relationProduct = ProductDetailData(productId: sender.tag)
        if Const.lineIdLX == relationProduct.lineId {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LXProductDetailViewController", targetClass: LXProductDetailViewController.self) as! LXProductDetailViewController
            nextVc.productId = relationProduct.productId
            nextVc.relationProducts = self.relationProducts
            self.delegate?.nextVc(nextVc)
        } else {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
            nextVc.productId = relationProduct.productId
            nextVc.relationProducts = self.relationProducts
            self.delegate?.nextVc(nextVc)
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
        let nextVc = UIViewController.GetViewControllerFromStoryboard("LXProductViewController", targetClass: LXProductViewController.self) as! LXProductViewController
        delegate?.nextVc(nextVc)
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
    func didTap(_ sender: LXCategoryButton) {
        if sender === mBtnCurrentSelect {
            return
        }
        mBtnCurrentSelect?.selected = false
        mBtnCurrentSelect = sender
        mBtnCurrentSelect?.selected = true

        if mIsUtm || mIsUtmEye || mIsWhiteLucentOnMakeUp || mIsWhiteLucentWhiteLucentAllDay || mIsIbuki {
            showUtmInfo(sender)
        } else {
            showInfo(sender)
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
        let moviePlay = mTroubleView.viewWithTag(50)
        moviePlay?.removeFromSuperview()
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
    func didTapshowSkinGraph() {
        if let gView = self.view.viewWithTag(150) {
            gView.removeFromSuperview()
        }
        let skingraph: IngredientSkinGraphView = UINib(nibName: "IngredientSkinGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! IngredientSkinGraphView
        skingraph.frame = CGRect(x: 0,y: 0,width: 700,height: 630)
        skingraph.setUI()
        skingraph.delegate = self
        skingraph.tag = 150
        skingraph.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(skingraph)
    }

    func movieAct(){

        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/lx_ingredient.mp4"))
        let videoURL = NSURL(fileURLWithPath: path)
        let avPlayer: AVPlayer = AVPlayer(url: videoURL as URL)
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        self.present(avPlayerVc, animated: true, completion: {
            // dismissを監視するため、オブザーバ登録する
//            avPlayerVc.addObserver(self, forKeyPath: #keyPath(UIViewController.view.frame), options: [.old, .new], context: nil)
        })
        avPlayer.play()
    }
    func ingredientMoviePlay(index: Int){
                
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/3e%d.mp4",index))
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
        let moviePlay = mTroubleView.viewWithTag(50)
        moviePlay?.removeFromSuperview()
    }
}
