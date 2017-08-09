//
//  RecommendedViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/11.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LineListViewController: UIViewController, NavigationControllerAnnotation, GscNavigationControllerAnnotation,RecommendProductViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mLblTitle: UILabel!
    @IBOutlet private weak var mCollectionView: UICollectionView!
    @IBOutlet private weak var mScrollVPinch: UIScrollView!
    @IBOutlet private weak var mVMain: UIView!

//    private let mScreen = ScreenData(screenId: Const.screenIdIconicBeauty)

    weak var delegate: NavigationControllerDelegate?
    weak var gscDelegate: GscNavigationControllerDelegate?
    
    var theme: String? = ""
    var isEnterWithNavigationView: Bool = true
    
    var fromGscVc: Bool = false
    
    private var mProducts: [ProductData]!

    var line: LineDetailData!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.register(UINib(nibName: "RecommendProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
        mProducts = ProductListData.init(lineId: self.line.lineId).products
        mLblTitle.text = self.line.lineName
        mCollectionView.delegate = self
        mCollectionView.dataSource = self

        mScrollVPinch.delegate = self
    }

    internal func didSelect(product: ProductData) {
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = product.productId
        productDetailVc.relationProducts = mProducts
        if fromGscVc {
            productDetailVc.fromGscVc = true
            gscDelegate?.nextVc(productDetailVc)
        } else {
            delegate?.nextVc(productDetailVc)
        }
    }

    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecommendProductView
            cell.delegate = self
            cell.product = mProducts[indexPath.row / 2]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "space", for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mProducts.count * 2 - 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width: CGFloat!
        if indexPath.row % 2 != 0 {
            width = 1
        } else {
            width = collectionView.width / 4.5
        }
        let height: CGFloat = collectionView.height
        return CGSize(width: width, height: height)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }
}
