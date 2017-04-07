//
//  MakeupViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/02/28.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class MakeupViewController: UIViewController, NavigationControllerAnnotation, UICollectionViewDelegate, UICollectionViewDataSource, IdealProductViewDelegate {

    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "MAKE UP BEAUTY"
    var isEnterWithNavigationView = true

    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak private var mVMain: UIView!
    @IBOutlet weak private var mScrollVPinch: UIScrollView!
    @IBOutlet weak private var mBtnDropDown: BaseButton!

    private var products: [ProductData]!
    private var mProducts: [ProductData]!
    private var mDropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.register(UINib(nibName: "IdealProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.allowsSelection = false
        mScrollVPinch.delegate = self
        mProducts = ProductListData(lineId: Const.lineIdMAKEUP).products
        mProducts.enumerated().forEach { (i: Int, product: ProductData) in
            product.uiImage = FileTable.getImage(product.image)
        }
        products = mProducts
        setupDropDown()
    }

    private func setupDropDown() {
        var lowerNames = [String]()
        let item = AppItemTable.getItems(screenId: Const.screenIdProductList)
        lowerNames.append(item["02"]!)
        for product in mProducts {
            if !lowerNames.contains(product.beautyName) {
                lowerNames.append(product.beautyName)
            }
        }
        mDropDown.dataSource = lowerNames
        self.mBtnDropDown.setTitle(mDropDown.dataSource[0], for: UIControlState())
        mDropDown.anchorView = mBtnDropDown
        mDropDown.bottomOffset = CGPoint(x: 0, y: mBtnDropDown.height)
        mDropDown.direction = .bottom
        mDropDown.selectionAction = { [unowned self] (index, item) in
            self.mBtnDropDown.setTitle(item, for: UIControlState())
            if index == 0 {
                self.mProducts = self.products
            } else {
                self.mProducts = self.products.filter { $0.beautyName == item }
            }
            self.mCollectionView.reloadData()
        }
    }

    @IBAction private func onTapDropDown(_ sender: AnyObject) {
        mDropDown.show()
    }

    override func viewWillAppear(_ animated: Bool) {
        mCollectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsOnce {
            mCollectionView.delegate = self
            mCollectionView.dataSource = self
        }
    }

    // MARK: - IdealProductListViewDelegate
    func didTap(_ sender: IdealProductView) {
        let productId: Int? = sender.product?.productId
        if productId == nil {return}
        let nextVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        nextVc.productId = productId!
        nextVc.relationProducts = mProducts.filter {$0.idealBeautyType == Const.idealBeautyTypeProduct}
        self.delegate?.nextVc(nextVc)
    }

    func didTapTrouble(_ sender: DataStructTrouble) {
    }

    func didTapMirror(_ show: Bool, product: ProductData) {
    }

    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IdealProductView
            cell.delegate = self
            cell.product = mProducts[indexPath.row]
            cell.productImage = mProducts[indexPath.row].uiImage
            cell.indexPath = indexPath
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mProducts.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.width / 3.7
        let height: CGFloat = collectionView.height
        return CGSize(width: width, height: height)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        mVMain.isUserInteractionEnabled = (scrollView.zoomScale == 1.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
