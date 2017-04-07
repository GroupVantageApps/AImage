//
//  LineStepView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/07.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol ProductViewDelegate: NSObjectProtocol {
    func didTapProduct(_ product: ProductData)
}

class ProductView: UICollectionViewCell {
    @IBOutlet weak private var mBtnProduct: BaseButton!
    @IBOutlet weak private var mLblName: UILabel!
    @IBOutlet weak private var mLblCategory: UILabel!
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mImgVDailyCareFirst: UIImageView!
    @IBOutlet weak private var mImgVDailyCareSecond: UIImageView!

    @IBOutlet weak private var mConstraintBottomToTop: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintBottom: NSLayoutConstraint!

    var product: ProductData! {
        didSet {
            let image = FileTable.getImage(self.product.image)
            let icon_day = UIImage(named: "icon_day")
            let icon_night = UIImage(named: "icon_night")

            self.mBtnProduct.setImage(image, for: .normal)
            self.mLblName.text = self.product.productName
            self.mLblCategory.text = self.product.beautyName

            self.mImgVDailyCareFirst.image = nil
            self.mImgVDailyCareSecond.image = nil

            if Bool(NSNumber(value: self.product.day)) {
                self.mImgVDailyCareFirst.image = icon_day
            }
            if Bool(NSNumber(value: self.product.night)) {
                if self.mImgVDailyCareFirst.image == nil {
                    self.mImgVDailyCareFirst.image = icon_night
                } else {
                    self.mImgVDailyCareSecond.image = icon_night
                }
            }
        }
    }

    weak var delegate: ProductViewDelegate?
    @IBInspectable var isShowCategory: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        showCategory(isShowCategory)
    }

    private func showCategory(_ show: Bool) {

        mLblCategory.isHidden = !show
        if show {
            mConstraintBottom.isActive = false
            mConstraintBottomToTop.isActive = true
        } else {
            mConstraintBottomToTop.isActive = false
            mConstraintBottom.isActive = true
        }
    }

    @IBAction fileprivate func onTapProduct(_ sender: AnyObject) {
        delegate?.didTapProduct(product)
    }
}
