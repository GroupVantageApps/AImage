//
//  LifeStyleSeventhDetailViewController.swift
//  Share Beauty App
//
//  Created by asiaquest on 2017/07/29.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class LifeStyleSeventhDetailViewController: UIViewController, NavigationControllerAnnotation, LifeStyleSixthProductViewDelegate {
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak var mTopImageView: UIImageView!
    
    private var mLifeStyleProductViews = [LifeStyleSixthProductView]()
    
    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeautyG)
    
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    
    var items: [String: String]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageId = AppItemTranslateTable.getEntity(7924).mainImage.first
        self.mTopImageView.image = FileTable.getImage(imageId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let productList = ProductListData(screenId: Const.screenIdLifeStyleBeautyH)
        items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeautyH)
        
        // 商品数によるレイアウト決定
        for view in self.mLifeStyleProductViews {
            view.removeFromSuperview()
        }
        self.mLifeStyleProductViews.removeAll()
        for _ in 0..<productList.products.count {
            self.mLifeStyleProductViews.append(LifeStyleSixthProductView())
        }
        
        switch productList.products.count {
        case 1:
            LifeStyleDefault1ProductsLayoutUnit.layout(containerView: self.mVContent, productViews: self.mLifeStyleProductViews)
        case 2:
            LifeStyleDefault2ProductsLayoutUnit.layout(containerView: self.mVContent, productViews: self.mLifeStyleProductViews)
        case 3:
            LifeStyleDefault3ProductsLayoutUnit.layout(containerView: self.mVContent, productViews: self.mLifeStyleProductViews)
        default:
            debugPrint("対応レイアウトが実装されていません");
            break;
        }
        
        for enumerated in productList.products.enumerated() {
            let i = enumerated.offset
            let product = enumerated.element
            
            guard let lifeStyleProductView = mLifeStyleProductViews[safe: i] else {
                continue
            }
            lifeStyleProductView.delegate = self
            lifeStyleProductView.product = product
            print("product.lineName: \(product.productName)")
            lifeStyleProductView.headerText = items["0" + String(i+1)]
            //lifeStyleProductView.explainText = items["1" + String(i+2)]
            
            lifeStyleProductView.logScreenId = mScreen.code
            lifeStyleProductView.logItemId = "0" + String(i+1)
            
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
        
        LogManager.tapProduct(screenCode: mScreen.code, productId: product!.productId)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
}
