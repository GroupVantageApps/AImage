//
//  IdealFirstSelectViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/22.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class IdealFirstSelectViewController: UIViewController, NavigationControllerAnnotation, IdealSelectCollectionViewDelegate {
    @IBOutlet weak fileprivate var mIdealSelectCollectionVFirst: IdealSelectCollectionView!
    @IBOutlet weak fileprivate var mIdealSelectCollectionV: IdealSelectCollectionView!
    @IBOutlet weak fileprivate var mAVPlayerV: AVPlayerView!
    @IBOutlet weak fileprivate var mBtnNext: BaseButton!

    @IBOutlet weak var mItemTitle: UILabel!

    private let mScreen = ScreenData(screenId: Const.screenIdIdealBeauty1)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    var items: [String: String]!
    var layouted: Bool = false

    fileprivate weak var mPlayer: AVPlayer!
    fileprivate var mAspect: CGFloat = 1.0
    fileprivate var mSelectedLineIds: [Int] = []
    fileprivate var mIdealSelectCellCount = 0 {
        didSet {
            mBtnNext.isHidden = (mIdealSelectCellCount == 0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("IdealFirstSelectViewController.viewDidLoad")
        let idealBeautyLines = IdealBeautyLinesData()

        if var lines = idealBeautyLines.lines {
            if lines.first != nil {
                mIdealSelectCollectionVFirst.lines = [lines.first!]
                lines.removeFirst()
            }
            mIdealSelectCollectionV.lines = lines
            mAspect = CGFloat(ceilf(Float(lines.count) / Float(mIdealSelectCollectionV.horizontalCellCount)))
        }

        mIdealSelectCollectionVFirst.delegate = self
        mIdealSelectCollectionV.delegate = self

        items = AppItemTable.getItems(screenId: Const.screenIdIdealBeauty1)
        Utility.log(items)
        mItemTitle.text = items["01"]
    }

    fileprivate func createVideo() {
        let videoPath = Bundle.main.path(forResource: "ideal_background", ofType:"mp4")
        let videoURL = URL(fileURLWithPath: videoPath!)
        mPlayer = AVPlayer(url: videoURL)

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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !layouted {
            let height = NSLayoutConstraint(item: mIdealSelectCollectionVFirst, attribute: .height, relatedBy: .equal, toItem: mIdealSelectCollectionV, attribute: .height, multiplier: (1.0 / mAspect), constant: -((mAspect - 1) * mIdealSelectCollectionV.space / mAspect))
            mIdealSelectCollectionV.superview!.addConstraint(height)
        } else {
            layouted = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onTapNext(_ sender: AnyObject) {
        if mSelectedLineIds.count == 1 && mSelectedLineIds.first == 2 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealResultViewController.self) as! IdealResultViewController
            nextVc.selectedLineIds = mSelectedLineIds
            delegate?.nextVc(nextVc)
        } else {
            let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealSecondSelectViewController.self) as! IdealSecondSelectViewController
            nextVc.selectedLineIds = mSelectedLineIds
            delegate?.nextVc(nextVc)
        }
    }
    @IBAction func onTapNewApproach(_ sender: Any) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: NewApproachViewController.self) as! NewApproachViewController
        delegate?.nextVc(nextVc)
    }

    func didFinishPlaying() {
        mPlayer.seek(to: kCMTimeZero)
        mPlayer.play()
    }

    // MARK: - IdealSelectCollectionViewDelegate
    func didTapCell(_ sender: IdealSelectCell) {
        let line = sender.line!
        if sender.selected {
            mSelectedLineIds.append(line.lineId)
        } else {
            if let index = (mSelectedLineIds.index { $0 == line.lineId }) {
                mSelectedLineIds.remove(at: index)
            }
        }
        
        //Suncareボタンをtapした場合 GSCへ遷移 
        if line.lineId == 17 {
            let toVc = UIViewController.GetViewControllerFromStoryboard("GscTopViewController", targetClass: GscTopViewController.self) as! GscTopViewController
            delegate?.pushVc(toVc)
        }
    }
    func didSelectCellSomeone(_ sender: IdealSelectCollectionView) {
        print("didSelectCellSomeone")
        mIdealSelectCellCount += 1
    }
    func didSelectCellNone(_ sender: IdealSelectCollectionView) {
        print("didSelectCellNone")
        mIdealSelectCellCount -= 1
    }
}
