//
//  IconicViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class IconicViewController: UIViewController, NavigationControllerAnnotation, CollectionProductViewDelegate {

    @IBOutlet weak fileprivate var mPagingProductV: PagingProductView!
    @IBOutlet weak private var mAVPlayerV: AVPlayerView!

    private let mScreen = ScreenData(screenId: Const.screenIdIconicBeauty)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    private weak var mPlayer: AVPlayer!
    private var mProductList: ProductListData!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        mPagingProductV.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewWillAppear")
        createVideo()
        mProductList = ProductListData(screenId: Const.screenIdIconicBeauty)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsOnce {
            self.view.layoutIfNeeded()
            mPagingProductV.products = mProductList.products
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("IdealFirstSelectViewController.viewDidDisappear")
        removeVideo()
    }

    private func createVideo() {
        guard let movies = AppItemTable.getJsonByItemId(itemId: 7814)?["movie"].arrayObject as? [Int],
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
    private func removeVideo() {
        NotificationCenter.default.removeObserver(self)
        let layer = mAVPlayerV.layer as! AVPlayerLayer
        layer.player = nil
    }

    func didFinishPlaying() {
        mPlayer.seek(to: kCMTimeZero)
        mPlayer.play()
    }

    func didSelectProduct(_ targetCollectionProductView: CollectionProductView) {
        let productId: Int? = targetCollectionProductView.product?.productId
        if productId == nil {return}
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = productId
        productDetailVc.relationProducts = mProductList.products
        delegate?.nextVc(productDetailVc)

        LogManager.tapProduct(screenCode: mScreen.code, productId: productId!)
    }
}
