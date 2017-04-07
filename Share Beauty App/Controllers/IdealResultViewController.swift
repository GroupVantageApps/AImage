//
//  IdealResultViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/26.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class IdealResultViewController: UIViewController, NavigationControllerAnnotation, IdealProductViewDelegate, IdealResultCollectionViewDelegate, TroubleViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak private var mIdealResultCollectionVFirst: IdealResultCollectionView!
    @IBOutlet weak private var mIdealResultCollectionV: IdealResultCollectionView!
    @IBOutlet weak private var mVSelectBase: UIView!
    @IBOutlet weak private var mVSelectLineClickable: UIView!
    @IBOutlet weak private var mTroubleView: TroubleView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak private var mBtnDropDown: BaseButton!
    @IBOutlet weak private var mVDropDown: UIView!
    @IBOutlet weak private var mImgVToggle: UIImageView!
    @IBOutlet weak private var mConstraintTop: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintCenter: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintTopLineView: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintBottomLineView: NSLayoutConstraint!
    @IBOutlet weak private var mVMain: UIView!
    @IBOutlet weak private var mScrollVPinch: UIScrollView!

    private let mScreen = ScreenData(screenId: Const.screenIdIdealBeauty4)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    var selectedLineIds: [Int] = []
    var selectedStepLowerIds: [Int] = []
    var items: [String: String]!
    var products: [ProductData]?
    var noAddFlg: Bool = false

    private var mProducts: [ProductData]!
    private var mProductImages: [Int:UIImage]!
    private var mAspect: CGFloat = 1.0
    private var mSpaceViews: [UICollectionViewCell] = []
    private var mShowTrobleIndexes: [Int] = []
    private var mDropDown = DropDown()
    private var mStepLowers = [DataStructStepLower]()

    private var mCurrentTop: CGFloat!
    private var mlastLocation: CGFloat!
    private var mIsShowLineView: Bool = false
    private var mCanAnimateLineView: Bool = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mVSelectBase.isHidden = (products != nil)
        if var lines = IdealBeautyLinesData().lines {
            if lines.first != nil {
                mIdealResultCollectionVFirst.lines = [lines.first!]
                lines.removeFirst()
            }
            mIdealResultCollectionV.lines = lines
        }

        mIdealResultCollectionVFirst.selectedLineIds = self.selectedLineIds
        mIdealResultCollectionVFirst.delegate = self


        mIdealResultCollectionV.selectedLineIds = self.selectedLineIds
        mIdealResultCollectionV.delegate = self
        mTroubleView.delegate = self

        items = AppItemTable.getItems(screenId: Const.screenIdIdealBeauty4)
        Utility.log(items)

        mCollectionView.register(UINib(nibName: "IdealProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
        if selectedStepLowerIds.count > 1 {
            self.setupDropDown()
        }
        let swipeGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGesture.maximumNumberOfTouches = 1
        mVSelectBase.addGestureRecognizer(swipeGesture)

        mScrollVPinch.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setProductListData()
        mCollectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsOnce {
            mCollectionView.delegate = self
            mCollectionView.dataSource = self
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("+++++++++++++++++++++++ IdealResult +++++++++++++++++++++++++")
        print("self.view.height:", self.view.height)
        print("mCollectionView.height:", mCollectionView.height)
        print("mVSelectBase.height:", mVSelectBase.height)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func toggleLineSelect(duration: CGFloat) {
        var strImage: String!
        if mIsShowLineView {
            strImage = "button_open"
            mConstraintTop.isActive = false
            mConstraintCenter.isActive = true
            mConstraintBottomLineView.isActive = false
            mConstraintTopLineView.isActive = true
        } else {
            strImage = "button_close"
            mConstraintCenter.isActive = false
            mConstraintTop.isActive = true
            mConstraintTopLineView.isActive = false
            mConstraintBottomLineView.isActive = true
        }
        mImgVToggle.image = UIImage(named: strImage)

        UIView.animateIgnoreInteraction(
            duration: TimeInterval(duration),
            animations: {[weak self] in
                self!.view.layoutIfNeeded()
            },
            completion: {[weak self] _ in
                self!.mIsShowLineView = !(self!.mIsShowLineView)
        })
    }

    private func setupDropDown() {
        mVDropDown.isHidden = false

        let idealBeautySecondsData = IdealBeautySecondsData(lineIds: selectedLineIds)
        mStepLowers = idealBeautySecondsData.stepLowers.filter({ (dataStructStepLower) -> Bool in
            return selectedStepLowerIds.contains(dataStructStepLower.stepLowerId)
        })
        var lowerNames = [String]()
        let item = AppItemTable.getItems(screenId: Const.screenIdProductList)
        lowerNames.append(item["02"]!)
        lowerNames += mStepLowers.map {$0.name}

        mDropDown.dataSource = lowerNames
        self.mBtnDropDown.setTitle(mDropDown.dataSource[0], for: UIControlState())
        mDropDown.anchorView = mBtnDropDown
        mDropDown.bottomOffset = CGPoint(x: 0, y: mBtnDropDown.height)
        mDropDown.selectionAction = { [unowned self] (index, item) in
            self.mBtnDropDown.setTitle(item, for: UIControlState())
            if index == 0 {
                self.selectedStepLowerIds = self.mStepLowers.map {$0.stepLowerId}
            } else {
                self.selectedStepLowerIds = [self.mStepLowers[index - 1].stepLowerId]
            }
            self.setProductListData()
            self.mCollectionView.reloadData()
        }
        mDropDown.direction = .bottom
    }

    func setProductListData() {
        if products == nil {
            let productListData = ProductListData(lineIdsOrigin: selectedLineIds, stepLowerIdsOrigin: selectedStepLowerIds, noAddFlg: noAddFlg)
            mProducts = productListData.products
        } else {
            mProducts = products
        }

        mProductImages = [:]
        mProducts.enumerated().forEach { (i: Int, product: ProductData) in
            mProductImages[i] = FileTable.getImage(product.image)
        }
        mShowTrobleIndexes = []
    }

    @IBAction func onTap(_ sender: Any) {
        self.toggleLineSelect(duration: 0.4)
    }

    func didSwipe(_ gestureRecognizer: UIPanGestureRecognizer) {
        let topLimit = mVSelectBase.superview!.bottom
        let bottomLimit = mVSelectBase.superview!.bottom + mVSelectBase.height - mVSelectLineClickable.height
        switch gestureRecognizer.state {
        case .began:
            mCurrentTop = gestureRecognizer.location(in: mVSelectBase).y
        case .changed:
            mlastLocation = gestureRecognizer.translation(in: mVSelectBase).y
            let bottom = mVSelectBase.top + gestureRecognizer.location(in: mVSelectBase).y - mCurrentTop + mVSelectBase.height
            if topLimit > bottom {
                mVSelectBase.bottom = topLimit
                if mIsShowLineView {
                    mCanAnimateLineView = false
                }
            } else if bottomLimit < bottom {
                mVSelectBase.bottom = bottomLimit
                if !mIsShowLineView {
                    mCanAnimateLineView = false
                }
            } else {
                mVSelectBase.bottom = bottom
                mCanAnimateLineView = true
            }
        case .ended, .cancelled:
            if !mCanAnimateLineView { return }
            var duration = abs(mVSelectBase.height / gestureRecognizer.velocity(in: mVSelectBase).y)
            if duration > 0.4 {
                duration = 0.4
            }
            self.toggleLineSelect(duration: duration)
        default:
            return
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
        mTroubleView.image = FileTable.getImage(sender.image)
        mTroubleView.isHidden = false
    }
    // MARK: - IdealResultCollectionViewDelegate
    func didTapCell(_ sender: IdealResultCell) {
        let line = sender.line!
        if sender.selected {
            selectedLineIds.append(line.lineId)
        } else {
            if let index = (selectedLineIds.index { $0 == line.lineId }) {
                selectedLineIds.remove(at: index)
            }
        }
        self.setProductListData()
        mCollectionView.reloadData()
        var targetIndex: Int?
        if sender.selected {
            if let targetProduct = (mProducts.filter { $0.lineId == line.lineId && $0.idealBeautyType == Const.idealBeautyTypeLine }).first {
                targetIndex = mProducts.index(of: targetProduct)! * 2 + 1
            }
        } else {
            if mProducts.count != 0 {
                targetIndex = 0
            }
        }
        if targetIndex != nil {
            mCollectionView.scrollToItem(at: IndexPath(row: targetIndex!, section: 0), at: .left, animated: true)
        }
    }
    // MARK: - TroubleViewDelegate
    func didTapClose() {
        mTroubleView.isHidden = true
    }

    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "space", for: indexPath)
            let rightViewIndex = indexPath.row / 2
            if mProducts.count > rightViewIndex {
                let product = mProducts[rightViewIndex]
                if product.idealBeautyType == Const.idealBeautyTypeLine {
                    cell.backgroundColor = .black
                } else {
                    cell.backgroundColor = .clear
                }
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IdealProductView
            cell.delegate = self
            cell.product = mProducts[indexPath.row / 2]
            cell.productImage = mProductImages[indexPath.row / 2]
            cell.troubleViewState(mShowTrobleIndexes.contains(indexPath.row / 2))
            cell.indexPath = indexPath
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mProducts.count * 2 + 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var width: CGFloat!
        if indexPath.row % 2 == 0 {
            width = 1
        } else {
            width = collectionView.width / 3.7
            let product = mProducts[indexPath.row / 2]
            if product.productId == 0 && !product.lineOpened {
                width = width * 0.7
            }
        }
        let height: CGFloat = collectionView.height
        return CGSize(width: width, height: height)
    }
    func didTapMirror(_ show: Bool, product: ProductData) {
        if show {
            mShowTrobleIndexes.append(mProducts.index(of: product)!)
        } else {
            mShowTrobleIndexes.remove(at: mShowTrobleIndexes.index(of: mProducts.index(of: product)!)!)
        }
    }
    @IBAction private func onTapDropDown(_ sender: AnyObject) {
        mDropDown.show()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        mVMain.isUserInteractionEnabled = (scrollView.zoomScale == 1.0)
    }
}
