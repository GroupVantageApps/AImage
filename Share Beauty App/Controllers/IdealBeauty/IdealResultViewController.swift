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
        //*cellに画像とテキストがうまく反映されないバグのためreloadをコメントアウト
        //mCollectionView.reloadData()
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
        
        // Defendからの遷移時にUtmの先頭までスクロールする
        if getProdut_id == 10002{
            let product = mProducts.filter { $0.productId == 0 && $0.lineId == 2 }
            if let utmLine = product.first {
                let utmLineIndex = mProducts.index(of: utmLine)
                let scrollPosition =  utmLineIndex! * 2
                mCollectionView.scrollToItem(at: IndexPath(item: scrollPosition, section: 0), at: .left, animated: true)
            }
        }
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
        //let image:UIImage = UIImage(named: "button_play")!
        let image:UIImage = UIImage(named: "UTM-play-button.png")!
        movieStartButton.setImage(image, for: .normal)
        movieStartButton.imageView?.contentMode = .scaleAspectFit
        movieStartButton.frame = CGRect(x: 80, y: 20, width: 40, height: 40)
        movieStartButton.tag = 10
        movieStartButton.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        mVMain.addSubview(movieStartButton)
        
        let label = UILabel.init(frame: CGRect(x: 50, y: 65, width: 100, height: 25))
        let clenser =  BeautySecondTranslateTable.getEntity(4)
        
        label.text = clenser.name
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.layer.borderWidth = 1
        mVMain.addSubview(label)
        
        let movieStartButton2 = UIButton()
        movieStartButton2.setImage(image, for: .normal)
        movieStartButton2.imageView?.contentMode = .scaleAspectFit
        movieStartButton2.frame = CGRect(x: 190, y: 20, width: 40, height: 40)
        movieStartButton2.tag = 11
        movieStartButton2.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        mVMain.addSubview(movieStartButton2)
        
        let label2 = UILabel.init(frame: CGRect(x: 160, y: 65, width: 100, height: 25))
        let softner =  BeautySecondTranslateTable.getEntity(5)
        label2.text = softner.name
        label2.adjustsFontSizeToFitWidth = true
        label2.textAlignment = .center
        label2.layer.borderWidth = 1
        mVMain.addSubview(label2)
        
    }
    
