//
//  LifeStyleEighthProductView.swift
//  Share Beauty App
//
//  Created by asiaquest on 2017/07/29.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol LifeStyleEighthProductViewDelegate: NSObjectProtocol {
    func didTapProduct(_ product: ProductData?, transitionItemId: String?)
}

class LifeStyleEighthProductView: BaseView {
    
    weak var delegate: LifeStyleEighthProductViewDelegate?
    
    @IBOutlet weak var mBackImageView: UIImageView!
    @IBOutlet weak var mContentsView: UIView!
    
    @IBOutlet weak var mBeautyLabel: UILabel!
    @IBOutlet weak var mLineNameLabel: UILabel!
    @IBOutlet weak var mProductNameLabel: UILabel!
    @IBOutlet weak var mHeaderLabel: UILabel!
    
    @IBOutlet weak var mRecommendButton: BaseButton!
    @IBOutlet weak var mProductButton: BaseButton!
    
    fileprivate let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeauty)
    
    /// カスタムスタイルの定義。従来のスタイルはnormal
    /// スタイルの変更はproductプロパティに値を設定する前に行う
    enum eStyle: Int {
        case normal = 0
        case beautyOnly
    }
    var style: eStyle = .normal {
        didSet {
            // 特殊フォーマット対応は無かったことになってる？よく分からないので、コメントとして残しておく
            //			switch style {
            //			case .normal:
            //				self.mBeautyLabel.translatesAutoresizingMaskIntoConstraints = false
            //			case .beautyOnly:
            //				self.mBeautyLabel.translatesAutoresizingMaskIntoConstraints = true
            //				self.mBeautyLabel.frame.origin.y = 23.0
            //			}
        }
    }
    
    var headerText: String? {
        get { return self.mHeaderLabel.text }
        set { self.mHeaderLabel.text = newValue }
    }
    
    var beautyName: String? {
        get { return self.mBeautyLabel.text }
        set { self.mBeautyLabel.text = newValue }
    }
    
    var lineName: String? {
        get { return self.mLineNameLabel.text }
        set { self.mLineNameLabel.text = self.style == .beautyOnly ? nil : newValue }
    }
    
    var productName: String? {
        get { return self.mProductNameLabel.text }
        set { self.mProductNameLabel.text = self.style == .beautyOnly ? nil : newValue }
    }
    
    var productImage: UIImage? {
        get { return self.mProductButton.currentImage }
        set { self.mProductButton.setImage(newValue, for: .normal) }
    }
    
    var isRecommend: Bool {
        get { return self.mRecommendButton.isSelected }
        set { self.mRecommendButton.isSelected = newValue }
    }
    
    var product: ProductData? {
        didSet {
            self.beautyName = product?.beautyName
            self.lineName = product?.lineName
            self.productName = product?.productName
            self.productImage = FileTable.getImage(product?.image)
            if product != nil {
                isRecommend = Bool(product!.recommend as NSNumber)
            }
        }
    }
    
    var isHighlighted: Bool = false {
        didSet {
            if isHighlighted {
                self.mProductButton.setImage(self.productImage?.withRenderingMode(.alwaysTemplate), for: .normal)
                self.mProductButton.imageView?.tintColor = .black
                self.mProductButton.alpha = 0.6
            } else {
                self.mProductButton.setImage(self.productImage, for: .normal)
                self.mProductButton.alpha = 1
            }
        }
    }
    
    var isHiddenRecommendButton: Bool {
        get { return self.mRecommendButton.isHidden }
        set { self.mRecommendButton.isHidden = newValue }
    }
    
    var logScreenId: String = ""
    var logItemId: String = ""
    var transitionItemId: String?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.mProductButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        let imageId = AppItemTranslateTable.getEntity(7920).mainImage.first
        self.mBackImageView.image = FileTable.getImage(imageId)
    }
}

// MARK: - UI Events
fileprivate extension LifeStyleEighthProductView {
    @objc @IBAction func handleRecommendButton_Tap(_ sender: Any) {
        if let button = sender as? BaseButton {
            button.isSelected = !button.isSelected
            
            if let product = self.product {
                if button.isSelected {
                    if RecommendTable.check(product.productId) == 0 {
                        var value: DBInsertValueRecommend = DBInsertValueRecommend()
                        value.product = product.productId
                        value.line = product.lineId
                        value.beautySecond = product.beautySecondId
                        RecommendTable.insert(value)
                        LogManager.tapProductReccomend(recommedFlg: 1, productId: product.productId, screenCode: self.mScreen.code)
                    }
                } else {
                    
                    RecommendTable.delete(product.productId)
                    LogManager.tapProductReccomend(recommedFlg: -1, productId: product.productId, screenCode: self.mScreen.code)
                }
            } else {
                
                return
            }
        }
    }
    
    @objc @IBAction func handleProductButton_Tap(_ sender: Any) {
        self.delegate?.didTapProduct(self.product, transitionItemId: self.transitionItemId)
    }
}
