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
    @IBOutlet weak private var mLblLine: UILabel!
    @IBOutlet weak private var mLblProduct: UILabel!
    @IBOutlet weak private var mBtnProduct: BaseButton!
    @IBOutlet weak private var mBtnRecommend: BaseButton!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    weak var delegate: LifeStyleProductViewDelegate?
    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeauty)
	
    let discroptionList = [
        553:7932,
        554:7933, //t-hirai 参照修正
        101:0,
        455:0,
        470:7938,
        500:7939,
        551:7940,
        545:7945,
        549:7946,
        498:7947,
    ]
	// カスタムスタイルの定義。従来のスタイルはnormal
	// スタイルの変更はproductプロパティに値を設定する前に行う
	enum eStyle: Int {
		case normal = 0
		case beautyOnly
	}
	var style: eStyle = .normal

    @IBInspectable var numberString: String = "" {
        didSet {
            mLblNumber.text = numberString
        }
    }

    @IBInspectable var headerText: String? {
        didSet {
//            mLblHeader.text = headerText
            print("headerText")
            print(headerText)
        }
    }

    @IBInspectable var answerText: String? {
        didSet {
            print("answerText")
            print(answerText)
        }
    }

    @IBInspectable var explainText: String? {
        didSet {
            print("explainText")
            print(explainText)
        }
    }

    @IBInspectable var whyText: String? {
        didSet {
            print("wwwwhy")
            print(whyText)
        }
    }

    @IBInspectable var beautyName: String? {
        didSet {
            
        }
    }

    @IBInspectable var lineName: String? {
        didSet {
			mLblLine.text = self.style == .beautyOnly ? nil : lineName
            let color = UIColor(hex: "C8102E", alpha: 1.0)
            let underline = NSAttributedString(string: lineName!, attributes:
                [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                 NSUnderlineColorAttributeName: color
                ])
            mLblLine.attributedText = underline
            mLblLine.sizeToFit()
            
        }
    }

    @IBInspectable var productName: String? {
        didSet {
            
//            mLblProduct.text = self.style == .beautyOnly ? nil : productName
            mLblProduct.text = productName
            let color = UIColor(hex: "C8102E", alpha: 1.0)
            let underline = NSAttributedString(string: productName!, attributes:
                [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                 NSUnderlineColorAttributeName: color
                ])
            mLblProduct.attributedText = underline
        }
    }

    @IBInspectable var imgProduct: UIImage? {
        didSet {
            mBtnProduct.setImage(imgProduct, for: UIControlState())
        }
    }

    @IBInspectable var isShowAnswerView: Bool = false {
        didSet {
            
        }
    }

    @IBInspectable var isShowContentView: Bool = true {
        didSet {
            
        }
    }

    var isRecommend: Bool = false {
        didSet {
            mBtnRecommend.isSelected = self.isRecommend
        }
    }
	
	var isHiddenRecommendButton: Bool {
		get { return self.mBtnRecommend.isHidden }
		set {
			self.mBtnRecommend.isHidden = newValue
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
            self.discriptionLabel.text = AppItemTable.getNameByItemId(itemId: discroptionList[(product?.productId)!]!)
            print(self.discriptionLabel.text)
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
        super.updateConstraints()
        print("super.updateConstraints")
    }

    override func layoutSubviews() {
        print("layoutSubviews")
        super.layoutSubviews()
    }

    func showAnswerView(_ show: Bool) {
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
                LogManager.tapProductReccomend(recommedFlg: 1, productId: product!.productId, screenCode: self.mScreen.code)
            }
        } else {
            RecommendTable.delete(product!.productId)
            LogManager.tapProductReccomend(recommedFlg: -1, productId: product!.productId, screenCode: self.mScreen.code)
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
