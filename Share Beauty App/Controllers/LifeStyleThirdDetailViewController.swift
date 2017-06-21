//
//  LifeStyleThirdDetailViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/06.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LifeStyleThirdDetailViewController: UIViewController, NavigationControllerAnnotation, LifeStyleThirdProductViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak private var mLifeStyleProductViewTips: LifeStyleThirdProductView!
    @IBOutlet private var mLifeStyleProductViews: [LifeStyleThirdProductView]!
    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak private var mVContent: UIView!
	@IBOutlet weak var mTopImageView: UIImageView!

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeautyC)

    var items: [String: String]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mScrollV.delegate = self
		
		let imageId = AppItemTranslateTable.getEntity(7800).mainImage.first
		self.mTopImageView.image = FileTable.getImage(imageId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let productList = ProductListData(screenId: Const.screenIdLifeStyleBeautyC)

        items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeautyB)
        mLifeStyleProductViewTips.delegate = self
        mLifeStyleProductViewTips.beautyName = items["01"]
        mLifeStyleProductViewTips.lineName = items["02"]
		mLifeStyleProductViewTips.productName = "";
		mLifeStyleProductViewTips.productImage = #imageLiteral(resourceName: "beauty_tips_img")

        for enumerated in productList.products.enumerated() {
            let i = enumerated.offset
            let product = enumerated.element

            guard let lifeStyleProductView = mLifeStyleProductViews[safe: i] else {
                continue
            }

            lifeStyleProductView.delegate = self
            lifeStyleProductView.product = product

            let transitionItemId = "1" + String(i+1)
            if let json = items[transitionItemId] {
                lifeStyleProductView.isHighlighted = isHighlighted(strJson: json)
                lifeStyleProductView.transitionItemId = transitionItemId
            }
        }
        Utility.log(items)
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
        if product == nil {
            let tipVc = UIViewController.GetViewControllerFromStoryboard("TipsViewController", targetClass: TipsViewController.self) as! TipsViewController
            delegate?.nextVc(tipVc)

            LogManager.tapItem(screenCode: mScreen.code, itemId: "01")

        } else {
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
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
}
