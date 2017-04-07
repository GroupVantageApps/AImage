//
//  CollectionProductView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol CollectionProductViewDelegate: NSObjectProtocol {
    func didSelectProduct(_ productView: CollectionProductView)
}

class CollectionProductView: UICollectionViewCell {
    @IBOutlet weak private var mBtnProductImg: BaseButton!
    @IBOutlet weak fileprivate var mLblCategory: UILabel!
    @IBOutlet weak fileprivate var mLblLine: UILabel!
    @IBOutlet weak fileprivate var mLblName: UILabel!
    @IBOutlet weak fileprivate var mBtnRecommend: BaseButton!
    @IBOutlet weak fileprivate var mImgVReward: UIImageView!
    @IBOutlet weak fileprivate var mVContent: UIView!

    @IBInspectable var productImage: UIImage? {
        didSet {
            mBtnProductImg.setImage(productImage, for: .normal)
        }
    }
    @IBInspectable var awardImage: UIImage? {
        didSet {
            mImgVReward.image = awardImage
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
    var recommend: Bool = false {
        didSet {
            mBtnRecommend.isSelected = recommend
        }
    }
    var product: ProductData? {
        didSet {
            mVContent.isHidden = (product == nil)
            strCategory = product?.beautyName
            strLine = product?.lineName
            strName = product?.productName
            if product != nil {
                recommend = Bool(product!.recommend as NSNumber)
            }
        }
    }

    weak var delegate: CollectionProductViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }

    override func didMoveToSuperview() {
        mBtnProductImg.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    @IBAction func onTapProduct(_ sender: AnyObject) {
        delegate?.didSelectProduct(self)
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
            }
        } else {
            RecommendTable.delete(product!.productId)
        }
    }
}
