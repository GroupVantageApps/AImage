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

    @IBOutlet weak fileprivate var mPagingProductV: PagingProductView!
    private let mScreen = ScreenData(screenId: Const.screenIdIconicBeauty)
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    private var mProductList: ProductListData!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = "ICONIC BEAUTY"// mScreen.name
    }

    override func viewDidLoad() {
        mPagingProductV.delegate = self

//        let textImageId = AppItemTable.getMainImageByItemId(itemId: 7814)
//        if let textImage = FileTable.getImage(textImageId.first) {
//            mImgVText.image = textImage
//        }
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
