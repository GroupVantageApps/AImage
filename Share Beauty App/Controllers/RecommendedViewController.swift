//
//  RecommendedViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/11.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class RecommendedViewController: UIViewController, NavigationControllerAnnotation, RecommendProductViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet private weak var mCollectionView: UICollectionView!
    @IBOutlet weak var mBtnFilterByLine: BaseButton!
    @IBOutlet weak var mBtnFilterByBeauty: BaseButton!

    private let mScreen = ScreenData(screenId: Const.screenIdRecommend)
    private let mDropDownByLine = DropDown()
    private let mDropDownByItem = DropDown()

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    private var mProducts: [ProductData]!
    private var mLines = [(id: Int, name: String)]()
    private var mBeautySeconds = [(id: Int, name: String)]()

    private var mSelectLineId = 0
    private var mSelectBeautySecondId = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.register(UINib(nibName: "RecommendProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadProduct()
        mProducts.forEach { productData in
            let lineIds = mLines.map {$0.id}
            let beautyIds = mBeautySeconds.map {$0.id}

            if !lineIds.contains(productData.lineId) {
                mLines.append((id: productData.lineId, name: productData.lineName))
            }
            if !beautyIds.contains(productData.beautySecondId) {
                mBeautySeconds.append((id: productData.beautySecondId, name: productData.beautyName))
            }
        }
        self.setupDropDownFileterByLine()
        self.setupDropDownFileterByItem()
    }

    internal func didSelect(product: ProductData) {
        //LXか通常かのViewに遷移　t-hirai
        let productId: Int? = product.productId
        if productId == nil {return}
        
        if Const.lineIdLX == product.lineId {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LXProductDetailViewController", targetClass: LXProductDetailViewController.self) as! LXProductDetailViewController
            nextVc.productId = productId!
            nextVc.relationProducts = mProducts.filter {$0.idealBeautyType == Const.idealBeautyTypeProduct}
            self.delegate?.nextVc(nextVc)
        } else {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
            nextVc.productId = productId!
            nextVc.relationProducts = mProducts.filter {$0.idealBeautyType == Const.idealBeautyTypeProduct}
            self.delegate?.nextVc(nextVc)
        }
        

         //オリジナル　t-hirai
        /**let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = product.productId
        productDetailVc.relationProducts = mProducts
        delegate?.nextVc(productDetailVc)**/
    }

    private func setupDropDownFileterByLine() {
        mDropDownByLine.dataSource = mLines.map({ (id: Int, name: String) -> String in
            return name
        })
        mDropDownByLine.dataSource.insert("By Line", at: 0)
        self.mBtnFilterByLine.setTitle(mDropDownByLine.dataSource[0], for: .normal)
        mDropDownByLine.anchorView = mBtnFilterByLine
        mDropDownByLine.bottomOffset = CGPoint(x: 0, y: mBtnFilterByLine.height)
        mDropDownByLine.selectionAction = { [unowned self] (index, item) in
            self.mBtnFilterByLine.setTitle(self.mDropDownByLine.dataSource[index], for: .normal)
            if index == 0 {
                self.mSelectLineId = 0
            } else {
                self.mSelectLineId = self.mLines[index-1].id
            }
            self.reloadProduct()
        }
        mDropDownByLine.direction = .bottom
    }

    private func setupDropDownFileterByItem() {
        mDropDownByItem.dataSource = mBeautySeconds.map({ (id: Int, name: String) -> String in
            return name
        })
        mDropDownByItem.dataSource.insert("By item", at: 0)
        self.mBtnFilterByBeauty.setTitle(mDropDownByItem.dataSource[0], for: .normal)
        mDropDownByItem.anchorView = mBtnFilterByBeauty
        mDropDownByItem.bottomOffset = CGPoint(x: 0, y: mBtnFilterByBeauty.height)
        mDropDownByItem.selectionAction = { [unowned self] (index, item) in
            self.mBtnFilterByBeauty.setTitle(self.mDropDownByItem.dataSource[index], for: .normal)
            if index == 0 {
                self.mSelectBeautySecondId = 0
            } else {
                self.mSelectBeautySecondId = self.mBeautySeconds[index-1].id
            }
            self.reloadProduct()
        }
        mDropDownByItem.direction = .bottom
    }

    private func reloadProduct() {
        mProducts = ProductListData(lineId: mSelectLineId, beautySecondId: mSelectBeautySecondId).products
        mCollectionView.reloadData()
    }

    @IBAction func onTapByLine(_ sender: Any) {
        Utility.log("onTapByLine")
        mDropDownByLine.show()
    }

    @IBAction func onTapByItem(_ sender: Any) {
        Utility.log("onTapByItem")
        mDropDownByItem.show()
    }

    @IBAction func onTapDeleteAll(_ sender: Any) {
        Utility.log("onTapDeleteAll")

        let alert: UIAlertController = UIAlertController(title: "Confirm", message: "Delete all item(s)", preferredStyle:  UIAlertControllerStyle.alert)

        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) -> Void in
            print("OK")
            RecommendTable.deleteAll()
            self.mProducts = []
            self.mCollectionView.reloadData()
        })

        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
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
}
