//
//  TopViewController.swift
//  Share Beauty App
//
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TopViewController: UIViewController, NavigationControllerAnnotation {
    @IBOutlet private var mBtnMenus: [BaseButton]!
    @IBOutlet private var mHelpImgVs: [UIImageView]!
    @IBOutlet private var mVMenuContainer: UIView!
    @IBOutlet private weak var mImgVMainVisual: UIImageView!

    private let mScreen = ScreenData(screenId: Const.screenIdTop)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = false

    private var mTimer: Timer?
    private var mTimerAnimation: Timer?
    private var mGuardView: UIView?
    private var mIsShowHelpAnimation = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TopViewController.viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate?.requestReloadUpdateStatus()
        let fileId = AppItemTable.getMainImageByItemId(itemId: 7911).first
        mImgVMainVisual.image = FileTable.getImage(fileId)

        let imageItemIds = [
            (main: 7785, discription: 7837),
            (main: 7786, discription: 7838),
            (main: 7788, discription: 7840),
            (main: 7787, discription: 7839),
            (main: 7790, discription: 7841),
            (main: 7842, discription: 7843),
            ]
        imageItemIds.enumerated().forEach { (i: Int, element: (main: Int, discription: Int)) in

            let frontFileId = AppItemTable.getMainImageByItemId(itemId: element.main)
            if let frontImage = FileTable.getImage(frontFileId.first) {
                if let width = NSLayoutConstraint.findWidth(mBtnMenus[i].constraints, item: mBtnMenus[i]) {
                    mBtnMenus[i].removeConstraint(width)
                }
                if let height = NSLayoutConstraint.findHeight(mBtnMenus[i].constraints, item: mBtnMenus[i]) {
                    mBtnMenus[i].removeConstraint(height)
                }
                let width = NSLayoutConstraint.makeWidth(item: mBtnMenus[i], constant: frontImage.size.width / 2)
                let height = NSLayoutConstraint.makeHeight(item: mBtnMenus[i], constant: frontImage.size.height / 2)
                mBtnMenus[i].addConstraints([width, height])
                mBtnMenus[i].setImage(frontImage, for: .normal)
            }

            let backFileId = AppItemTable.getMainImageByItemId(itemId: element.discription)
            if let backImage = FileTable.getImage(backFileId.first) {
                if let width = NSLayoutConstraint.findWidth(mHelpImgVs[i].constraints, item: mBtnMenus[i]) {
                    mHelpImgVs[i].removeConstraint(width)
                }
                if let height = NSLayoutConstraint.findHeight(mHelpImgVs[i].constraints, item: mBtnMenus[i]) {
                    mHelpImgVs[i].removeConstraint(height)
                }
                let width = NSLayoutConstraint.makeWidth(item: mHelpImgVs[i], constant: backImage.size.width / 2)
                let height = NSLayoutConstraint.makeHeight(item: mHelpImgVs[i], constant: backImage.size.height / 2)
                mHelpImgVs[i].addConstraints([width, height])
                mHelpImgVs[i].image = backImage
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        print("TopViewController.viewDidAppear")
        super.viewDidAppear(animated)
        viewDidAppearOnce {
            self.fadeInMenu()
        }
        self.startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("TopViewController.viewWillDisappear")
        self.stopTimer()
        self.stopHelpAnimation()
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("TopViewController.viewDidDisappear")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !mIsShowHelpAnimation {
            self.stopTimer()
            self.startTimer()
        }
    }

    private func animateFadeInWithExpantion(target: UIView, delay: TimeInterval, completion: (() -> ())? = nil) {

        target.addConstraint(NSLayoutConstraint.makeWidth(item: target, constant: 0))
        target.addConstraint(NSLayoutConstraint.makeHeight(item: target, constant: 0))

        self.view.layoutIfNeeded()
        target.alpha = 0

        NSLayoutConstraint.findWidth(target.constraints, item: target, constant: 0)?.isActive = false
        NSLayoutConstraint.findHeight(target.constraints, item: target, constant: 0)?.isActive = false

        UIView.animate(
            withDuration: 0.5,
            delay: delay,
            animations: {
                target.alpha = 1
                self.view.layoutIfNeeded()
        },
            completion: { _ in
                completion?()
        })
    }

    private func animateFadeOut(target: UIView, delay: TimeInterval, completion: (() -> ())? = nil) {
        target.alpha = 1
        UIView.animate(
            withDuration: 0.5,
            delay: delay,
            animations: {
                target.alpha = 0
        },
            completion: { _ in
                completion?()
        })
    }


    private func fadeInMenu(delay: TimeInterval = 0, completion: (() -> ())? = nil) {
        mBtnMenus.enumerated().forEach { (i: Int, btnMenu: BaseButton) in
            var closure: (() -> ())? = nil
            if self.mBtnMenus.last == btnMenu {
                closure = completion
            }
            self.animateFadeInWithExpantion(target: btnMenu, delay: TimeInterval(Float(i) / 10) + delay, completion: closure)
        }
    }

    private func fadeOutMenu(delay: TimeInterval = 0, completion: (() -> ())? = nil) {
        mBtnMenus.enumerated().forEach { (i: Int, btnMenu: BaseButton) in
            var closure: (() -> ())? = nil
            if self.mBtnMenus.last == btnMenu {
                closure = completion
            }
            self.animateFadeOut(target: btnMenu, delay: TimeInterval(Float(i) / 10) + delay, completion: closure)
        }
    }

    private func fadeInHelp(delay: TimeInterval = 0, completion: (() -> ())? = nil) {
        mHelpImgVs.enumerated().forEach { (i: Int, imgVHelp: UIImageView) in
            var closure: (() -> ())? = nil
            if self.mHelpImgVs.last == imgVHelp {
                closure = completion
            }
            self.animateFadeInWithExpantion(target: imgVHelp, delay: TimeInterval(Float(i) / 10) + delay, completion: closure)
        }
    }

    private func fadeOutHelp(delay: TimeInterval = 0, completion: (() -> ())? = nil) {
        mHelpImgVs.enumerated().forEach { (i: Int, imgVHelp: UIImageView) in
            var closure: (() -> ())? = nil
            if self.mHelpImgVs.last == imgVHelp {
                closure = completion
            }
            self.animateFadeOut(target: imgVHelp, delay: TimeInterval(Float(i) / 10) + delay, completion: closure)
        }
    }

    private func startTimer() {
        print("startTimer")
        mTimer = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(self.showHelp), userInfo: nil, repeats: false)
    }

    private func stopTimer() {
        print("stopTimer")
        mTimer?.invalidate()
        mTimer = nil
    }

    private func startTimerAnimation(delay: TimeInterval = 0) {
        mTimerAnimation?.invalidate()
        mTimerAnimation = Timer.scheduledTimer(
            timeInterval: delay,
            target: self,
            selector: #selector(helpAnimation),
            userInfo: nil,
            repeats: false
        )
    }

    @objc private func helpAnimation() {
        self.fadeOutMenu(
            delay: 0, completion: { _ in
                if !self.mIsShowHelpAnimation {return}
                self.setGuardViewIfneeded()
                self.fadeInHelp(delay: 0, completion: { _ in
                    if !self.mIsShowHelpAnimation {return}
                    self.fadeOutHelp(delay: 15, completion: { _ in
                        if !self.mIsShowHelpAnimation {return}
                        self.fadeInMenu(delay: 0, completion: { _ in
                            if !self.mIsShowHelpAnimation {return}
                            self.removeGuardView()
                            self.startTimerAnimation(delay: 15)
                        })
                    })
                })
        })
    }

    private func setGuardViewIfneeded() {
        if mGuardView != nil {return}

        mGuardView = UIView()
        mGuardView!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mGuardView!)

        let left = NSLayoutConstraint.equalLeftEdge(item: mGuardView!, toItem: self.view)
        let right = NSLayoutConstraint.equalRightEdge(item: mGuardView!, toItem: self.view)
        let top = NSLayoutConstraint.equalTopEdge(item: mGuardView!, toItem: self.view)
        let bottom = NSLayoutConstraint.equalBottomEdge(item: mGuardView!, toItem: self.view)

        self.view.addConstraints([left, right, top, bottom])
        mGuardView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapGuardView(tap:))))
    }

    private func removeGuardView() {
        self.mGuardView?.removeFromSuperview()
        self.mGuardView = nil
    }

    private func resetMenus() {
        mBtnMenus.enumerated().forEach { (i: Int, target: BaseButton) in
            target.layer.removeAllAnimations()
            NSLayoutConstraint.findWidth(target.constraints, item: target, constant: 0)?.isActive = false
            NSLayoutConstraint.findHeight(target.constraints, item: target, constant: 0)?.isActive = false
            target.alpha = 1
            self.view.layoutIfNeeded()
        }
        mHelpImgVs.enumerated().forEach { (i: Int, target: UIImageView) in
            target.layer.removeAllAnimations()
            NSLayoutConstraint.findWidth(target.constraints, item: target, constant: 0)?.isActive = false
            NSLayoutConstraint.findHeight(target.constraints, item: target, constant: 0)?.isActive = false
            target.alpha = 0
            self.view.layoutIfNeeded()
        }
    }

    private func stopHelpAnimation() {
        mIsShowHelpAnimation = false
        mTimerAnimation?.invalidate()
        self.resetMenus()
        self.removeGuardView()
    }

    @objc private func showHelp() {
        mIsShowHelpAnimation = true
        self.startTimerAnimation()
    }

    @objc private func onTapGuardView(tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        for btn in mBtnMenus {
            if btn.convert(btn.bounds, to: view).contains(point) {
                btn.tag == 5 ? onTapSignatureBeauty(btn) : onTapMenu(btn)
                return
            }
        }
    }

    @IBAction private func onTapMenu(_ sender: AnyObject) {
        print("onTapMenu tag:" + sender.tag.description)
        let arrNextVc: [AnyClass] = [IdealFirstSelectViewController.self,
                                     LifeStyleViewController.self,
                                     IconicViewController.self,
                                     OnTrendViewController.self,
                                     MakeupViewController.self,
                                     ]

        var logItemId: String = ""

        if IdealFirstSelectViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard(targetClass: arrNextVc[sender.tag]) as! IdealFirstSelectViewController
            delegate?.nextVc(toVc)
            logItemId = "01"

        } else if LifeStyleViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard(targetClass: arrNextVc[sender.tag]) as! LifeStyleViewController
            delegate?.nextVc(toVc)
            logItemId = "02"

        } else if IconicViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard(targetClass: arrNextVc[sender.tag]) as! IconicViewController
            delegate?.nextVc(toVc)
            logItemId = "03"

        } else if OnTrendViewController.self == arrNextVc[sender.tag] {
            let toVc = UIViewController.GetViewControllerFromStoryboard(targetClass: arrNextVc[sender.tag]) as! OnTrendViewController
            delegate?.nextVc(toVc)
            logItemId = "04"

        } else if MakeupViewController.self == arrNextVc[sender.tag] {
            let lineListVc = UIViewController.GetViewControllerFromStoryboard(targetClass: MakeupViewController.self) as! MakeupViewController
            delegate?.nextVc(lineListVc)
            logItemId = "05"
        }
        LogManager.tapItem(screenCode: mScreen.code, itemId: logItemId)
    }

    @IBAction func onTapSignatureBeauty(_ sender: AnyObject) {
        let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryViewController", targetClass: LuxuryViewController.self) as! LuxuryViewController
        delegate?.pushVc(toVc)
        LogManager.tapItem(screenCode: mScreen.code, itemId: "06")
    }
}
