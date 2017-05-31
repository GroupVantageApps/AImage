//
//  LifeStyleViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class LifeStyleViewController: UIViewController, NavigationControllerAnnotation, UICollectionViewDelegate, UICollectionViewDataSource, LifeStyleCollectionViewCellDelegate, UIScrollViewDelegate {

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

    private let mScreen = ScreenData(screenId: Const.screenIdLifeStyleBeauty)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = false

    var focusScreenIds: [Int]?
    var isShowVideo: Bool = true

    private var mFinishedAppear: Bool = false

    private var finished: ((_ afterIndex: Int) -> ())!
    private var mLifeStyles = [LifeStyle]()
    private var mCounts = [String: Int]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mCounts = LifeStyleBeautyCount.getCounts()
        let items = AppItemTable.getItems(screenId: Const.screenIdLifeStyleBeauty)
        let nextVcs = [
            LifeStyleFirstDetailViewController.self,
            LifeStyleSecondDetailViewController.self,
            LifeStyleThirdDetailViewController.self,
            LifeStyleFourthDetailViewController.self,
            ] as [AnyClass]

        (0..<nextVcs.count).forEach { i in
            let image = UIImage(named:("lifestyle" + String(i + 1)))

            let key = "0" + String(i + 1)
            var text: String = items[key]!
            text = text.replacingOccurrences(of: "\n", with: "<br>")
            var isFocus = false
            if focusScreenIds != nil && self.getLifeStyleIndexes(screenIds: focusScreenIds!).contains(i) {
                    isFocus = true
            }

            let lifestyle = LifeStyle(image: image!, text: text, isRecommend: false, nextVc: nextVcs[i], focus: isFocus)
            mLifeStyles.append(lifestyle)
        }
        mCollectionV.register(UINib(nibName: "LifeStyleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionV.allowsSelection = false

        mCollectionV.delegate = self
        mCollectionV.dataSource = self

        mScrollV.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mCollectionV.reloadData()
        if !isShowVideo {
            mAVPlayerV.removeFromSuperview()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !mFinishedAppear && isShowVideo {
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
        delegate?.showNavigationView(0.3)
        delegate?.hideVideoSkipButtonWithDuration(0.3)
        UIView.animateIgnoreInteraction(
            duration: 0.3,
            delay: 0,
            animations: { [unowned self] in
                self.mVMain.alpha = 1
            },
            completion: { finished in

        })
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
            cell.image = lifeStyle.image
            cell.text = lifeStyle.text
            cell.isRecommend = lifeStyle.isRecommend
            cell.index = indexPath.row / 2
            cell.mCountsLabel.text = String(mCounts[String(indexPath.row / 2)] ?? 0)
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
            let w = view.frame.size.width
            width = (w - (45 * 2) - (15 * 3)) / CGFloat(mLifeStyles.count)
        }
        let height: CGFloat = collectionView.height

        return CGSize(width: width, height: height)
    }

    func didSelect(index: Int) {

        var logItemId: String = ""

        if index == 0 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleFirstDetailViewController", targetClass: LifeStyleFirstDetailViewController.self) as! LifeStyleFirstDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "01"

        } else if index == 1 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleSecondDetailViewController", targetClass: LifeStyleSecondDetailViewController.self) as! LifeStyleSecondDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "02"

        } else if index == 2 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleThirdDetailViewController", targetClass: LifeStyleThirdDetailViewController.self) as! LifeStyleThirdDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "03"

        } else if index == 3 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard("LifeStyleFourthDetailViewController", targetClass: LifeStyleFourthDetailViewController.self) as! LifeStyleFourthDetailViewController
            self.delegate?.nextVc(nextVc)
            logItemId = "04"
        }

        LogManager.tapItem(screenCode: mScreen.code, itemId: logItemId)
    }

    func didTapRecommend(index: Int) {
        LifeStyleBeautyCount.incrementLocal(index: index)
        mCounts = LifeStyleBeautyCount.getCounts()
        mCollectionV.reloadData()
        let logItemId = "1" + String(index)
        print(logItemId)
        LogManager.tapLifeStyleItem(screenCode: mScreen.code, itemId: logItemId)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }
}
