//
//  RecommendProductView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol RecommendProductViewDelegate: NSObjectProtocol {
    func didSelect(product: ProductData)
}

class RecommendProductView: UICollectionViewCell {
    @IBOutlet weak fileprivate var mBtnProductImg: BaseButton!
    @IBOutlet weak fileprivate var mLblCategory: UILabel!
    @IBOutlet weak fileprivate var mLblLine: UILabel!
    @IBOutlet weak fileprivate var mLblName: UILabel!
    @IBOutlet weak fileprivate var mBtnRecommend: BaseButton!
    @IBOutlet weak fileprivate var mImgVReward: UIImageView!
    @IBOutlet weak fileprivate var mVProtect: UIView!
    private let mScreen = ScreenData(screenId: Const.screenIdRecommend)
    
    @IBInspectable var productImage: UIImage? {
        didSet {
            mBtnProductImg.setImage(productImage, for: UIControl.State())
        }
    }
    @IBInspectable var strCategory: String? {
        didSet {
            mLblCategory.text = strCategory
        }
    }

    @IBInspectable var strLine: String? {
        didSet {
            mLblLine.text = strLine
        }
    }
    @IBInspectable var strName: String? {
        didSet {
            mLblName.text = strName
        }
    }
    var reward: Bool = false {
        didSet {
            mImgVReward.isHidden = !reward
        }
    }
    var recommend: Bool = false {
        didSet {
            mBtnRecommend.isSelected = recommend
        }
    }
    var product: ProductData? {
        didSet {
            mVProtect.isHidden = true
            strCategory = product?.beautyName
            strLine = product?.lineName
            strName = product?.productName
            if product != nil {
                reward = Bool(truncating: product!.reward as NSNumber)
                recommend = Bool(truncating: product!.recommend as NSNumber)
            }
            productImage = FileTable.getImage(product?.image)
        }
    }

    weak var delegate: RecommendProductViewDelegate?

    override func didMoveToSuperview() {
        mBtnProductImg.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }
    @IBAction func onTapProduct(_ sender: AnyObject) {
        if product != nil {
            delegate?.didSelect(product: product!)
        }
    }
    @IBAction func onTapRecommend(_ sender: BaseButton) {
        sender.isSelected = !sender.isSelected
        if product == nil { return }
        if sender.isSelected {
            if RecommendTable.check(product!.productId) == 0 {
                var value: DBInsertValueRecommend = DBInsertValueRecommend()
                value.product = product!.productId
                value.line = product!.lineId
                value.beautySecond = product!.beautySecondId
                RecommendTable.insert(value)
                LogManager.tapProductReccomend(recommedFlg: 1, productId: product!.productId, screenCode: self.mScreen.code)
            }
        } else {
            RecommendTable.delete(product!.productId)
            LogManager.tapProductReccomend(recommedFlg: -1, productId: product!.productId, screenCode: self.mScreen.code)
        }
    }
}
