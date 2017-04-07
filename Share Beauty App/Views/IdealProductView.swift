//
//  IdealProductView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/26.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol IdealProductViewDelegate: NSObjectProtocol {
    weak var mCollectionView: UICollectionView! { get }
    func didTap(_ sender: IdealProductView)
    func didTapTrouble(_ sender: DataStructTrouble)
    func didTapMirror(_ show: Bool, product: ProductData)
}

class IdealProductView: UICollectionViewCell {
    @IBOutlet weak private var mBtnProduct: BaseButton!
    @IBOutlet weak private var mBtnRecommend: BaseButton!
    @IBOutlet weak private var mLblBeauty: UILabel!
    @IBOutlet weak private var mLblLine: UILabel!
    @IBOutlet weak private var mLblProduct: UILabel!
    @IBOutlet weak private var mImgVDailyCareFirst: UIImageView!
    @IBOutlet weak private var mImgVDailyCareSecond: UIImageView!
    @IBOutlet private var mBtnTroubles: [BaseButton]!
    @IBOutlet weak private var mBtnMirror: BaseButton!
    @IBOutlet weak private var mVBaseProduct: UIView!
    @IBOutlet weak private var mVBaseLine: UIScrollView!
    @IBOutlet weak private var mLblLineDetail: UILabel!
    @IBOutlet weak private var mLblLineTrouble: UILabel!
    @IBOutlet weak private var mLblLineTitle: UILabel!
    @IBOutlet weak private var mConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintTopBottom: NSLayoutConstraint!
    @IBOutlet weak private var mLblLineTitleMarginTop: NSLayoutConstraint!
    @IBOutlet weak private var mLblLineDetailMarginTop: NSLayoutConstraint!
    @IBOutlet weak private var openLineButton: UIButton!
    @IBOutlet weak private var closeLineButton: UIButton!
    @IBOutlet weak private var mImgVNew: UIImageView!
    weak var delegate: IdealProductViewDelegate?
    var ultimuneBackgroundImage: UIImage?
    var lxBackgroundImage: UIImage?
    var indexPath: IndexPath!

    var mTroubles: [DataStructTrouble] = []

    var isBop: Bool = false {
        didSet {
            mBtnMirror.isHidden = !isBop
            mBtnMirror.isSelected = false
            if !isBop {return}
            mBtnTroubles.forEach { (btn) in
                if let trouble = mTroubles[safe: btn.tag] {
                    btn.isHidden = false
                    btn.setTitle(trouble.troubleName, for: UIControlState())
                } else {
                    btn.isHidden = true
                }
            }
        }
    }

    var beautyName: String? {
        didSet {
            mLblBeauty.text = beautyName
        }
    }
    var lineName: String? {
        didSet {
            mLblLine.text = lineName
        }
    }
    var productName: String? {
        didSet {
            mLblProduct.text = productName
        }
    }
    var productImage: UIImage? {
        didSet {
            mBtnProduct.setImage(productImage, for: UIControlState())
        }
    }
    var day: Bool = false {
        didSet {
            applyDailyCareState()
        }
    }
    var night: Bool = false {
        didSet {
            applyDailyCareState()
        }
    }
    var isNew: Bool = false {
        didSet {
            if self.isNew {
                mImgVNew.image = #imageLiteral(resourceName: "icon_new")
            } else {
                mImgVNew.image = nil
            }
        }
    }
    var isRecommend: Bool = false {
        didSet {
            mBtnRecommend.isSelected = self.isRecommend
        }
    }
    var product: ProductData? {
        didSet {
            if product?.idealBeautyType == Const.idealBeautyTypeProduct {
                self.beautyName = product?.beautyName
                self.lineName = product?.lineName
                self.productName = product?.productName
                self.mTroubles = (product?.trables)!
                if product != nil {
                    self.isNew = Bool(product!.newItemFlg as NSNumber)
                    self.day = Bool(product!.day as NSNumber)
                    self.night = Bool(product!.night as NSNumber)
                    if product!.lineId == Const.lineIdBioPerformance {
                        self.isBop = true
                    } else {
                        self.isBop = false
                    }
                    isRecommend = Bool(product!.recommend as NSNumber)
                }
                mVBaseProduct.isHidden = false
                mVBaseLine.isHidden = true
            } else {
                mVBaseProduct.isHidden = true
                mVBaseLine.isHidden = false
                mLblLineTitle.text = product?.lineName
            }
            if isUtm() {
                let bg = getUltimuneBackgroundImage()
                mVBaseProduct.backgroundColor = UIColor(patternImage: bg)
            } else if isLx() {
                let bg = getLxBackgroundImage()
                mVBaseProduct.backgroundColor = UIColor(patternImage: bg)
            } else {
                mVBaseProduct.backgroundColor = .white
            }

            self.mLblLineTrouble.text = product?.lineTarget

            if product?.idealBeautyType == Const.idealBeautyTypeProduct {
                return
            }
            if lineFeatureEmpty() {
                mLblLineTitleMarginTop.constant = 150
                mLblLineDetailMarginTop.constant = 0
                openLineButton.isHidden = true
                closeLineButton.isHidden = true
                mLblLineDetail.text = nil
            } else {
                setLineOpenedWithEffect(product?.lineOpened == true)
            }
        }
    }

