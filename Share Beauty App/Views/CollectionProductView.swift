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
    @IBOutlet weak fileprivate var mLblBlack: UILabel!
    @IBOutlet weak fileprivate var mBtnRecommend: BaseButton!
    @IBOutlet weak fileprivate var mImgVReward: UIImageView!
    @IBOutlet weak fileprivate var mVContent: UIView!
    @IBOutlet weak var dayImageView: UIImageView!
    @IBOutlet weak var nightImageView: UIImageView!
    
    private let mScreen = ScreenData(screenId: Const.screenIdProductList)

    @IBInspectable var productImage: UIImage? {
        didSet {
            mBtnProductImg.setImage(productImage, for: .normal)
            mBtnProductImg.imageView?.contentMode = .scaleAspectFit
            mBtnProductImg.contentHorizontalAlignment = .fill
            mBtnProductImg.contentVerticalAlignment = .fill
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
            if let name = strLine {
                mLblLine.text = name
                let color = UIColor(hex: "C8102E", alpha: 1.0)
                let underline = NSAttributedString(string: name, attributes:
                    [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                     NSUnderlineColorAttributeName: color
                    ])
                mLblLine.attributedText = underline
                mLblLine.sizeToFit()
            }
        }
    }
    @IBInspectable var strName: String? {
        didSet {
            if let name = strName {
                mLblBlack.text = name
                let color = UIColor(hex: "C8102E", alpha: 1.0)
                let underline = NSAttributedString(string: name, attributes:
                    [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                     NSUnderlineColorAttributeName: color
                    ])
                mLblBlack.attributedText = underline
                
                mLblBlack.sizeToFit()
            }
        }
    }
    var recommend: Bool = false {
        didSet {
            mBtnRecommend.isSelected = recommend
        }
    }
    var product: ProductData! {
        didSet {
            mVContent.isHidden = (product == nil)
            strCategory = product?.beautyName
            strLine = product?.lineName
            strName = product?.productName
            
            let icon_day = UIImage(named: "icon_day")
            let icon_night = UIImage(named: "icon_night")

            if product != nil {
                recommend = Bool(product!.recommend as NSNumber)
            } else {
                return;
            }
            if Bool(NSNumber(value: product.day)) {
                self.dayImageView.image = icon_day
            }
            if Bool(NSNumber(value: self.product.night)) {
                if self.dayImageView.image == nil {
                    self.dayImageView.image = icon_night
                } else {
                    self.dayImageView.image = icon_night
                }
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
            LogManager.tapProductReccomend(recommedFlg: 1, productId: product!.productId, screenCode: self.mScreen.code)
        } else {
            RecommendTable.delete(product!.productId)
            LogManager.tapProductReccomend(recommedFlg: -1, productId: product!.productId, screenCode: self.mScreen.code)
        }
    }
}
