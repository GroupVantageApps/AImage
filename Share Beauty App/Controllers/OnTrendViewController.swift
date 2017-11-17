//
//  OnTrendViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class OnTrendViewController: UIViewController, NavigationControllerAnnotation, CollectionProductViewDelegate {
    @IBOutlet weak var mPagingProductV: PagingProductView!
    private let mScreen = ScreenData(screenId: Const.screenIdOnTrendBeauty)
    fileprivate var mProductList: ProductListData!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    var items: [String: String]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        titleLabel.text = AppItemTable.getNameByItemId(itemId: 7839)
        mPagingProductV.delegate = self
        items = AppItemTable.getItems(screenId: Const.screenIdOnTrendBeauty)
        Utility.log(items)

//        let textImageId = AppItemTable.getMainImageByItemId(itemId: 7812)
    }

    override func viewWillAppear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewWillAppear")
        mProductList = ProductListData(screenId: Const.screenIdOnTrendBeauty)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.text = AppItemTable.getNameByItemId(itemId: 7839)
        viewDidLayoutSubviewsOnce {
            self.view.layoutIfNeeded()
            mPagingProductV.products = mProductList.products
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewDidDisappear")
    }

    func didSelectProduct(_ collectionProductView: CollectionProductView) {
        let productId: Int? = collectionProductView.product?.productId
        if productId == nil {return}
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = productId
        productDetailVc.relationProducts = mProductList.products
        delegate?.nextVc(productDetailVc)
        LogManager.tapProduct(screenCode: mScreen.code, productId: productId!)
    }
}
