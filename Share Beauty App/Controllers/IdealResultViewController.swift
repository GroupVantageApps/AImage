//
//  IdealResultViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/26.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

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
    var lineId = 0
    var lineStep = 0
    var getProdut_id = 0

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
    
    private var movieTelop: TelopData!
    private var currentMovieTelop: TelopData.DataStructTerop? = nil
    var mAvPlayerObserver: Any? = nil


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
        
        self.movieTelop = TelopData(movieId: 6542)

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
        
        let centerPosition =  mProducts.count * 2 - 1
        mCollectionView.scrollToItem(at:IndexPath(item: centerPosition, section: 0), at: .right, animated: false)
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let avPlayerVc = object as? AVPlayerViewController {
            // AVPlayerViewControllerのdismiss間際にframeが1度変化する。このタイミングでオブザーバを削除する
            if keyPath == #keyPath(UIViewController.view.frame) {
                avPlayerVc.removeObserver(self, forKeyPath: #keyPath(UIViewController.view.frame))
                if let player = avPlayerVc.player, let observer = self.mAvPlayerObserver {
                    player.removeTimeObserver(observer)
                    self.mAvPlayerObserver = nil
                }
            }
        }
    }
    
    func setMovieIcon(){
        let movieStartButton = UIButton()
        let image:UIImage = UIImage(named: "button_play")!
        movieStartButton.setImage(image, for: .normal)
        movieStartButton.frame = CGRect(x: 80, y: 20, width: 100, height: 100)
        
        movieStartButton.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        mVMain.addSubview(movieStartButton)

    }
    
//    func startMovie(){
//        print("start")
//    }
    
    func showMovie() {
        
        let avPlayer: AVPlayer = AVPlayer(url: FileTable.getPath(6542))
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        self.present(avPlayerVc, animated: true, completion: {
            // dismissを監視するため、オブザーバ登録する
            avPlayerVc.addObserver(self, forKeyPath: #keyPath(UIViewController.view.frame), options: [.old, .new], context: nil)
        })
        avPlayer.play()
        
        // テロップ表示用ラベル
        let telopLabel = UILabel()
        telopLabel.numberOfLines = 0
        telopLabel.lineBreakMode = .byWordWrapping
        telopLabel.backgroundColor = .clear
        telopLabel.font = UIFont.systemFont(ofSize: 24.0)
        telopLabel.adjustsFontSizeToFitWidth = true
        telopLabel.minimumScaleFactor = 0.6
        telopLabel.textColor = .white
        telopLabel.textAlignment = .center
        let labelWidth = self.view.width * 0.9
        telopLabel.frame = CGRect(x: (self.view.width - labelWidth) / 2.0, y: self.view.height - 60.0, width: labelWidth, height: 130.0)
        avPlayerVc.contentOverlayView?.addSubview(telopLabel)
        
        // 再生位置を監視し、テロップを表示する
        let detectionInterval = CMTime(seconds: 1.0, preferredTimescale: 10)
        self.mAvPlayerObserver = avPlayer.addPeriodicTimeObserver(forInterval: detectionInterval, queue: nil, using: { time in
            // 内部関数: 該当のテロップデータを検索する
            func searchTelop(playbackPosition: Float64) -> TelopData.DataStructTerop? {
                var result: TelopData.DataStructTerop? = nil
                for data in self.movieTelop.datas {
                    if data.startTime <= playbackPosition && data.endTime >= playbackPosition {
                        result = data
                        break
                    }
                }
                
                return result
            }
            
            // 内部関数: テロップラベルの更新
            func updateTelopLabel() {
                if let current = self.currentMovieTelop {
                    telopLabel.text = current.content
                } else {
                    telopLabel.text = nil
                }
            }
            
            let playbackPosition = CMTimeGetSeconds(time)
            if let current = self.currentMovieTelop {
                if current.startTime > playbackPosition || current.endTime < playbackPosition {
                    self.currentMovieTelop = searchTelop(playbackPosition: playbackPosition)
                    updateTelopLabel()
                }
            } else {
                self.currentMovieTelop = searchTelop(playbackPosition: playbackPosition)
                updateTelopLabel()
            }
        })
    }
    
    func setProductListData() {
        if products == nil {
            let productListData = ProductListData(lineIdsOrigin: selectedLineIds, stepLowerIdsOrigin: selectedStepLowerIds, noAddFlg: noAddFlg)
            mProducts = productListData.products
        } else {
            mProducts = products
        }

        mProductImages = [:]
        
        //product_idごとに表示するproduct変更
        if getProdut_id == 566{
            let from566Products = [ProductData(productId: 565),ProductData(productId: 566),ProductData(productId: 567)]
            mProducts.insert(contentsOf: from566Products, at: 0)
        }else if getProdut_id == 567{
            let from568Products = [ProductData(productId: 568),ProductData(productId: 569)]
            mProducts.insert(contentsOf: from568Products, at: 0)
        //}
        }else if getProdut_id == 0009{
            let UTMproductList = [ProductData(productId: 565),ProductData(productId: 566),ProductData(productId: 567),ProductData(productId: 568),ProductData(productId: 569)]
            mProducts.insert(contentsOf: UTMproductList, at: 0)
            
            self.setMovieIcon()
        }
    
        
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

        if Const.lineIdLX == sender.product?.lineId {
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

        print(indexPath.row)
        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "space", for: indexPath)
            let rightViewIndex = indexPath.row / 2
            if mProducts.count > rightViewIndex {
                let product = mProducts[rightViewIndex]
                //Const.idealBeautyTypeLine == 2
                if product.idealBeautyType == Const.idealBeautyTypeLine {
                    print("center_indexPath.row")
                    cell.backgroundColor = .black
                } else {
                    print("blue_indexPath.row")
                    cell.backgroundColor = .clear
                }
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IdealProductView
            cell.delegate = self
            print("product_indexPath.row")
//            print("indexPath.row / 2:\(indexPath.row / 2)")
            cell.product = mProducts[indexPath.row / 2 ]
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
