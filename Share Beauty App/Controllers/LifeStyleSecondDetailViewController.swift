//
//  LifeStyleSecondDetailViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/06.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LifeStyleSecondDetailViewController: UIViewController, NavigationControllerAnnotation, LifeStyleProductViewDelegate, UIScrollViewDelegate {
    @IBOutlet private var mLifeStyleProductViews: [LifeStyleProductView]!
    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak private var mVContent: UIView!
	@IBOutlet weak var mTopImageView: UIImageView!


    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeautyB)

    var items: [String: String]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mScrollV.delegate = self
		
		let imageId = AppItemTranslateTable.getEntity(7799).mainImage.first
		self.mTopImageView.image = FileTable.getImage(imageId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let productList = ProductListData(screenId: Const.screenIdLifeStyleBeautyB)
        items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeautyC)
		
		// レイアウト2・1商品対応
		if productList.products.count == 2 {
			self.twoProductsLayout()
		} else if productList.products.count == 1 {
			self.oneProductsLayout()
		} else {
			self.threeProductsLayout()
		}

        for enumerate in productList.products.enumerated() {
            let i = enumerate.offset
            let product = enumerate.element

            guard let lifeStyleProductView = mLifeStyleProductViews[safe: i] else {
                continue
            }
            lifeStyleProductView.delegate = self
            lifeStyleProductView.product = product
            lifeStyleProductView.explainText = items["0" + String(i+1)]

            let transitionItemId = "1" + String(i+1)
            if let json = items[transitionItemId] {
                lifeStyleProductView.isHighlighted = isHighlighted(strJson: json)
                lifeStyleProductView.transitionItemId = transitionItemId
            }
        }
        Utility.log(items)
    }
	
	/// 2商品レイアウト
	fileprivate func twoProductsLayout() {
		for view in self.mLifeStyleProductViews {
			view.removeFromSuperview()
		}
		self.mLifeStyleProductViews.removeAll()
		
		let leftView = LifeStyleProductView()
		let rightView = LifeStyleProductView()
		self.mLifeStyleProductViews.append(leftView)
		self.mLifeStyleProductViews.append(rightView)
		
		self.mVContent.addSubview(leftView)
		self.mVContent.addSubview(rightView)
		
		leftView.translatesAutoresizingMaskIntoConstraints = false
		rightView.translatesAutoresizingMaskIntoConstraints = false
		self.mVContent.addConstraints([
			NSLayoutConstraint(item: leftView, attribute: .leading, relatedBy: .equal, toItem: self.mVContent, attribute: .leading, multiplier: 1.0, constant: 130.0),
			NSLayoutConstraint(item: leftView, attribute: .top, relatedBy: .equal, toItem: self.mVContent, attribute: .top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: leftView, attribute: .bottom, relatedBy: .equal, toItem: self.mVContent, attribute: .bottom, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: rightView, attribute: .trailing, relatedBy: .equal, toItem: self.mVContent, attribute: .trailing, multiplier: 1.0, constant: -130.0),
			NSLayoutConstraint(item: rightView, attribute: .top, relatedBy: .equal, toItem: self.mVContent, attribute: .top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: rightView, attribute: .bottom, relatedBy: .equal, toItem: self.mVContent, attribute: .bottom, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: rightView, attribute: .leadingMargin, relatedBy: .equal, toItem: leftView, attribute: .trailing, multiplier: 1.0, constant: 130.0),
			NSLayoutConstraint(item: rightView, attribute: .width, relatedBy: .equal, toItem: leftView, attribute: .width, multiplier: 1.0, constant: 0.0),
		])
	}
	
	/// 1商品レイアウト
	fileprivate func oneProductsLayout() {
		for view in self.mLifeStyleProductViews {
			view.removeFromSuperview()
		}
		self.mLifeStyleProductViews.removeAll()
		
		let view = LifeStyleProductView()
		self.mLifeStyleProductViews.append(view)
		
		self.mVContent.addSubview(view)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		self.mVContent.addConstraints([
			NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: self.mVContent, attribute: .width, multiplier: 0.33, constant: 0.0),
			NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.mVContent, attribute: .top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.mVContent, attribute: .bottom, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self.mVContent, attribute: .centerX, multiplier: 1.0, constant: 0.0),
		])
	}
	
	/// 3商品レイアウト
	fileprivate func threeProductsLayout() {
		/*
		今後対応予定
		storyboardでデフォルトレイアウトとして登録されているが、1/2商品レイアウトに切り替えた後3商品レイアウトに戻りたいケースがある(setting>waso表示ON)
		現状ではviewControllerを再生成するまで3商品レイアウトに戻れないため、storyboardの制約をそのままここにコード化する
		*/
	}

    private func isHighlighted (strJson: String) -> Bool {
        let transitionData = Utility.parseJson(strJson)

        if let shadowfilter = transitionData?["shadowfilter"].string {
            return shadowfilter == "1"
        } else {
            return false
        }
    }

    private func getTransitionFilterInfo(strJson: String) -> (productIds: String?, beautyIds: String?, lineIds: String?)? {
        let transitionData = Utility.parseJson(strJson)

        let productIds = transitionData?["productId"].string
        let beautyIds = transitionData?["beautyId"].string
        let lineIds = transitionData?["lineId"].string

        if productIds == nil && beautyIds == nil && lineIds == nil {
            return nil
        } else {
            return (productIds, beautyIds, lineIds)
        }
    }

    func didTapProduct(_ product: ProductData?, transitionItemId: String?) {
        if transitionItemId != nil,
            let json = items[transitionItemId!],
            let filterInfo = self.getTransitionFilterInfo(strJson: json) {

            let products = ProductListData(productIds: filterInfo.productIds,
                                           beautyIds: filterInfo.beautyIds,
                                           lineIds: filterInfo.lineIds).products
            let productListVc = UIViewController.GetViewControllerFromStoryboard(targetClass: ProductListViewController.self) as! ProductListViewController
            productListVc.products = products
            delegate?.nextVc(productListVc)
        } else {
            let productDetailVc = UIViewController.GetViewControllerFromStoryboard(targetClass: ProductDetailViewController.self) as! ProductDetailViewController
            productDetailVc.productId = product!.productId
            let productList = ProductListData(productId:product!.productId, screenId: Const.screenIdLifeStyleBeautyB)
            productDetailVc.relationProducts = productList.products
            delegate?.nextVc(productDetailVc)
        }

        LogManager.tapProduct(screenCode: mScreen.code, productId: product!.productId)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
}
