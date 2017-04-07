//
//  ProductStepView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/31.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol LifeStyleProductViewDelegate: NSObjectProtocol {
    func didTapProduct(_ product: ProductData?, transitionItemId: String?)
}

class LifeStyleProductView: BaseView {
    @IBOutlet weak private var mLblNumber: UILabel!
    @IBOutlet weak private var mLblExplain: UILabel!
    @IBOutlet weak private var mLblText: UILabel!
    @IBOutlet weak private var mLblBeauty: UILabel!
    @IBOutlet weak private var mLblLine: UILabel!
    @IBOutlet weak private var mLblProduct: UILabel!
    @IBOutlet weak private var mVWhy: UIView!
    @IBOutlet weak private var mVExplain: UIView!
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mBtnProduct: BaseButton!
    @IBOutlet weak private var mBtnRecommend: BaseButton!
    @IBOutlet weak private var mLblWhy: UILabel!
    @IBOutlet weak private var mBtnWhy: BaseButton!
    @IBOutlet weak private var mLblHeader: UILabel!

    @IBOutlet weak private var mAnswerViewTopToTop: NSLayoutConstraint!
    @IBOutlet weak private var mAnswerViewTopToBottom: NSLayoutConstraint!
    @IBOutlet weak private var mContentViewTopToBottom: NSLayoutConstraint!
    @IBOutlet weak private var mThumbnailViewBottom: NSLayoutConstraint!

    weak var delegate: LifeStyleProductViewDelegate?

    @IBInspectable var numberString: String = "" {
        didSet {
            mLblNumber.text = numberString
        }
    }

    @IBInspectable var headerText: String? {
        didSet {
            mLblHeader.text = headerText
        }
    }

    @IBInspectable var answerText: String? {
        didSet {
            mLblText.text = answerText
        }
    }

    @IBInspectable var explainText: String? {
        didSet {
            mLblExplain.text = explainText
        }
    }

    @IBInspectable var whyText: String? {
        didSet {
            mLblWhy.text = whyText
            mBtnWhy.setTitle(whyText, for: UIControlState())
        }
    }

    @IBInspectable var beautyName: String? {
        didSet {
            mLblBeauty.text = beautyName
        }
    }

    @IBInspectable var lineName: String? {
        didSet {
            mLblLine.text = lineName
        }
    }

    @IBInspectable var productName: String? {
        didSet {
            mLblProduct.text = productName
        }
    }

    @IBInspectable var imgProduct: UIImage? {
        didSet {
            mBtnProduct.setImage(imgProduct, for: UIControlState())
        }
    }

    @IBInspectable var isShowAnswerView: Bool = false {
        didSet {
            mVWhy.isHidden = !isShowAnswerView
            mVExplain.isHidden = isShowAnswerView
        }
    }

    @IBInspectable var isShowContentView: Bool = true {
        didSet {
            showContentView()
        }
    }

    var isRecommend: Bool = false {
        didSet {
            mBtnRecommend.isSelected = self.isRecommend
        }
    }

    var isHighlighted: Bool = false {
        didSet {
            if isHighlighted {
                mBtnProduct.setImage(imgProduct?.withRenderingMode(.alwaysTemplate), for: .normal)
                mBtnProduct.imageView?.tintColor = .black
                mBtnProduct.alpha = 0.6
            } else {
                mBtnProduct.setImage(imgProduct, for: .normal)
                mBtnProduct.alpha = 1
            }
        }
    }

    var product: ProductData? {
        didSet {
            print("tintColor: " + (self.mBtnProduct.imageView?.tintColor.description)!)
            self.beautyName = product?.beautyName
            self.lineName = product?.lineName
            self.productName = product?.productName
            self.imgProduct = FileTable.getImage(product?.image)
            self.explainText = product?.feature
            if product != nil {
                isRecommend = Bool(product!.recommend as NSNumber)
            }
        }
    }

    var logScreenId: String = ""
    var logItemId: String = ""
    var transitionItemId: String?

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        mBtnProduct.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }

    override func updateConstraints() {
        print("updateConstraints")
        print("mContentViewTopToBottom.active", mContentViewTopToBottom.isActive)
        print("mThumbnailViewBottom.active", mThumbnailViewBottom.isActive)
        super.updateConstraints()
        print("super.updateConstraints")
        print("mContentViewTopToBottom.active", mContentViewTopToBottom.isActive)
        print("mThumbnailViewBottom.active", mThumbnailViewBottom.isActive)
    }

    override func layoutSubviews() {
        print("layoutSubviews")
        print("mContentViewTopToBottom.active", mContentViewTopToBottom.isActive)
        print("mThumbnailViewBottom.active", mThumbnailViewBottom.isActive)
        super.layoutSubviews()
        print("super.layoutSubviews")
        print("mContentViewTopToBottom.active", mContentViewTopToBottom.isActive)
        print("mThumbnailViewBottom.active", mThumbnailViewBottom.isActive)
        showContentView()
    }

    private func showContentView() {
        mVContent.isHidden = !isShowContentView
        if isShowContentView {
            print("showContentView")
            mThumbnailViewBottom.isActive = false
            mContentViewTopToBottom.isActive = true
        } else {
            print("hideContentView")
            mContentViewTopToBottom.isActive = false
            mThumbnailViewBottom.isActive = true
            print("mContentViewTopToBottom.active", mContentViewTopToBottom.isActive)
            print("mThumbnailViewBottom.active", mThumbnailViewBottom.isActive)
        }
    }

    func showAnswerView(_ show: Bool) {
        if show {
            mAnswerViewTopToBottom.isActive = false
            mAnswerViewTopToTop.isActive = true
        } else {
            mAnswerViewTopToTop.isActive = false
            mAnswerViewTopToBottom.isActive = true
        }

        UIView.animateIgnoreInteraction(
            duration: 0.3,
            animations: {
                self.layoutIfNeeded()
            },
            completion: nil
        )
    }

    @IBAction private func onTapProduct(_ sender: AnyObject) {
        delegate?.didTapProduct(product, transitionItemId: transitionItemId)
    }

    @IBAction private func onTapRecommend(_ sender: AnyObject) {
        let btn = sender as! BaseButton
        btn.isSelected = !btn.isSelected
        if product == nil { return }
        if btn.isSelected {
            if RecommendTable.check(product!.productId) == 0 {
                var value: DBInsertValueRecommend = DBInsertValueRecommend()
                value.product = product!.productId
                value.line = product!.lineId
                value.beautySecond = product!.beautySecondId
                RecommendTable.insert(value)
            }
        } else {
            RecommendTable.delete(product!.productId)
        }
    }

    @IBAction private func onTapClose(_ sender: AnyObject) {
        showAnswerView(false)
    }

    @IBAction private func onTapWhy(_ sender: AnyObject) {
        showAnswerView(true)
        LogManager.tapItem(screenCode: self.logScreenId, itemId: self.logItemId)
    }
}
