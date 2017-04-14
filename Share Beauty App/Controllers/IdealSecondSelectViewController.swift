//
//  IdealThirdSelectViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/22.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation

class IdealSecondSelectViewController: UIViewController, NavigationControllerAnnotation, IdealSelectCollectionViewDelegate {
    @IBOutlet weak fileprivate var mIdealSelectCollectionV: IdealSelectCollectionView!
    @IBOutlet weak fileprivate var mVShowResult: UIView!
    @IBOutlet weak fileprivate var mAVPlayerV: AVPlayerView!

    @IBOutlet weak var mButtonView: BaseButton!
    @IBOutlet weak var mBtnAllItem: UIButton!
    @IBOutlet weak var mItemTitle: UILabel!

    private let mScreen = ScreenData(screenId: Const.screenIdIdealBeauty3)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    var selectedLineIds: [Int]?

    var items: [String: String]!

    fileprivate var mPlayer: AVPlayer!
    fileprivate var mStepLowerIds: [Int] = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("IdealSecondSelectViewController.viewDidLoad")
        mIdealSelectCollectionV.delegate = self
        let idealBeautySecondsData = IdealBeautySecondsData(lineIds: selectedLineIds!)
        mIdealSelectCollectionV.stepLowers = idealBeautySecondsData.stepLowers

        items = AppItemTable.getItems(screenId: Const.screenIdIdealBeauty3)
        Utility.log(items)
        mItemTitle.text = items["01"]
        mButtonView.titleLabel?.text = items["02"]
        mBtnAllItem.setTitle(items["03"], for: .normal)
        mBtnAllItem.setTitle(items["03"], for: .selected)
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
        print("IdealThirdSelectViewController.viewWillAppear")
        self.createVideo()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("IdealThirdSelectViewController.viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("IdealThirdSelectViewController.viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("IdealThirdSelectViewController.viewDidDisappear")
        self.removeVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onTapButton(_ sender: AnyObject) {
        let nextVc = UIViewController.GetViewControllerFromStoryboard("IdealResultViewController", targetClass: IdealResultViewController.self) as! IdealResultViewController
        if selectedLineIds != nil {
            nextVc.selectedLineIds = selectedLineIds!
        }
        nextVc.selectedStepLowerIds = mStepLowerIds
        delegate?.nextVc(nextVc)
    }
    
    @IBAction func onTapAllItem(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            mStepLowerIds = mIdealSelectCollectionV.stepLowers.filter {$0.valid == 1}.map {$0.stepLowerId}
            mIdealSelectCollectionV.selectAllCells()
        } else {
            mStepLowerIds = []
            mIdealSelectCollectionV.deselectAllCells()
        }
        mVShowResult.isHidden = !sender.isSelected
    }
    @IBAction func onTapBack(_ sender: AnyObject) {
        delegate?.prevVc()
    }

    func didFinishPlaying() {
        mPlayer.seek(to: kCMTimeZero)
        mPlayer.play()
    }

    // MARK: - IdealSelectCollectionViewDelegate
    func didTapCell(_ sender: IdealSelectCell) {
        let stepLower = sender.stepLower!
        if sender.selected {
            mStepLowerIds.append(stepLower.stepLowerId)
        } else {
            if let index = mStepLowerIds.index(where: { $0 == stepLower.stepLowerId }) {
                mStepLowerIds.remove(at: index)
            }
        }
    }
    func didSelectCellSomeone(_ sender: IdealSelectCollectionView) {
        print("didSelectCellSomeone")
        mVShowResult.isHidden = false
    }
    func didSelectCellNone(_ sender: IdealSelectCollectionView) {
        print("didSelectCellNone")
        mVShowResult.isHidden = true
    }
}