    var isLineOpened: Bool = false {
        didSet {
            product?.lineOpened = isLineOpened
        }
    }

    private func lineFeatureEmpty() -> Bool {
        return product?.lineFeature == nil || product!.lineFeature.isEmpty
    }

    func setLineOpenedWithEffect(_ isLineOpened: Bool) {
        self.isLineOpened = isLineOpened
        self.mLblLineTitleMarginTop.constant = isLineOpened ? 10 : 150
        if isLineOpened {
            self.mLblLineDetail.text = product?.lineFeature
            mLblLineDetailMarginTop.constant = 20
            openLineButton.isHidden = true
            closeLineButton.isHidden = false
        } else {
            self.mLblLineDetail.text = nil
            mLblLineDetailMarginTop.constant = 0
            openLineButton.isHidden = false
            closeLineButton.isHidden = true
        }
    }

    override func awakeFromNib() {
        self.contentView.isUserInteractionEnabled = false
        mBtnTroubles.forEach { (btn) in
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.lineBreakMode = .byWordWrapping
            for v in [mVBaseLine, mLblLineTitle] as [Any] {
                (v as AnyObject).addGestureRecognizer(
                    UITapGestureRecognizer(
                        target: self, action: #selector(toggleLineOpen(_:))))
            }
            mLblLineDetail?.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self, action: #selector(closeLine(_:))))
        }
    }

    fileprivate func applyDailyCareState() {
        mImgVDailyCareFirst.image = nil
        mImgVDailyCareSecond.image = nil
        if day {
            mImgVDailyCareFirst.image = UIImage(named: "icon_day")
        }
        if night {
            if mImgVDailyCareFirst.image == nil {
                mImgVDailyCareFirst.image = UIImage(named: "icon_night")
            } else {
                mImgVDailyCareSecond.image = UIImage(named: "icon_night")
            }
        }
    }

    fileprivate func animateModal(_ show: Bool) {
        troubleViewState(show)
        UIView.animateIgnoreInteraction(
            duration: 0.3,
            animations: {
                self.layoutIfNeeded()
            },
            completion: nil
        )
    }

    func troubleViewState(_ show: Bool) {
        if show {
            mConstraintTopBottom.isActive = false
            mConstraintBottom.isActive = true
        } else {
            mConstraintBottom.isActive = false
            mConstraintTopBottom.isActive = true
        }
    }

    @IBAction func onTapProduct(_ sender: AnyObject) {
        self.delegate?.didTap(self)
    }
    @IBAction func onTapRecommend(_ sender: BaseButton) {
        sender.isSelected = !sender.isSelected
        if product == nil { return }
        if sender.isSelected {
            //insert
            if RecommendTable.check(product!.productId) == 0 {
                var value: DBInsertValueRecommend = DBInsertValueRecommend()
                value.product = product!.productId
                value.line = product!.lineId
                value.beautySecond = product!.beautySecondId
                RecommendTable.insert(value)
            }

        } else {
            //delete
            RecommendTable.delete(product!.productId)
        }
    }
    @IBAction func onTapMirror(_ sender: BaseButton) {
        sender.isSelected = !sender.isSelected
        animateModal(sender.isSelected)
        self.delegate?.didTapMirror(sender.isSelected, product: product!)
    }
    @IBAction func onTapClose(_ sender: AnyObject) {
        animateModal(false)
        mBtnMirror.isSelected = false
        self.delegate?.didTapMirror(false, product: product!)
    }
    @IBAction func onTapTroubles(_ sender: BaseButton) {
        self.delegate?.didTapTrouble(mTroubles[sender.tag])
    }

    func toggleLineOpen(_ sender: AnyObject) {
        if lineFeatureEmpty() { return }
        isLineOpened = !isLineOpened
        reloadData()
    }

    @IBAction func openLine(_ sender: UIButton) {
        isLineOpened = true
        reloadData()
    }

    @IBAction func closeLine(_ sender: UIButton) {
        isLineOpened = false
        reloadData()
    }

    private func reloadData() {
        DispatchQueue.main.async {
            self.delegate?.mCollectionView.reloadItems(at: [self.indexPath])
        }
    }

    // 現在のプロダクトがULTIMUNEかどうかをBOOLで返す
    private func isUtm() -> Bool {
        guard let product = self.product else {
            return false
        }
        return Const.lineIdUTM == product.lineId
    }

    private func isLx() -> Bool {
        guard let product = self.product else {
            return false
        }
        return Const.lineIdLX == product.lineId
    }

    // ULTIMUNEの背景画像を返す
    private func getUltimuneBackgroundImage() -> UIImage {
        if let img = ultimuneBackgroundImage {
            return img
        }

        UIGraphicsBeginImageContext(self.frame.size)
        #imageLiteral(resourceName: "background_ultimune").draw(in: self.bounds)
        ultimuneBackgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ultimuneBackgroundImage!
    }

    // LXの背景画像を返す
    private func getLxBackgroundImage() -> UIImage {
        if let img = lxBackgroundImage {
            return img
        }

        UIGraphicsBeginImageContext(self.frame.size)
        #imageLiteral(resourceName: "background_lx").draw(in: self.bounds)
        lxBackgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return lxBackgroundImage!
    }
}
