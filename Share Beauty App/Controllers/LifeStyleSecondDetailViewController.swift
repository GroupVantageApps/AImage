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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let productList = ProductListData(screenId: Const.screenIdLifeStyleBeautyB)
        items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeautyC)

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

        LogManager.tapLifeStyleProduct(screenCode: mScreen.code, productId: product!.productId)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
}
