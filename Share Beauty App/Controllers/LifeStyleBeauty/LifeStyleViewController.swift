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
    private var relative_productIds:[Int] =  [564,565,566,567,568,569,LanguageConfigure.UTMId, 570, 571]
    private let essentialEnagyProducts = [553,554]
    private let whiteLucentProducts = [101,455]
    private let makeUpProducts = [470,500,551]
    private let suncareProducts = [545,549,498]
    private var essentialEnagyProductsCount = 0
    private var whiteLucentProductsCount    = 0
    private var makeUpProductsCount         = 0
    private var suncareProductsCount        = 0
    private let productList = ProductListData()
    
//    private let tmpMakeupStrings = ["Kajal","Eyeliner","Eyeshadow","Brow","Face","Eye","Lip","Body"]
    private let tmpMakeupStrings = [7898, 7969, 7971, 7973, 7977, 7979, 7981, 7983]
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
        
        // 商品の有無、多言語対応
        for productId in productIdsDefault {
            if productIds.contains(productId) {
                continue
            }
            if let data: ProductData = ProductData(productId: productId) as ProductData? {
                if data.defaultDisplay == 1 {
                    productIds.append(productId)
                    if productId == 601 {
                        productIds.append(99999)
                    }
                    // make up
                    // else if productId == 578 || productId == 572 {
                    //    productIds.append(99999)
                    // }
                }
            }
        }
        print("productsIds: \(productIds)")
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
        setScrollView()
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
        layer.videoGravity = AVLayerVideoGravityResize
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

    func didFinishPlaying() {
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
            print("cell.tag:\(cell.tag)")
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

            print("cell.image:\(String(describing: cell.image))")

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
        self.productList.products = tempProducts
        
        for _ in 0..<productList.products.count {
            self.mLifeStyleProductViews.append(LifeStyleProductView())
        }
        var contentWidth = CGFloat(60)
        for enumerated in productList.products.enumerated() {
            let product = enumerated.element
            if essentialEnagyProducts.contains(product.productId) {
                essentialEnagyProductsCount += 1
            }
            if whiteLucentProducts.contains(product.productId) {
                whiteLucentProductsCount += 1
            }
            if makeUpProducts.contains(product.productId) {
                makeUpProductsCount += 1
            }
            if suncareProducts.contains(product.productId) {
                suncareProductsCount += 1
            }
        }
        var productsCount = 0
        
        // 各コンテンツ表示
        for enumerated in productList.products.enumerated() {
            let viewWidth = CGFloat(246)
            let viewHeight = CGFloat(480)
            let i = enumerated.offset
            let product = enumerated.element
            productsCount += 1
            
            print("offset:*\(enumerated.offset)")

            guard product.productId != 0 else {
                // 最初の商品の余白表示
                if i == 1 {
                    let howToImageV = UIImageView()
                    howToImageV.contentMode = .scaleAspectFit
                    // howToImageV.image = FileTable.getImage(6534)
                    howToImageV.tag = 88
                    howToImageV.frame = CGRect(x: CGFloat(productsCount - 1) * viewWidth + 60, y: 150, width: viewWidth, height:
                        viewHeight)
                    
                    contentWidth += howToImageV.frame.size.width
                    howToImageV.isUserInteractionEnabled = true
                    howToImageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.howToImageTapped(_:))))
                    
                    mScrollV.addSubview(howToImageV)
                    
                } else {
                    // makeup HowToUse遷移
                    for index in 0...3 {
                        let howToImageV = UIImageView()
                        howToImageV.contentMode = .scaleAspectFit
                        
                        let labe = UILabel.init(frame: CGRect(x: contentWidth, y: 300, width: viewWidth * 0.25, height: 30))
                        labe.font = UIFont(name: "Reader", size: 10)
                        labe.numberOfLines = 0
                        labe.textAlignment = .center
                        
                        if let makeupIndex = productIds.index(of: 578) {
                            let howtoIndex = makeupIndex + 1
                            if howtoIndex == i {
                                howToImageV.image = UIImage.init(named: "makeup_\(index + 1)")
                                howToImageV.tag = 89 + index
                                
                                let itemId = tmpMakeupStrings[index]
                                labe.text = AppItemTable.getNameByItemId(itemId: itemId)
                                mScrollV.addSubview(labe)
                                print("-------------------------------------------")
                                print(labe.text!)
                                howToImageV.frame = CGRect(x: contentWidth, y: 150, width: viewWidth * 0.25, height: viewHeight)
                                howToImageV.layer.borderWidth = 1
                            }
                        }
                        // 商品画像の表示
                        contentWidth += howToImageV.frame.size.width
                        howToImageV.isUserInteractionEnabled = true
                        howToImageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.howToImageTapped(_:))))
                        
                        mScrollV.addSubview(howToImageV)
                    }
                }
                continue
            }
            
            guard let lifeStyleProductView = mLifeStyleProductViews[safe: i] else {
                continue
            }
            
            if i != 1 {
                lifeStyleProductView.delegate = self
                lifeStyleProductView.product = product
                lifeStyleProductView.headerText = items["0" + String(i+1)]
                lifeStyleProductView.explainText = items["1" + String(i+2)]
                lifeStyleProductView.logScreenId = mScreen.code
                lifeStyleProductView.logItemId = "0" + String(i+1)
                
                lifeStyleProductView.frame = CGRect(x: contentWidth, y: 250, width: viewWidth, height: viewHeight)
                lifeStyleProductView.backgroundColor = UIColor.gray

                mScrollV.addSubview(lifeStyleProductView)
            }
            contentWidth += viewWidth
            
            // 画像上のテキスト
            let id = product.productId
            let itemIds = [602: 8021, 606: 8022, 553: 8023]
            if itemIds[id] != nil {
                let text = UILabel(frame: CGRect(x: 0, y: 0, width: 230, height: 0))
                text.font = UIFont(name: "Reader", size: 17)
                text.text = AppItemTable.getNameByItemId(itemId: itemIds[id]!)
                text.textAlignment = NSTextAlignment.center
                text.numberOfLines = 0
                text.lineBreakMode = NSLineBreakMode.byWordWrapping
                text.sizeToFit()
                text.centerX = viewWidth / 2
                text.centerY = 60
                lifeStyleProductView.addSubview(text)
            }
            // 吹き出し分余白
            if id == 613 {
                contentWidth += viewWidth
            }
        }

        if whiteLucentProductsCount != 0 && contentWidth < 2520 {
           contentWidth = 2520
        }
        mScrollV.contentSize = CGSize(width: contentWidth, height: self.view.height)
        contentWidth = 0
        // 説明用画像をセット
        setInfoImage()

        essentialEnagyProductsCount = 0
        whiteLucentProductsCount = 0
        makeUpProductsCount = 0
        suncareProductsCount = 0
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
    private func setInfoImage() {
        imageItemIds = []
        labelItems = []
        for (index, productId) in productIds.enumerated() {

            let x = 246 * index + 90//　  let x = 246 * index + 150
            var imageX: CGFloat = CGFloat(x)

            if productId == 601 {
                imageItemIds.append((discription: "lifestyle10", x: imageX, y: CGFloat(170), width: 500, height: 160)) //width 420
                labelItems.append((discription: 7985, x: imageX + CGFloat(70), y: CGFloat(170), width: CGFloat(400), font: UIFont(name: "Reader", size: 17)!)) //width 320
            } else if productId == 553 {
                imageX -= CGFloat(246 * 2)
                imageItemIds.append((discription: "lifestyle12", x: imageX + 50, y: CGFloat(130), width: CGFloat(620), height: CGFloat(160)))
                // imageItemIds.append((discription: "lifestyle12", x: imageX + 50, y: CGFloat(130), width: CGFloat(420), height: CGFloat(160)))
                labelItems.append((discription: 7986, x: imageX + CGFloat(120), y: CGFloat(140), width: CGFloat(370), font: UIFont(name: "Reader", size: 17)!))
                // labelItems.append((discription: 7986, x: imageX + CGFloat(70), y: CGFloat(140), width: CGFloat(370), font: UIFont(name: "Reader", size: 17)!))
            } else if productId == 610 {
                imageItemIds.append((discription: "lifestyle13", x: imageX + 60, y: CGFloat(170), width: CGFloat(620), height: CGFloat(120)))
                //imageItemIds.append((discription: "lifestyle13", x: imageX - 30, y: CGFloat(170), width: CGFloat(510), height: CGFloat(120)))
                labelItems.append((discription: 7987, x: imageX + CGFloat(180), y: CGFloat(175), width: CGFloat(330), font: UIFont(name: "Reader", size: 17)!))
                //labelItems.append((discription: 7987, x: imageX + CGFloat(60), y: CGFloat(175), width: CGFloat(330), font: UIFont(name: "Reader", size: 17)!))
            } else if productId == 568 { // ダミーid
                imageX -= CGFloat(246 * 2)
                imageItemIds.append((discription: "lifestyle12", x: imageX + 30, y: CGFloat(85), width: CGFloat(440), height: CGFloat(165)))
                labelItems.append((discription: 7988, x: imageX + CGFloat(70), y: CGFloat(95), width: CGFloat(360), font: UIFont(name: "Reader", size: 14)!))
            } else if productId == 609 {
                imageItemIds.append((discription: "lifestyle15", x: imageX, y: CGFloat(150), width: CGFloat(400), height: CGFloat(120)))
                labelItems.append((discription: 7988, x: imageX + CGFloat(80), y: CGFloat(145), width: CGFloat(270), font: UIFont(name: "Reader", size: 17)!))
            } else if productId == 613 {
                imageX -= 10//246
                imageItemIds.append((discription: "lifestyle13", x: imageX, y: CGFloat(150), width: CGFloat(400), height: CGFloat(120)))
                labelItems.append((discription: 7989, x: imageX + CGFloat(80), y: CGFloat(150), width: CGFloat(270), font: UIFont(name: "Reader", size: 17)!))
            }
        }

        imageItemIds.enumerated().forEach { (i: Int, element: (discription: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) in
//            let viewWidth = Int(246)
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
            //            let viewWidth = Int(246)
            let (_, element) = arg
            let label = UILabel()
//            label.contentMode = .scaleAspectFit
            label.numberOfLines = 0
//            label.layer.borderWidth = 2.0
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
        for productId in productIdsDefault { // relative_productIds
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
        for productId in productIdsDefault { // relative_productIds
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