//    func startMovie(){
//        print("start")
//    }
    
    func showMovie(sender: UIButton) {
        let movie_id = sender.tag == 10 ? 6713 : 6612
        let avPlayer: AVPlayer = AVPlayer(url: FileTable.getPath(movie_id))
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
        telopLabel.font = UIFont(name:"Reader-Regure" ,size: 24)//UIFont.systemFont(ofSize: 24.0)
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
    
    //:*ここでselectedStepLowerIdsをつかって商品情報を取得
    func setProductListData() {
        if products == nil {
            let productListData = ProductListData(lineIdsOrigin: selectedLineIds, stepLowerIdsOrigin: selectedStepLowerIds, noAddFlg: noAddFlg)
            mProducts = productListData.products
        } else {
            mProducts = products
        }

        mProductImages = [:]
        
        //LifestyleBeautyトップからの遷移 product_idごとに表示するproduct変更
        if getProdut_id == (10002){
            //productをnilで判定することができないのでid番号で一致させて、空白部分を作成(IdealProductView.swift)
            mProducts.append(ProductData(productId: 10001))
            addUTMfromLifeStyleBeauty()
        }else if getProdut_id == (566) || getProdut_id == (568) || getProdut_id == (618){ //19AW 対応
            addUTMfromLifeStyleBeauty()
        }
        //IdealBeautym選択画面からの遷移 Remove off makeupとCleanserとSoftner
        if  selectedStepLowerIds.contains(2) || selectedStepLowerIds.contains(3) || selectedStepLowerIds.contains(4) {
            // LXとWasoを選択時は表示しない
            if !(selectedLineIds.contains(1) || selectedLineIds.contains(37)) {
                addUTMfromIdealBeauty()
            }
        }

        mProducts.enumerated().forEach { (i: Int, product: ProductData) in
            mProductImages[i] = FileTable.getImage(product.image)
        }
        mShowTrobleIndexes = []
        
    }
    
    
    func addUTMfromLifeStyleBeauty(){
  
        var ClenserProducts: [ProductData] = []
        for product_id in [617, 565, 566, 567] { //19AW 対応
            let product = ProductData(productId: product_id)
            if product.defaultDisplay == 1 {
                ClenserProducts.append(product)
            }
        }
        
        var SoftenerProducts: [ProductData] = []
        for product_id in [568, 569, 618] { //19AW 対応
            let product = ProductData(productId: product_id)
            if product.defaultDisplay == 1 {
                SoftenerProducts.append(product)
            }
        }
        let UTMproductList = ClenserProducts + SoftenerProducts

        if getProdut_id == 566{
            if ClenserProducts.count > 0 {
                mProducts.insert(contentsOf: ClenserProducts, at: 0)
            }
        }else if getProdut_id == 568{
              if SoftenerProducts.count > 0 {
            mProducts.insert(contentsOf: SoftenerProducts, at: 0)
            }
        }else if getProdut_id == 10002{//NewApproachViewからの遷移
             if UTMproductList.count > 0 {
                mProducts.insert(contentsOf: UTMproductList, at: 0)
            }
            self.setMovieIcon()
        }
    }
    
    func addUTMfromIdealBeauty(){
        var ClenserProducts: [ProductData] = []
        for product_id in [617, 565, 566, 567] { //19AW 対応
            let product = ProductData(productId: product_id)
            if product.defaultDisplay == 1 {
                ClenserProducts.append(product)
            }
        }
        
        var Removeoffmakeup: [ProductData] = []
        for product_id in [617] { //19AW対応
            let product = ProductData(productId: product_id)
            if product.defaultDisplay == 1 {
                Removeoffmakeup.append(product)
            }
        }
        
        var SoftenerProducts: [ProductData] = []
        for product_id in [568, 569, 618] { //19AW 対応
            let product = ProductData(productId: product_id)
            if product.defaultDisplay == 1 {
                SoftenerProducts.append(product)
            }
        }
        let UTMproductList = ClenserProducts + SoftenerProducts
        let sUTMproductList = Removeoffmakeup + SoftenerProducts
        
        if selectedStepLowerIds.contains(3) && selectedStepLowerIds.contains(4){
            if UTMproductList.count > 0 {
                mProducts.insert(contentsOf: UTMproductList, at: 0)
            }
        }else if selectedStepLowerIds.contains(2) && selectedStepLowerIds.contains(3){
            if ClenserProducts.count > 0 {
                mProducts.insert(contentsOf: ClenserProducts, at: 0)
            }
        }else if selectedStepLowerIds.contains(2) && selectedStepLowerIds.contains(4){
            if ClenserProducts.count > 0 {
                mProducts.insert(contentsOf: sUTMproductList, at: 0)
            }
        }else if selectedStepLowerIds.contains(3){
            if ClenserProducts.count > 0 {
                mProducts.insert(contentsOf: ClenserProducts, at: 0)
            }
        }else if selectedStepLowerIds.contains(4){
            if SoftenerProducts.count > 0 {
                mProducts.insert(contentsOf: SoftenerProducts, at: 0)
            }
        }else if selectedStepLowerIds.contains(2){
            if Removeoffmakeup.count > 0 {
                mProducts.insert(contentsOf: Removeoffmakeup, at: 0)
            }
        }
        
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

        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "space", for: indexPath)
            let rightViewIndex = indexPath.row / 2
            if mProducts.count > rightViewIndex {
                let product = mProducts[rightViewIndex]
                //Const.idealBeautyTypeLine == 2
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
            cell.product = mProducts[indexPath.row / 2 ]
            cell.productImage = mProductImages[indexPath.row / 2]
            cell.troubleViewState(mShowTrobleIndexes.contains(indexPath.row / 2))
            cell.indexPath = indexPath
            
            
            if cell.product?.productId == 10001 {
                cell.mTitleContentV.isHidden = true
                cell.mBtnProduct.isHidden = true
                cell.mBtnRecommend.isHidden = true
                cell.mLblBeauty.isHidden = true
                cell.mImgVNew.isHidden = true
                cell.mtitleView.isHidden = true
            } else {
                cell.mTitleContentV.isHidden = false
                cell.mBtnProduct.isHidden = false
                cell.mBtnRecommend.isHidden = false
                cell.mLblBeauty.isHidden = false
                cell.mImgVNew.isHidden = false
                cell.mtitleView.isHidden = false
            }
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mProducts.count * 2 + 1 - 1
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
        mVMain.isUserInteractionEnabled = (scrollView.zoomScale == 0.8) //(scrollView.zoomScale == 1.0)
    }
}
