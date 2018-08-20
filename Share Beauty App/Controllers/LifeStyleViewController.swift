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
    
    func didTapProduct(_ product: ProductData?, transitionItemId: String?) {
        
        if (product?.productId == 566) || (product?.productId == 568){
            let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealResultViewController.self) as! IdealResultViewController
            nextVc.selectedLineIds = [Const.lineIdUTM]
            nextVc.getProdut_id = (product?.productId)!
            delegate?.nextVc(nextVc)
        }else{

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

//    private let productIds:[Int] = [553,554,101,455,470,500,551,545,549,498]
//    private let productIds:[Int] = [564,6534,566,567,LanguageConfigure.UTMId, 570, 571]
    private var productIdsDefault:[Int] = [564,566,568,LanguageConfigure.UTMId, 570, 571, 578, 572]
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
    
    private var imageItemIds = [
        (discription: "lifestyle10", x: CGFloat(600), y: CGFloat(170), width: CGFloat(400), height: CGFloat(130)),//t-hirai 始めの吹き出し//x:100 y:205
       //(discription: "lifestyle9", x: CGFloat(100), y: CGFloat(160), width: CGFloat(400), height: CGFloat(130)),//t-hirai 始めの吹き出し
        (discription: "lifestyle9", x: CGFloat(550), y: CGFloat(140), width: CGFloat(400), height: CGFloat(160)),
        //(discription: "lifestyle10", x: CGFloat(550), y: CGFloat(130), width: CGFloat(400), height: CGFloat(160)),//t-hirai
        (discription: "lifestyle11", x: CGFloat(960), y: CGFloat(180), width: CGFloat(60), height: CGFloat(60)), //t-hirai 太陽の位置
        //(discription: "lifestyle11", x: CGFloat(920), y: CGFloat(200), width: CGFloat(60), height: CGFloat(60)), t-hirai 太陽の位置
        (discription: "lifestyle12", x: CGFloat(940), y: CGFloat(90), width: CGFloat(840), height: CGFloat(180)),//*真ん中の吹き出し //x:1000
        // (discription: "lifestyle12", x: CGFloat(1260), y: CGFloat(90), width: CGFloat(400), height: CGFloat(180)), t-hirai FDの吹き出し
        // (discription: "lifestyle14", x: CGFloat(2320), y: CGFloat(150), width: CGFloat(90), height: CGFloat(70)),//水しぶき
        ]

    private var labelItems = [
        (discription: 7928, x: CGFloat(170), y: CGFloat(160), width: CGFloat(300), font:UIFont(name: "Reader-Bold", size: 17)),//t-hirai 始めの文字はば//左吹き出しテキストy:200
        (discription: 7930, x: CGFloat(680), y: CGFloat(102), width: CGFloat(400), font:UIFont(name: "Reader-Bold", size: 17)),//真ん中吹き出しテキストx:610y:150
        //(discription: 7922, x: CGFloat(610), y: CGFloat(133), width: CGFloat(280), font:UIFont(name: "Reader-Bold", size: 17)),
        (discription: 7935, x: CGFloat(565), y: CGFloat(515), width: CGFloat(500), font:UIFont(name: "Reader-Bold", size: 14)), //t-hirai　太陽の左の文字
        // (discription: 7924, x: CGFloat(1340), y: CGFloat(105), width: CGFloat(240), font:UIFont(name: "Reader-Bold", size: 17)), //FDの吹き出し参考
        //(discription: 7928, x: CGFloat(2000), y: CGFloat(130), width: CGFloat(190), font:UIFont(name: "Reader-Bold", size: 17)),
        //(discription: 7930, x: CGFloat(2100), y: CGFloat(530), width: CGFloat(350), font:UIFont(name: "Reader-Bold", size: 10)),
        ]
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
        let items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeauty)
        titleLabel.text = AppItemTable.getNameByItemId(itemId: 7838)//7838
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
            if let data: ProductData = ProductData(productId: productId) as ProductData! {
                if data.defaultDisplay == 1 {
                    productIds.append(productId)
                    if productId == 564 {
                        productIds.append(99999)
                    } else if productId == 570 {
                        imageItemIds.append((discription: "lifestyle13", x: CGFloat(1870), y: CGFloat(85), width: CGFloat(400), height: CGFloat(170))) //*WASOの吹き出し //x:1900
                        labelItems.append((discription: 7937, x: CGFloat(1470), y: CGFloat(112), width: CGFloat(240), font:UIFont(name: "Reader-Bold", size: 17))) // WASO吹き出しテキストx:1280y:105
                    } else if productId == 578 || productId == 572 {
                        let imageX: CGFloat
                        let labelX: CGFloat
                        if productId == 578 {
                            let x = 246 * (productIds.count - 1) + 150
                            imageX = CGFloat(x)
                            labelX = CGFloat(x + 100)
                        } else {
                            imageX = (imageItemIds.last?.x)! + CGFloat(480)
                            labelX = (labelItems.last?.x)! + CGFloat(480)
                        }
                        productIds.append(contentsOf: [99999,99999,99999,99999])
                        imageItemIds.append((discription: "lifestyle15", x: imageX, y: CGFloat(85), width: CGFloat(400), height: CGFloat(170)))
                        labelItems.append((discription: 7931, x: labelX, y: CGFloat(110), width: CGFloat(240), font:UIFont(name: "Reader-Bold", size: 17)))
                    }
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
        if false {
            self.createVideo()
            delegate?.showVideoSkipButtonWithDuration(0.3, didTapFunction: {
                self.didFinishPlaying()
            })
            mFinishedAppear = true
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
        let tag = sender.view?.tag as! Int
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

            print("cell.image:\(cell.image)")

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
            guard product.productId != 0 else {
                if 1 < i && i < 4 && whiteLucentProductsCount == 0{
                    productsCount -= 1
                } else {
//                    let view = UIView()
//                    view.frame = CGRect(x: CGFloat(productsCount - 1) * viewWidth + 60, y: 250, width: viewWidth, height: viewHeight)
//                    view.backgroundColor = UIColor.white

                    let imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFit
                    
                    let labe = UILabel.init(frame: CGRect(x: contentWidth, y: 300, width: viewWidth * 0.25, height: 30))
                    labe.font = UIFont(name: "Reader", size: 10)
                    labe.numberOfLines = 0
                    labe.textAlignment = .center
                    
                    //let howToImagePath = ProductDetailData(productId: 578).usageImage.first!
                    print("offset:*\(enumerated.offset)")
                    // 最初の商品とMakeUpのHowToUse画像とラベルの表示
                    if i == 1{
                        // 最初の商品の顔イラスト
                        // imageView.image = FileTable.getImage(6534)
                        imageView.tag = 88
                        imageView.frame = CGRect(x: CGFloat(productsCount - 1) * viewWidth + 60, y: 150, width: viewWidth, height: 
                            viewHeight)
                    }
                    if let makeupIndex = productIds.index(of: 578) {
                        let howtoIndex = makeupIndex + 1
                        if howtoIndex <= i && i <= howtoIndex + 4 {
                            imageView.image = UIImage.init(named: "makeup_\(i - makeupIndex)")
                            imageView.tag = 89 + i - howtoIndex
                            
                            let itemId = tmpMakeupStrings[i - howtoIndex]
                            labe.text = AppItemTable.getNameByItemId(itemId: itemId)
                            mScrollV.addSubview(labe)
                            print("-------------------------------------------")
                            print(labe.text!)
                            let product_offset_width = 8 * viewWidth
                            imageView.frame = CGRect(x: contentWidth, y: 150, width: viewWidth * 0.25, height: viewHeight)
                        }
                    }
                    if let makeupIndex = productIds.index(of: 572) {
                        let howtoIndex = makeupIndex + 1
                        if howtoIndex <= i && i <= howtoIndex + 4 {
                            imageView.image =  UIImage.init(named: "makeup_\(5 + i - howtoIndex)")
                            imageView.tag = 93 + i - makeupIndex
                            
                            let itemId = tmpMakeupStrings[4 + i - howtoIndex]
                            labe.text = AppItemTable.getNameByItemId(itemId: itemId)
                            mScrollV.addSubview(labe)
                            print("-------------------------------------------")
                            print(labe.text!)
                            imageView.frame = CGRect(x: contentWidth, y: 150, width: viewWidth * 0.25, height: viewHeight)
                        }
                    }
                    // 商品画像の表示
                    contentWidth += imageView.frame.size.width
                    imageView.isUserInteractionEnabled = true
                    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.howToImageTapped(_:))))
                    
                    mScrollV.addSubview(imageView)
                }
                continue;
            }

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
            contentWidth += viewWidth
            
        }
        // for文終わり

        if whiteLucentProductsCount != 0 && contentWidth < 2520 {
           contentWidth = 2520
        }
        mScrollV.contentSize = CGSize(width: contentWidth, height: self.view.height)
        contentWidth = 0
        // 説明用画像をセット
        setInfoImage()
        setLabels()
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
        imageItemIds.enumerated().forEach { (i: Int, element: (discription: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) in
            let viewWidth = Int(246)
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: element.x, y: element.y, width: element.width, height: element.height)
            if let image = UIImage(named: element.discription) {
                imageView.image = image
            }
            if element.discription == "lifestyle10" {
                if (makeUpProductsCount == 0) {
                    imageView.frame.size = CGSize(width: 0, height: 0)
                }
                if (whiteLucentProductsCount == 0) {
                    imageView.frame = CGRect(x: element.x - CGFloat(viewWidth*2), y: element.y, width: element.width, height: element.height)
                }
            }
            if element.discription == "lifestyle9" || element.discription == "lifestyle11" {
                if (whiteLucentProductsCount == 0) {
                    imageView.frame.size = CGSize(width: 0, height: 0)
                }
            }
            if element.discription == "lifestyle12" {
                //makeUpProductsCount whiteLucentProductsCount == 0
                if (makeUpProductsCount == 0) {
                    imageView.frame.size = CGSize(width: 0, height: 0)
                }
                if (whiteLucentProductsCount == 0) {
                    imageView.frame = CGRect(x: element.x - CGFloat(viewWidth*2), y: element.y, width: element.width, height: element.height)
                }
            }
            if element.discription == "lifestyle13" || element.discription == "lifestyle14" {
                if (suncareProductsCount == 0) {
                    imageView.frame.size = CGSize(width: 0, height: 0)
                }
                if (whiteLucentProductsCount == 0) {
                    imageView.frame = CGRect(x: element.x - CGFloat(viewWidth*2), y: element.y, width: element.width, height: element.height)
                }
            }
            mScrollV.addSubview(imageView)
        }
    }
    private func setLabels() {
        labelItems.enumerated().forEach { (arg: (offset: Int, element: (discription: Int, x: CGFloat, y: CGFloat, width: CGFloat, font: UIFont?))) in
            let viewWidth = Int(246)
            let (i, element) = arg
            let label = UILabel()
            label.contentMode = .scaleAspectFit
            label.numberOfLines = 0
            label.frame = CGRect(x: element.x, y: element.y, width: element.width, height: 100)

            if let labelFont = element.font {
                label.font = labelFont
            }
            if let text = AppItemTable.getNameByItemId(itemId: element.discription) {
                label.text = text
            }
            // 右詰の設定
            if element.discription == 7926 || element.discription == 7944 {
                label.textAlignment = NSTextAlignment.right
            }
            
            if element.discription == 7923 {
                if (essentialEnagyProductsCount == 0) {
                    label.text = ""
                }
            }
            if element.discription == 7922 || element.discription == 7926 {
                if (whiteLucentProductsCount == 0) {
                    label.text = ""
                }
            }
            if element.discription == 7924 {
                if (makeUpProductsCount == 0) {
                    label.text = ""
                }
                if (whiteLucentProductsCount == 0) {
                    label.frame = CGRect(x: element.x - CGFloat(viewWidth*2), y: element.y, width: element.width, height: 100)
                }
            }
            if element.discription == 7925 || element.discription == 7944 {
                if (suncareProductsCount == 0) {
                    label.text = ""
                }
                if (whiteLucentProductsCount == 0) {
                    label.frame = CGRect(x: element.x - CGFloat(viewWidth*2), y: element.y, width: element.width, height: 100)
                }
            }

            mScrollV.addSubview(label)
        }
    }
}
