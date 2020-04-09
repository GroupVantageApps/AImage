//
//  LifeStyleViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

//productList = 選択したproduct
//relataionProducts = 表示されている全部のproduct

class LifeStyleViewController: UIViewController, NavigationControllerAnnotation, UICollectionViewDelegate, UICollectionViewDataSource, LifeStyleCollectionViewCellDelegate, UIScrollViewDelegate, LifeStyleProductViewDelegate {

    struct LifeStyle {
        private(set) var image: UIImage
        private(set) var text: String
        private(set) var isRecommend: Bool
        private(set) var nextVc: AnyClass
        private(set) var focus: Bool

        init(image: UIImage, text: String, isRecommend: Bool, nextVc: AnyClass, focus: Bool) {
            self.image = image
            self.text = text
            self.isRecommend = isRecommend
            self.nextVc = nextVc
            self.focus = focus
        }
    }

    @IBOutlet weak private var mAVPlayerV: AVPlayerView!
    @IBOutlet weak private var mVMain: UIView!
    @IBOutlet weak private var mCollectionV: UICollectionView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    private var mContentWidth: CGFloat = 0
    
    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeauty)
    private var mLifeStyleProductViews = [LifeStyleProductView]()
    weak var lifeStyleViewDelegate: LifeStyleProductViewDelegate?
    var items: [String: String]!

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    var focusScreenIds: [Int]?
    var isShowVideo: Bool = true

    private var mFinishedAppear: Bool = false

    private var finished: ((_ afterIndex: Int) -> ())!
    private var mLifeStyles = [LifeStyle]()
    private var mCounts = [String: Int]()
    
    private let nextVcs: DictionaryLiteral = [
        4:LifeStyleFifthDetailViewController.self,
        5:LifeStyleSixthDetailViewController.self,
        6:LifeStyleSeventhDetailViewController.self,
        7:LifeStyleEighthDetailViewController.self,
        0:LifeStyleFirstDetailViewController.self,
        1:LifeStyleSecondDetailViewController.self,
        2:LifeStyleThirdDetailViewController.self,
        3:LifeStyleFourthDetailViewController.self,
        ]

    private var productIdsDefault:[Int] = Const.lifeStyleBeautyList
    private var productIds:[Int] = []

    private let moistureProductIds = [602, 606, 553]
    private var utmProductsCount = 0
    private var moistureProductsCount = 0
    private var suncareProductsCount = 0
    private var makeUpProductsCount = 0
    
    private let productList = ProductListData()
    
