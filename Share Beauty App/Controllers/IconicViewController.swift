//
//  IconicViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class IconicViewController: UIViewController, NavigationControllerAnnotation, CollectionProductViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak fileprivate var mPagingProductV: PagingProductView!
    private let mScreen = ScreenData(screenId: Const.screenIdIconicBeauty)
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    private var mProductList: ProductListData!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        mPagingProductV.delegate = self
        titleLabel.text = AppItemTable.getNameByItemId(itemId: 7840)
        if LanguageConfigure.languageId == 43 {  // 日本語時のフォントサイズ調整
            titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewWillAppear")
//        createVideo()
        mProductList = ProductListData(screenId: Const.screenIdIconicBeauty)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsOnce {
            self.view.layoutIfNeeded()
            mPagingProductV.products = mProductList.products
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("IdealFirstSelectViewController.viewDidDisappear")
    }

    func didSelectProduct(_ targetCollectionProductView: CollectionProductView) {
        let productId: Int? = targetCollectionProductView.product?.productId
        if productId == nil {return}
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = productId
        productDetailVc.relationProducts = mProductList.products
        delegate?.nextVc(productDetailVc)

        LogManager.tapProduct(screenCode: mScreen.code, productId: productId!)
    }
}
