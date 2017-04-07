//
//  OnTrendViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class OnTrendViewController: UIViewController, NavigationControllerAnnotation, CollectionProductViewDelegate {
    @IBOutlet weak fileprivate var mPagingProductV: PagingProductView!
    @IBOutlet weak fileprivate var mImgVMainVisual: UIImageView!
    @IBOutlet weak fileprivate var mAVPlayerV: AVPlayerView!

    fileprivate weak var mPlayer: AVPlayer!

    private let mScreen = ScreenData(screenId: Const.screenIdOnTrendBeauty)
    fileprivate var mProductList: ProductListData!

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    var items: [String: String]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        mPagingProductV.delegate = self
        addMotionEffect()

        items = AppItemTable.getItems(screenId: Const.screenIdOnTrendBeauty)
        Utility.log(items)
    }

    fileprivate func createVideo() {
        guard let movies = AppItemTable.getJsonByItemId(itemId: 7812)?["movie"].arrayObject as? [Int],
            let fileId = movies.first,
            let videoUrl = FileTable.getVideoUrl(fileId) else {
            return
        }
        mPlayer = AVPlayer(url: videoUrl)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didFinishPlaying),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: mPlayer.currentItem
        )
        let layer = mAVPlayerV.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravityResize
        layer.player = mPlayer
        mPlayer.play()
    }
    fileprivate func removeVideo() {
        NotificationCenter.default.removeObserver(self)
        let layer = mAVPlayerV.layer as! AVPlayerLayer
        layer.player = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewWillAppear")
        createVideo()
        mProductList = ProductListData(screenId: Const.screenIdOnTrendBeauty)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsOnce {
            self.view.layoutIfNeeded()
            mPagingProductV.products = mProductList.products
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewDidDisappear")
        removeVideo()
    }

    func didFinishPlaying() {
        mPlayer.seek(to: kCMTimeZero)
        mPlayer.play()
    }

    func didSelectProduct(_ collectionProductView: CollectionProductView) {
        let productId: Int? = collectionProductView.product?.productId
        if productId == nil {return}
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = productId
        productDetailVc.relationProducts = mProductList.products
        delegate?.nextVc(productDetailVc)

        LogManager.tapProduct(screenCode: mScreen.code, productId: productId!)
    }

    fileprivate func addMotionEffect() {
        let xAxis = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xAxis.minimumRelativeValue = -40
        xAxis.maximumRelativeValue = 40

        let yAxis = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yAxis.minimumRelativeValue = -40
        yAxis.maximumRelativeValue = 40

        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [xAxis, yAxis]
        mImgVMainVisual.addMotionEffect(effectGroup)
    }
}
