//
//  PagingProductView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/10/06.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit


class PagingProductView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, ProductListViewDelegate {
    @IBOutlet weak private var mPageControl: UIPageControl!
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak private var mCollectionV: UICollectionView!
    @IBOutlet weak private var mBtnBack: BaseButton!
    @IBOutlet weak private var mBtnNext: BaseButton!

    @IBInspectable var horizontalCellCount: CGFloat = 1
    @IBInspectable var varticalCellCount: CGFloat = 1
    var productPerList: Int = 1
    var listCount: Int = 1
    weak var delegate: CollectionProductViewDelegate?

    private var mProductImages = [Int:UIImage]()
    private var mAwardImages = [Int:UIImage]()

    var products: [ProductData]! {
        didSet {

            products.enumerated().forEach { (i: Int, product: ProductData) in
                mProductImages[i] = FileTable.getImage(product.image)
                mAwardImages[i] = FileTable.getImage(product.awardIcon)
            }

            productPerList = Int(horizontalCellCount * varticalCellCount)
            listCount = Int(ceilf(Float(products.count) / Float(productPerList)))
            mPageControl.numberOfPages = Int(listCount)

            mCollectionV.register(UINib(nibName: "CollectionProductView", bundle: nil), forCellWithReuseIdentifier: "cell")

            let layout = PagingHorizontalLayout()
            layout.numberOfColumnsHorizontal = horizontalCellCount
            layout.numberOfColumnsVertical = varticalCellCount
            layout.numberOfColumns = CGFloat(products.count)

            mCollectionV.collectionViewLayout = layout

            mCollectionV.delegate = self
            mCollectionV.dataSource = self

            mScrollView.delegate = self
        }
    }

    private func scroll(next: Bool) {
        mBtnNext.isEnabled = false
        mBtnBack.isEnabled = false
        if next {
            mPageControl.currentPage += 1
        } else {
            mPageControl.currentPage -= 1
        }
        let x = mCollectionV.width * CGFloat((mPageControl.currentPage))
        mCollectionV.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    func didSelectProduct(_ productView: CollectionProductView) {
        self.delegate?.didSelectProduct(productView)
    }

    @IBAction private func onTapBack(_ sender: BaseButton) {
        if mPageControl.currentPage - 1 < 0 {return}
        self.scroll(next: false)
    }
    @IBAction private func onTapNext(_ sender: BaseButton) {
        if mPageControl.currentPage + 1 >= mPageControl.numberOfPages {return}
        self.scroll(next: true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == mScrollView {return}
        mBtnBack.isEnabled = false
        mBtnNext.isEnabled = false
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == mScrollView {return}
        mBtnBack.isEnabled = true
        mBtnNext.isEnabled = true
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == mScrollView {return}
        var nextPage: Int!
        if scrollView.contentOffset.x == 0 {
            nextPage = 0
        } else {
            nextPage = Int(scrollView.width / scrollView.contentOffset.x)
        }
        if mPageControl.currentPage != nextPage {
            mPageControl.currentPage = nextPage
        }

        mBtnBack.isEnabled = true
        mBtnNext.isEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionProductView

        cell.product = products[safe: indexPath.row]
        cell.productImage = mProductImages[indexPath.row]
        cell.awardImage = mAwardImages[indexPath.row]
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productPerList * listCount
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView is UICollectionView {
            return nil
        } else {
            return mCollectionV
        }
    }
}