//    private let tmpMakeupStrings = ["Kajal","Eyeliner","Eyeshadow","Brow","Face","Eye","Lip","Body"]
//    private let tmpMakeupStrings = [7898, 7969, 7971, 7973, 7977, 7979, 7981, 7983]
    private let tmpMakeupStrings = [8160, 8161, 8162, 8163, 8164, 8165]
    private var imageItemIds: [(discription: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)] = []
    private var labelItems: [(discription: Int, x: CGFloat, y: CGFloat, width: CGFloat, font: UIFont)] = []
    private let countryFontScale = [
        // (country: 10, language: 29, scale: CGFloat(0.85)),  // Thailand
        // (country: 8, language: 24, scale: CGFloat(0.85)),   // Vietnam
        (country: 3, language: 18, scale: CGFloat(0.85)),   // Brazil
    ]

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mCounts = LifeStyleBeautyCount.getCounts()
        // let items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeauty)
        titleLabel.text = AppItemTable.getNameByItemId(itemId: 7838)
        mCollectionV.register(UINib(nibName: "LifeStyleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionV.allowsSelection = false

        mCollectionV.delegate = self
        mCollectionV.dataSource = self

        mScrollV.delegate = self
        
        checkDefaultDisplay()
        setScrollView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mCollectionV.reloadData()
        if !isShowVideo {
            mAVPlayerV.removeFromSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mScrollV.contentSize.width = mContentWidth
        mVMain.width = mContentWidth
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if !mFinishedAppear && isShowVideo {
        self.didFinishPlaying()
        if false { // never executed
            // self.createVideo()
            // delegate?.showVideoSkipButtonWithDuration(0.3, didTapFunction: {
               // self.didFinishPlaying()
            // })
            // mFinishedAppear = true
        }
    }

    // 商品の表示有無、カウント
    private func checkDefaultDisplay() {
        for productId in productIdsDefault {
            if productIds.contains(productId) {
                continue
            }
            if let product: ProductData = ProductData(productId: productId) as ProductData? {
                if product.defaultDisplay == 1 {
                    productIds.append(productId)
                    if product.lineId == Const.lineIdUTM {
                        self.utmProductsCount += 1
                    } else if moistureProductIds.contains(product.productId) {
                        self.moistureProductsCount += 1
                    } else if product.lineId == Const.lineIdSUNCARE {
                        self.suncareProductsCount += 1
                    } else if product.lineId == Const.lineIdMAKEUP {
                        self.makeUpProductsCount += 1
                    }
                    // if productId == 601 {
                    //     productIds.append(99999)
                    // }
                    // make up
                    // else if productId == 578 || productId == 572 {
                    //    productIds.append(99999)
                    // }
                }
            }
        }

    }
    
    private func createVideo() {
        let videoPath = Bundle.main.path(forResource: "lifestyle", ofType:"mp4")
        let videoURL = URL(fileURLWithPath: videoPath!)
        let player = AVPlayer(url: videoURL)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didFinishPlaying),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
        let layer = mAVPlayerV.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravity.resize
        layer.player = player
        player.play()
    }

    private func removeVideo() {
        NotificationCenter.default.removeObserver(self)
        let layer = mAVPlayerV.layer as! AVPlayerLayer
        layer.player = nil
    }

    private func getLifeStyleIndexes(screenIds: [Int]) -> [Int] {
        var result = [Int]()
        screenIds.forEach { screenId in
            var index: Int?
            switch screenId {
            case Const.screenIdLifeStyleBeautyA:
                index = 0
            case Const.screenIdLifeStyleBeautyB:
                index = 1
            case Const.screenIdLifeStyleBeautyC:
                index = 2
            case Const.screenIdLifeStyleBeautyD:
                index = 3
            case Const.screenIdLifeStyleBeautyF:
                index = 4
            case Const.screenIdLifeStyleBeautyG:
                index = 5
            case Const.screenIdLifeStyleBeautyH:
                index = 6
            case Const.screenIdLifeStyleBeautyI:
                index = 7
            default:
                index = nil
            }
            if index != nil {
                result.append(index!)
            }
        }
        return result
    }

    @objc func didFinishPlaying() {
        NotificationCenter.default.removeObserver(self)
        self.mVMain.alpha = 0
        mAVPlayerV.removeFromSuperview()
        self.removeVideo()
//        delegate?.showNavigationView(0.3)
        delegate?.hideVideoSkipButtonWithDuration(0.3)
//        UIView.animateIgnoreInteraction(
//            duration: 0,
//            delay: 0,
//            animations: { [unowned self] in
//                self.mVMain.alpha = 1
//            },
//            completion: { finished in
//
//        })
    }
    
    
    @objc private func howToImageTapped(_ sender: UIGestureRecognizer) {
//        let product_564 = ProductData(productId: 564)
        let tag = sender.view!.tag
        var product: ProductData = ProductData(productId: 564)
        var index = 0
        if tag == 88{
            product = ProductData(productId: 564)
        }else if 88 < tag && tag < 93 {
            product = ProductData(productId: 578)
            index = tag - 89
        }else if 93 < tag && tag < 98 {
            product = ProductData(productId: 572)
            index = tag - 94
        }else{
            print("other")
        }
        // HowToUse画像からの画面推移
         if let howtoImageV = sender.view?.viewWithTag(tag){
            if tag != 88 {
             self.didTapHowTo(product, transitionItemId: nil, sender: howtoImageV, index: index)
            }
         }
    }

    // MARK: - CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "space", for: indexPath)
            cell.backgroundColor = UIColor.clear

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LifeStyleCollectionViewCell
            let lifeStyle = mLifeStyles[indexPath.row / 2]
            cell.contentView.viewWithTag(indexPath.row)
            cell.image = lifeStyle.image
            cell.text = lifeStyle.text
            cell.isRecommend = lifeStyle.isRecommend
            cell.index = indexPath.row / 2
            cell.mCountsLabel.text = String(mCounts[String(nextVcs[(indexPath.row / 2)].key)] ?? 0)
            cell.resetAnimation()
            if lifeStyle.focus {
                cell.focusAnimation()
            }
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mLifeStyles.count * 2 + 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat!
        if indexPath.row % 2 == 0 {
            if indexPath.row == 0 {
                width = 45
            } else {
                width = 15
            }
        } else {
            width = 222.25
        }
        let height: CGFloat = collectionView.height
        print("------------------")
        print(width)
        return CGSize(width: width, height: height)
    }

    func didSelect(index: Int) {

        var logItemId: String = ""
        if index == 0 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleFifthDetailViewController", targetClass: LifeStyleFifthDetailViewController.self) as! LifeStyleFifthDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "05"
        } else if index == 1 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleSixthDetailViewController", targetClass: LifeStyleSixthDetailViewController.self) as! LifeStyleSixthDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "06"
        } else if index == 2 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleSeventhDetailViewController", targetClass: LifeStyleSeventhDetailViewController.self) as! LifeStyleSeventhDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "07"

        } else if index == 3 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleEighthDetailViewController", targetClass: LifeStyleEighthDetailViewController.self) as! LifeStyleEighthDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "08"
        } else if index == 4 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleFirstDetailViewController", targetClass: LifeStyleFirstDetailViewController.self) as! LifeStyleFirstDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "01"
            
        } else if index == 5 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleSecondDetailViewController", targetClass: LifeStyleSecondDetailViewController.self) as! LifeStyleSecondDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "02"

        } else if index == 6 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleThirdDetailViewController", targetClass: LifeStyleThirdDetailViewController.self) as! LifeStyleThirdDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "03"

        } else if index == 7 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleFourthDetailViewController", targetClass: LifeStyleFourthDetailViewController.self) as! LifeStyleFourthDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "04"
            
        }

        LogManager.tapItem(screenCode: mScreen.code, itemId: logItemId)
    }

    func didTapRecommend(index: Int) {
        LifeStyleBeautyCount.incrementLocal(index: nextVcs[index].key)
        mCounts = LifeStyleBeautyCount.getCounts()
        mCollectionV.reloadData()
        let logItemId = "1" + String(nextVcs[index].key)
        LogManager.tapLifeStyleItem(screenCode: mScreen.code, itemId: logItemId)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }
    
    
    func setScrollView() {
        items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeauty)
        self.mLifeStyleProductViews.removeAll()
        var secondsProducts = [Int:[ProductData]]()
        var i = 0
        for productId in productIds {
            let data: ProductData = ProductData(productId: productId)
            if data.defaultDisplay == 1 && LineTranslateTable.getEntity(data.lineId).displayFlg == 1 {
                let data: ProductData = ProductData(productId: productId)
                secondsProducts[i] = [data]
            }
            i += 1
        }
        var tempProducts = [ProductData]()
        secondsProducts.keys.sorted().forEach({ key in
            let secondProduct = secondsProducts[key]!
            let new = secondProduct.filter {$0.newItemFlg == 1}
            let old = secondProduct.filter {$0.newItemFlg == 0}
            tempProducts += (new + old)
        })
        self.productList.products = tempProducts
        
        for _ in 0..<productList.products.count {
            self.mLifeStyleProductViews.append(LifeStyleProductView())
        }
        var contentWidth = CGFloat(150)
        
        var pastProductId = 0
        
        // 各コンテンツ表示
        for enumerated in productList.products.enumerated() {
            let viewWidth = CGFloat(300) //246 １アイテムあたり
            let viewHeight = CGFloat(600)
            let i = enumerated.offset
            let product = enumerated.element
            let productId = product.productId
            
            //19AW対応
            //新規追加625, 597, 627, 632, 626, 595, 629, 631
            if pastProductId != 0 {
                if productId == 617 || productId == 618 {
                    contentWidth += viewWidth + 400
                } else if productId == 619 {
                    if pastProductId == 616 {
                        contentWidth += viewWidth + 235
                    } else if pastProductId == 617 {
                        contentWidth += viewWidth + 220
                    } else {
                        contentWidth += viewWidth + 200
                    }
                } else if productId == 620 {
                    if pastProductId == 619 {
                        contentWidth += viewWidth
                    } else if pastProductId == 616 {
                        contentWidth += viewWidth * 2 + 235
                    } else if pastProductId == 617 {
                        contentWidth += viewWidth * 2 + 220
                    } else {
                        contentWidth += viewWidth * 2 + 200
                    }
                } else if productId == 623 {
                    if pastProductId == 619 {
                        contentWidth += viewWidth * 2 + 100
                    } else if pastProductId == 620 {
                        contentWidth += viewWidth + 100
                    } else if pastProductId == 616 {
                        contentWidth += viewWidth + 235
                    } else if pastProductId == 617 {
                        contentWidth += viewWidth + 220
                    } else {
                        contentWidth += viewWidth + 200
                    }
                } else if productId == 624 {
                    if pastProductId == 619 {
                        contentWidth += viewWidth * 3 + 100
                    } else if pastProductId == 620 {
                        contentWidth += viewWidth * 2 + 100
                    } else if pastProductId == 623 {
                        contentWidth += viewWidth
                    } else if pastProductId == 616 {
                        contentWidth += viewWidth * 2 + 235
                    } else if pastProductId == 617 {
                        contentWidth += viewWidth * 2 + 220
                    } else {
                        contentWidth += viewWidth * 2 + 200
                    }
                
                } else if productId == 625 {
                    if pastProductId == 619 || pastProductId == 623 {
                        contentWidth += viewWidth * 2 + 225
                    } else if pastProductId == 620 || pastProductId == 624 {
                        contentWidth += viewWidth + 225
                    }
                    else {
                        contentWidth += viewWidth + 400
                    }
                } else if productId == 597{
                    if pastProductId == 625{
                        contentWidth += viewWidth
                    }
                } else if productId == 627 {
                    if pastProductId == 625 || pastProductId == 597{
                        contentWidth += viewWidth
                    }
                } else if productId == 632{
                    if pastProductId == 625 || pastProductId == 597 || pastProductId == 627{
                        contentWidth += viewWidth
                    }
                } else if productId == 626 {
                    if pastProductId == 632{
                        contentWidth += viewWidth + 200
                    }
                } else if productId == 595 {
                    if pastProductId == 626{
                        contentWidth += viewWidth
                    }
                } else if productId == 629 {
                    if pastProductId == 595 {
                        contentWidth += viewWidth
                    }
                } else if productId == 631 {
                    if pastProductId == 629 {
                        contentWidth += viewWidth
                    }
                }
            } else {
                if productId == 619 || productId == 623 {
                    contentWidth = CGFloat(10)
                } else if productId == 620 || productId == 624 {
                    contentWidth = CGFloat(10) + viewWidth
                }
            }
            
            print("offset:*\(enumerated.offset)")
            
            guard let lifeStyleProductView = mLifeStyleProductViews[safe: i] else {
                continue
            }
            
            lifeStyleProductView.delegate = self
            lifeStyleProductView.product = product
            lifeStyleProductView.headerText = items["0" + String(i+1)]
            lifeStyleProductView.explainText = items["1" + String(i+2)]
            lifeStyleProductView.logScreenId = mScreen.code
            lifeStyleProductView.logItemId = "0" + String(i+1)
            
            lifeStyleProductView.frame = CGRect(x: contentWidth, y: 250, width: viewWidth, height: viewHeight)
            lifeStyleProductView.backgroundColor = UIColor.gray
            mScrollV.addSubview(lifeStyleProductView)
            
            pastProductId = productId
            // 画像上のテキスト
//            let id = product.productId
//            let itemIds = [616: 8160, 617: 8161, 618: 8162]
//            if itemIds[id] != nil {
//                let text = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 0))
//                text.font = UIFont(name: "Reader", size: 17)
//                text.text = AppItemTable.getNameByItemId(itemId: itemIds[id]!)
//                text.textAlignment = NSTextAlignment.center
//                text.numberOfLines = 0
//                text.lineBreakMode = NSLineBreakMode.byWordWrapping
//                text.sizeToFit()
//                text.centerX = viewWidth / 2
//                text.centerY = 60
//                lifeStyleProductView.addSubview(text)
//               
//            }
            // 吹き出し分余白
            // if id == 613 {
            //     contentWidth += viewWidth
            // }
        }

        mContentWidth = contentWidth + 270

        setInfoImage()
    }
    
    private func getTransitionFilterInfo(strJson: String) -> (productIds: String?, beautyIds: String?, lineIds: String?)? {
        let transitionData = Utility.parseJson(strJson)
        
        let productIds = transitionData?["productId"].string
        let beautyIds = transitionData?["beautyId"].string
        let lineIds = transitionData?["lineId"].string
        
        if productIds == nil && beautyIds == nil && lineIds == nil {
            return nil
        } else {
            return (productIds, beautyIds, lineIds)
        }
    }
    
    // 吹き出しセット
    private func setInfoImage() {
        imageItemIds = []
        labelItems = []
        

        var hasMakComment: Bool = false
        let itemIds = [616, 618, 619, 623, 625, 626]
        let itemIdSentences = [616: 8160, 618: 8162, 619: 8163, 623: 8164, 625: 8165, 626: 8165]
        for (index, item) in itemIds.enumerated() {
            let productId = item

            let itemWidth: CGFloat = [625, 626].contains(productId) ? 1400 : 680
            let imageX: CGFloat = [625, 626].contains(productId) ? (680 * 4 + itemWidth * CGFloat(index - 4) + 120) : (itemWidth * CGFloat(index) + 20)
            let imageY: CGFloat = 170
            let height: CGFloat = 130
            let width: CGFloat = [625, 626].contains(productId) ? itemWidth - 300 : itemWidth - 150  //80
            
            let font: UIFont = UIFont(name: "Reader", size: 17)!
            hasMakComment = true
            print(productId)
            print(itemIdSentences[productId])
            imageItemIds.append((discription: "baloon_19AW", x: imageX, y: imageY, width: width, height: height))
            labelItems.append((discription: itemIdSentences[productId] ?? 1111, x: imageX + CGFloat(10), y: imageY, width: width - CGFloat(20), font: font))
        }

        imageItemIds.enumerated().forEach { (i: Int, element: (discription: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) in
            let imageView = UIImageView()
//            imageView.contentMode = .scaleAspectFit
            imageView.contentMode = .scaleToFill
            imageView.frame = CGRect(x: element.x, y: element.y, width: element.width, height: element.height)
            if let image = UIImage(named: element.discription) {
                imageView.image = image
            }
            mScrollV.addSubview(imageView)
        }
        
        labelItems.enumerated().forEach { (arg: (offset: Int, element: (discription: Int, x: CGFloat, y: CGFloat, width: CGFloat, font: UIFont?))) in
            let (_, element) = arg
            let label = UILabel()
//            label.contentMode = .scaleAspectFit
            label.numberOfLines = 0
            label.textColor = UIColor(red: 203 / 255, green: 48 / 255, blue: 43 / 255, alpha: 1.0)
            label.textAlignment =  NSTextAlignment.center
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.frame = CGRect(x: element.x, y: element.y, width: element.width, height: 100)
            if let labelFont = element.font {
                label.font = labelFont
            }
            if let text = AppItemTable.getNameByItemId(itemId: element.discription) {
                label.text = text
            }
            mScrollV.addSubview(label)
        }
    }
    
    func didTapProduct(_ product: ProductData?, transitionItemId: String?) {
        
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard(targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = product!.productId
        
        var secondsProducts = [Int:[ProductData]]()
        var i = 0
        for productId in productIds {
            let data: ProductData = ProductData(productId: productId)
            if data.defaultDisplay == 1 && LineTranslateTable.getEntity(data.lineId).displayFlg == 1 {
                let data: ProductData = ProductData(productId: productId)
                secondsProducts[i] = [data]
            } else {
                //HowToなど画像を置くようにproductを追加
                let data: ProductData = ProductData(productId: 0)
                secondsProducts[i] = [data]
            }
            i += 1
        }
        var tempProducts = [ProductData]()
        secondsProducts.keys.sorted().forEach({ key in
            let secondProduct = secondsProducts[key]!
            let new = secondProduct.filter {$0.newItemFlg == 1}
            let old = secondProduct.filter {$0.newItemFlg == 0}
            tempProducts += (new + old)
        })
        
        i = 0
        for product in tempProducts {
            if product.productId == 0 {
                tempProducts.remove(at: i)
            } else {
                i += 1
            }
        }
        
        productDetailVc.relationProducts = tempProducts
        delegate?.nextVc(productDetailVc)
        
        LogManager.tapProduct(screenCode: mScreen.code, productId: product!.productId)
    }
    
    func didTapHowTo(_ product: ProductData?, transitionItemId: String?,sender: AnyObject, index: Int){
        
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard(targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = product!.productId
        productDetailVc.isHowToUseView = true
        productDetailVc.indexHowToUse = index
        
        var secondsProducts = [Int:[ProductData]]()
        var i = 0
        for productId in productIds {
            let data: ProductData = ProductData(productId: productId)
            if data.defaultDisplay == 1 && LineTranslateTable.getEntity(data.lineId).displayFlg == 1 {
                let data: ProductData = ProductData(productId: productId)
                secondsProducts[i] = [data]
            } else {
                //HowToなど画像を置くようにproductを追加
                let data: ProductData = ProductData(productId: 0)
                secondsProducts[i] = [data]
            }
            i += 1
        }
        var tempProducts = [ProductData]()
        secondsProducts.keys.sorted().forEach({ key in
            let secondProduct = secondsProducts[key]!
            let new = secondProduct.filter {$0.newItemFlg == 1}
            let old = secondProduct.filter {$0.newItemFlg == 0}
            tempProducts += (new + old)
        })
        
        i = 0
        for product in tempProducts {
            if product.productId == 0 {
                tempProducts.remove(at: i)
            } else {
                i += 1
            }
        }
        
        productDetailVc.relationProducts = tempProducts
        delegate?.nextVc(productDetailVc)
        
        LogManager.tapProduct(screenCode: mScreen.code, productId: product!.productId)
        
    }
}
