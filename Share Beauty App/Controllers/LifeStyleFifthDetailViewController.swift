//
//  LifeStyleFifthDetailViewController.swift
//  Share Beauty App
//
//  Created by asiaquest on 2017/07/27.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class LifeStyleFifthDetailViewController: UIViewController, NavigationControllerAnnotation, LifeStyleFifthProductViewDelegate, UIScrollViewDelegate {
    @IBOutlet private var mLifeStyleProductViews: [LifeStyleFifthProductView]!
    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mLblTopics: UILabel!
    @IBOutlet weak var mTopImageView: UIImageView!
    
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    
    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeautyF)
    
    var items: [String: String]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mScrollV.delegate = self
        
        let imageId = AppItemTranslateTable.getEntity(7922).mainImage.first
        self.mTopImageView.image = FileTable.getImage(imageId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let productList = ProductListData(screenId: Const.screenIdLifeStyleBeautyF)
        items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeautyF)
        
        for enumerated in productList.products.enumerated() {
            let i = enumerated.offset
            let product = enumerated.element
            
            guard let lifeStyleProductView = mLifeStyleProductViews[safe: i] else {
                continue
            }
            lifeStyleProductView.delegate = self
            lifeStyleProductView.numberString = "\(i+1)"
            lifeStyleProductView.product = product
            lifeStyleProductView.logScreenId = mScreen.code
            lifeStyleProductView.logItemId = "0" + String(i+1)
            
            let transitionItemId = "1" + String(i+1)
            if let json = items[transitionItemId] {
                lifeStyleProductView.isHighlighted = isHighlighted(strJson: json)
                lifeStyleProductView.transitionItemId = transitionItemId
            }
        }
        mLblTopics.text = items["11"]
    }
    
    private func isHighlighted (strJson: String) -> Bool {
        let transitionData = Utility.parseJson(strJson)
        
        if let shadowfilter = transitionData?["shadowfilter"].string {
            return shadowfilter == "2" //グレーフィルタを今後のために数値を１＞2に変更　t-hirai
        } else {
            return false
        }
    }
    
    private func getTransitionFilterInfo(strJson: String) -> (type: Int?, productIds: String?, beautyIds: String?, lineIds: String?)? {
        let transitionData = Utility.parseJson(strJson)
        
        let type = transitionData?["type"].int
        let productIds = transitionData?["productId"].string
        let beautyIds = transitionData?["beautyId"].string
        let lineIds = transitionData?["lineId"].string
        
        if productIds == nil && beautyIds == nil && lineIds == nil {
            return nil
        } else {
            return (type, productIds, beautyIds, lineIds)
        }
    }
    
    func didTapProduct(_ product: ProductData?, transitionItemId: String?) {
        if transitionItemId != nil,
            let json = items[transitionItemId!],
            let filterInfo = self.getTransitionFilterInfo(strJson: json) {
            let products = ProductListData(productIds: filterInfo.productIds,
                                           beautyIds: filterInfo.beautyIds,
                                           lineIds: filterInfo.lineIds).products
            let idealResultVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealResultViewController.self) as! IdealResultViewController
            idealResultVc.products = products
            delegate?.nextVc(idealResultVc)
            
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
