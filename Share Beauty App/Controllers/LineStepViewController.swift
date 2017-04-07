//
//  LineStepViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/07.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LineStepViewController: UIViewController, NavigationControllerAnnotation, ProductViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak private var mCollectionViewProduct: UICollectionView!
    @IBOutlet weak private var mCollectionViewLower: UICollectionView!
    @IBOutlet weak private var mCollectionViewUpper: UICollectionView!
    @IBOutlet weak private var mLblLine: UILabel!
    @IBOutlet weak private var mScrollVPinch: UIScrollView!
    @IBOutlet weak private var mVMain: UIView!

    private let productCountParScreen = 5
    private let mScreen = ScreenData(screenId: Const.screenIdLineStep)

    var line: LineDetailData!
    var beautySecondId: Int!

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    private var mProducts = [ProductData]()
    private var mUpperSteps = [DBStructStep]()
    private var mLowerSteps = [DBStructLineStep]()

    private var mLowerProductCounts = [Int]()
    private var mUpperProductCounts = [Int]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mCollectionViewProduct.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        mCollectionViewProduct.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        mLblLine.text = line.lineName

        mUpperSteps = line.step
        mLowerSteps = mUpperSteps.flatMap {$0.lineStep}
        mProducts = mLowerSteps.flatMap {$0.productData}

        mUpperSteps.forEach({ dbStructStep in
            var upperCount = 0
            dbStructStep.lineStep.forEach({ dbStructLineStep in
                var lowerCount = 0
                dbStructLineStep.productData.forEach({ productData in
                    lowerCount += 1
                    upperCount += 1
                })
                mLowerProductCounts.append(lowerCount)
            })
            mUpperProductCounts.append(upperCount)
        })

        mCollectionViewProduct.register(UINib(nibName: "ProductView", bundle: nil), forCellWithReuseIdentifier: "product")
        mCollectionViewLower.register(UINib(nibName: "LineStepLowerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "lower")
        mCollectionViewUpper.register(UINib(nibName: "LineStepUpperCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "upper")

        mCollectionViewProduct.allowsSelection = false
        mCollectionViewLower.allowsSelection = false
        mCollectionViewUpper.allowsSelection = false

        mCollectionViewProduct.stringTag = "Product"
        mCollectionViewLower.stringTag = "Lower"
        mCollectionViewUpper.stringTag = "Upper"

        mScrollVPinch.delegate = self
    }

    deinit {
        mCollectionViewProduct.removeObserver(self, forKeyPath: "contentSize")
        mCollectionViewProduct.removeObserver(self, forKeyPath: "contentOffset")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsOnce {
            mCollectionViewProduct.delegate = self
            mCollectionViewLower.delegate = self
            mCollectionViewUpper.delegate = self

            mCollectionViewProduct.dataSource = self
            mCollectionViewLower.dataSource = self
            mCollectionViewUpper.dataSource = self

            self.setupOffset()
        }
    }

    func didTapProduct(_ product: ProductData) {
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = product.productId
        productDetailVc.relationProducts = mProducts
        delegate?.nextVc(productDetailVc)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if !mCollectionViewProduct.contentSize.equalTo(mCollectionViewLower.contentSize) {
                mCollectionViewLower.contentSize = mCollectionViewProduct.contentSize
                mCollectionViewUpper.contentSize = mCollectionViewProduct.contentSize
            }
        } else if keyPath == "contentOffset" {
            if !mCollectionViewProduct.contentOffset.equalTo(mCollectionViewLower.contentOffset) {
                mCollectionViewLower.contentOffset = mCollectionViewProduct.contentOffset
                mCollectionViewUpper.contentOffset = mCollectionViewProduct.contentOffset
            }
        }
    }

    private func setupOffset() {
        if (beautySecondId == nil) {
            return
        }

        let filtered = mProducts.filter {$0.lineId == self.line.lineId && $0.beautySecondId == self.beautySecondId}
        let index: Int? = mProducts.enumerated().filter { $1.productId == filtered[safe: 0]?.productId }[safe: 0]?.offset

        if index != nil {
            DispatchQueue.main.async(execute: {
                self.mCollectionViewProduct.scrollToItem(at: IndexPath(item: index!, section: 0), at: .left, animated: false)
            })
        }
    }

    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.stringTag {
        case mCollectionViewProduct.stringTag:
            print(collectionView.stringTag)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductView
            cell.product = mProducts[indexPath.row]
            cell.delegate = self
            return cell
        case mCollectionViewLower.stringTag:
            print(collectionView.stringTag)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lower", for: indexPath) as! LineStepLowerCollectionViewCell
            cell.dbStructLineStep = mLowerSteps[indexPath.row]
            return cell
        case mCollectionViewUpper.stringTag:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upper", for: indexPath) as! LineStepUpperCollectionViewCell
            cell.step = mUpperSteps[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.stringTag {
        case mCollectionViewProduct.stringTag:
            return mProducts.count
        case mCollectionViewLower.stringTag:
            return mLowerSteps.count
        case mCollectionViewUpper.stringTag:
            return mUpperSteps.count
        default:
            return 0
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var width: CGFloat!
        let height = collectionView.height
        switch collectionView.stringTag {
        case mCollectionViewProduct.stringTag:
            width = collectionView.width / CGFloat(productCountParScreen)
        case mCollectionViewLower.stringTag:
            width = collectionView.width / CGFloat(productCountParScreen) * CGFloat(mLowerProductCounts[indexPath.row])
        default:
            width = collectionView.width / CGFloat(productCountParScreen) * CGFloat(mUpperProductCounts[indexPath.row])
        }
        return CGSize(width: width, height: height)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }
}
