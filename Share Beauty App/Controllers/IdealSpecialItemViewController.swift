//
//  IdealResultViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/26.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class IdealSpecialItemViewController: UIViewController, NavigationControllerAnnotation, IdealProductViewDelegate, TroubleViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var mTroubleView: TroubleView!
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    var selectedLineIds: [Int] = []
    var selectedStepLowerIds: [Int] = []
    fileprivate var mProducts: [ProductData]!

    override func viewDidLoad() {
        super.viewDidLoad()
        mTroubleView.delegate = self
//        let productListData: ProductListData = ProductListData(spLineIds: selectedLineIds, spStepLowerIds: selectedStepLowerIds)
//        mProducts = productListData.products
        mCollectionView.register(UINib(nibName: "IdealProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
    }

    // MARK: - IdealProductListViewDelegate
    func didTap(_ sender: IdealProductView) {
        let productId: Int? = sender.product?.productId
        if productId == nil {return}
        let nextVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        nextVc.productId = productId!
        self.delegate?.nextVc(nextVc)
    }
    func didTapTrouble(_ sender: DataStructTrouble) {
        mTroubleView.image = FileTable.getImage(sender.image)
        mTroubleView.isHidden = false
    }
    func didTapClose() {
        mTroubleView.isHidden = true
    }

    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 2 != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "space", for: indexPath)
            cell.backgroundColor = UIColor.black
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IdealProductView
            cell.delegate = self
            cell.product = mProducts[indexPath.row / 2]
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
            width = collectionView.width / 5
        }
        let height: CGFloat = collectionView.height
        return CGSize(width: width, height: height)
    }
    func didTapMirror(_ show: Bool, product: ProductData) {
    }
}
