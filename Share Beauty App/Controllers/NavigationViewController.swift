//
//  ViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/19.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftSpinner
import SCLAlertView

protocol NavigationControllerDelegate: NSObjectProtocol {
    func nextVc<T: UIViewController>(_ toVc: T) where T: NavigationControllerAnnotation
    func prevVc()
    func pushVc<T: UIViewController>(_ toVc: T)
    func backRootVc()
    func requestReloadUpdateStatus()
    func showNavigationView(_ animateDuration: TimeInterval?)
    func hideNavigationView(_ animateDuration: TimeInterval?)
    func showVideoSkipButtonWithDuration(_ animateDuration: TimeInterval?, didTapFunction: @escaping () -> ())
    func hideVideoSkipButtonWithDuration(_ animateDuration: TimeInterval?)
	func setAboutShiseidoButtonEnabled(_ isEnabled: Bool)
    func setOutAppBtn()
}

protocol NavigationControllerAnnotation: NSObjectProtocol {
    var delegate: NavigationControllerDelegate? {get set}
    var theme: String? {get}
    var isEnterWithNavigationView: Bool {get}
}

@objc protocol NavigationControllerOptionAnnotation {
    @objc optional func willPrev()
    @objc optional func willBackRoot(isFromDelegate: Bool)
}

struct OutAppInfo {
    private(set) var title: String
    private(set) var url: URL

    init(title: String, url: String) {
        self.title = title
        self.url = URL(string: url)!
    }
}
class NavigationViewController: UIViewController, NavigationControllerDelegate, HeaderViewDelegate, NavigationViewDelegte, SideBarDelegate {

    private static let startScreenSaverSecond = 15
    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL, Const.outAppInfoUvInfo, Const.outAppInfoSoftener, Const.outAppInfoNavigator]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL]

    @IBOutlet weak fileprivate var mVContainer: UIView!
    @IBOutlet weak fileprivate var mHeaderView: HeaderView!
    @IBOutlet weak fileprivate var mNavigationView: NavigationView!
    @IBOutlet weak fileprivate var mSideBar: SideBar!
    @IBOutlet weak var mConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak var mConstraintRight: NSLayoutConstraint!
    @IBOutlet weak var mConstraintRightToLeft: NSLayoutConstraint!
    @IBOutlet weak var mConstriantWidth: NSLayoutConstraint!

    fileprivate var mDidTapSkipFunction: () -> () = {}
    fileprivate var mIsShowSideBar: Bool = false
    private var mScreensaveTimer: Timer?
    private var mUpdateStatusClosure: ((ContentDownloadResult) -> ())?
    
    var productIdForDeeplink: Int = 0
    var showEfficacy: Bool = false
    var lineIdForDeeplink: Int = 0
    var lineStepForDeepLink: Int = 0

    fileprivate func animateSideBar(_ show: Bool, completion: (() -> ())?) {
        if show {
            mSideBar.willMove(toSuperview: nil)
            self.view.layoutIfNeeded()
            mConstraintLeft.isActive = false
            mConstraintRight.isActive = false
            mConstriantWidth.isActive = true
            mConstraintRightToLeft.isActive = true
        } else {
            mConstraintRightToLeft.isActive = false
            mConstriantWidth.isActive = false
            mConstraintLeft.isActive = true
            mConstraintRight.isActive = true
        }
        UIView.animateIgnoreInteraction(
            duration: 0.3,
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                self.mIsShowSideBar = show
                completion?()
        })
    }

    let childVcLeftConstraint: String = "childVcleftConstraint"

    // MARK: - Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }

    @objc private func didBecomeActive() {
        self.reloadUpdateStatus()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topVc = UIViewController.GetViewControllerFromStoryboard("TopViewController", targetClass: TopViewController.self) as! TopViewController
        // for custom url scheme
        if productIdForDeeplink != 0 {
//            LoadingView.show(vc: self)
            topVc.productIdForDeeplink = productIdForDeeplink
            topVc.showEfficacy = showEfficacy
        }
        if lineIdForDeeplink != 0 {
            if lineStepForDeepLink != 0 {
                topVc.lineStepForDeepLink = lineStepForDeepLink
            }
//            LoadingView.show(vc: self)
            topVc.lineIdForDeeplink = lineIdForDeeplink
        }
        
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        mSideBar.delegate = self
        
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppFoundationInfos.map {$0.title})
        } else {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        }
        nextVc(topVc, animated: false)
        setOutAppBtn()
    }
    
    func setOutAppBtn() {
//        mHeaderView.setOutAppEnabled(!LanguageConfigure.isOutAppBtnHiddenCountry)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startNoGestureTimer()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.startNoGestureTimer()
    }

    private func startNoGestureTimer() {
        if !(self.children.last is TopViewController) || !Const.isShowScreenSaver { return }
        self.cancelNoGestureTimer()
        mScreensaveTimer = Timer.scheduledTimer(
            timeInterval: TimeInterval(NavigationViewController.startScreenSaverSecond),
            target: self,
            selector: #selector(self.fire),
            userInfo: nil,
            repeats: false)
    }

    private func cancelNoGestureTimer() {
        mScreensaveTimer?.invalidate()
    }

    @objc private func fire() {
        if !(self.children.last is TopViewController) { return }
        self.present(UIViewController.GetViewControllerFromStoryboard("ScreenSaveViewController", targetClass: ScreenSaveViewController.self), animated: true, completion:nil)
    }

    private func addContainerView(_ vcChild: UIViewController, readd: Bool) {
        if readd {
            mVContainer.insertSubview(vcChild.view, belowSubview: mVContainer.subviews.last!)
        } else {
            mVContainer.addSubview(vcChild.view)
        }

        vcChild.view.translatesAutoresizingMaskIntoConstraints = false

        let equalWidth = NSLayoutConstraint(item: vcChild.view, attribute: .width, relatedBy: .equal, toItem: mVContainer, attribute: .width, multiplier: 1.0, constant: 0)
        let equalHeight = NSLayoutConstraint(item: vcChild.view, attribute: .height, relatedBy: .equal, toItem: mVContainer, attribute: .height, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: vcChild.view, attribute: .top, relatedBy: .equal, toItem: mVContainer, attribute: .top, multiplier: 1.0, constant: 0)
        let left = NSLayoutConstraint(item: vcChild.view, attribute: .left, relatedBy: .equal, toItem: mVContainer, attribute: .left, multiplier: 1.0, constant: 0)

        mVContainer.addConstraints([equalWidth, equalHeight, top, left])
        self.view.layoutIfNeeded()
    }

    private func reloadUpdateStatus() {
        //Update Tap時に無理やりdevelopを向かせる　本番時は DownloadConfigure.target = DownloadConfigure.Target.release develop or release
        DownloadConfigure.target = DownloadConfigure.Target.release
        
        if DownloadConfigure.downloadStatus != .success{return}
        if mUpdateStatusClosure != nil {return}
        mUpdateStatusClosure = {  _ in
            self.mHeaderView.setUpdateEnabled(DownloadConfigure.isNeedUpdate)
            self.mUpdateStatusClosure = nil
        }
        ContentDownloader.default.downloadUpdateStatus(completion: mUpdateStatusClosure)
    }

    private func complete() {
        DownloadConfigure.downloadStatus = .success
        SwiftSpinner.hide()
        self.reloadUpdateStatus()
        
        //DownLoad完了時にTopを再読み込みする。
        let toVc = UIViewController.GetViewControllerFromStoryboard("Main", targetClass: NavigationViewController.self) as! NavigationViewController
        let navigationController = UINavigationController(rootViewController: toVc)
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }

    private func error(message: String) {
        DownloadConfigure.downloadStatus = .failure
        SwiftSpinner.hide()
        SCLAlertView().showError("Error", subTitle: "please update")
        self.reloadUpdateStatus()
    }

    private func updateData() {
        //Update Tap時に無理やりdevelopを向かせる 無理やり　develop or release
        DownloadConfigure.target = DownloadConfigure.Target.release
        
        ContentDownloader.default.download(completion: { result in
            switch result {
            case .success:
                ContentDownloader.default.downloadComplete(completion: { result in
                    switch result {
                    case .success:
                        self.complete()
                    case .failure(let error):
                        self.error(message: error.desctiption)
                    }
                })
            case .failure:
                ContentDownloader.default.downloadError(completion: { result in })
                switch result {
                case .failure(let error):
                    self.error(message: error.desctiption)
                default: break
                }
            }
        })
    }

    private func nextVc<T: UIViewController>(_ toVc: T, animated: Bool) where T: NavigationControllerAnnotation {
        self.cancelNoGestureTimer()
        toVc.delegate = self
        if animated {
            if let fromVc = children.last {
                addChild(toVc)
                fromVc.beginAppearanceTransition(false, animated: true)
                toVc.beginAppearanceTransition(true, animated: true)
                toVc.view.alpha = 0
                addContainerView(toVc, readd: false)
                let constraintleftFromVc: NSLayoutConstraint! = NSLayoutConstraint.findEqualLeft(mVContainer.constraints, item: fromVc.view, toItem: mVContainer)
                constraintleftFromVc.constant = -(mVContainer.width / 3)
                mNavigationView.animateEnter(0.3, options: .layoutSubviews)
                mNavigationView.setTheme(toVc.theme, duration: 0.3)
                toVc.view.left = mVContainer.width
                toVc.view.alpha = 1
                mNavigationView.show(toVc.isEnterWithNavigationView, animateDuration: nil)

                UIView.animateIgnoreInteraction(
                    duration: 0.3,
                    animations: {
                        self.view.layoutIfNeeded()
                    },
                    completion: { _ in
                        fromVc.endAppearanceTransition()
                        toVc.endAppearanceTransition()
                        toVc.didMove(toParent: self)
                        fromVc.view.removeFromSuperview()
                        LoadingView.dismiss(vc: self)
                })
            }
        } else {
            mNavigationView.setTheme(toVc.theme)
            addChild(toVc)
            addContainerView(toVc, readd: false)
            toVc.didMove(toParent: self)
            if let fromVc = children.last {
                if fromVc !== children.first {
                    fromVc.view.removeFromSuperview()
                }
            }
        }
    }

    fileprivate func prevVc(_ animated: Bool) {
        if let toVc: UIViewController = children[safe: children.endIndex - 2] {
            let fromVc: UIViewController = children.last!
            if let annotation = fromVc as? NavigationControllerOptionAnnotation {
                annotation.willPrev?()
            }
            fromVc.willMove(toParent: nil)
            toVc.beginAppearanceTransition(true, animated: true)
            fromVc.beginAppearanceTransition(false, animated: true)
            addContainerView(toVc, readd: true)
            let completion = {() -> Void in
                fromVc.view.removeFromSuperview()
                fromVc.endAppearanceTransition()
                toVc.endAppearanceTransition()
                fromVc.removeFromParent()
                if toVc is TopViewController {
                    self.startNoGestureTimer()
                }
            }

            if animated {
                let constraintleftFromVc: NSLayoutConstraint! = NSLayoutConstraint.findEqualLeft(mVContainer.constraints, item: fromVc.view, toItem: mVContainer)
                let constraintleftToVc: NSLayoutConstraint! = NSLayoutConstraint.findEqualLeft(mVContainer.constraints, item: toVc.view, toItem: mVContainer)
                constraintleftToVc.constant = -(mVContainer.width / 3)
                self.view.layoutIfNeeded()
                constraintleftFromVc.constant = fromVc.view.width
                constraintleftToVc.constant = 0

                let annotation = toVc as! NavigationControllerAnnotation
                if children.index(of: toVc) == 0 {
                    mNavigationView.animateExit(0.3, options: .layoutSubviews)
                } else {
                    mNavigationView.setTheme(annotation.theme, duration: 0.3)
                }

                UIView.animateIgnoreInteraction(
                    duration: 0.3,
                    animations: {
                        self.view.layoutIfNeeded()
                    },
                    completion: { _ in
                        completion()
                })
            } else {
                completion()
            }
        }
    }

    private func backRootVc(_ animated: Bool, isFromDelegate: Bool = false) {
        let toVc: UIViewController = children.first!
        let fromVc: UIViewController = children.last!

        if toVc === fromVc {
            return
        }

        self.children.forEach { vc in
            if let annotation = vc as? NavigationControllerOptionAnnotation {
                annotation.willBackRoot?(isFromDelegate: isFromDelegate)
            }
        }

        fromVc.willMove(toParent: nil)
        toVc.beginAppearanceTransition(true, animated: true)
        fromVc.beginAppearanceTransition(false, animated: true)
        addContainerView(toVc, readd: true)
        for childVc in self.children {
            if toVc === childVc || fromVc === childVc {
                continue
            }
            childVc.removeFromParent()
        }

        let completion = {() -> Void in
            fromVc.view.removeFromSuperview()
            fromVc.endAppearanceTransition()
            toVc.endAppearanceTransition()
            fromVc.removeFromParent()
            self.startNoGestureTimer()
        }

        if animated {
            let constraintleftFromVc: NSLayoutConstraint! = NSLayoutConstraint.findEqualLeft(mVContainer.constraints, item: fromVc.view, toItem: mVContainer)
            let constraintleftToVc: NSLayoutConstraint! = NSLayoutConstraint.findEqualLeft(mVContainer.constraints, item: toVc.view, toItem: mVContainer)
            constraintleftToVc.constant = -(mVContainer.width / 3)
            self.view.layoutIfNeeded()
            constraintleftFromVc.constant = fromVc.view.width
            constraintleftToVc.constant = 0

            let annotation = toVc as! NavigationControllerAnnotation
            if children.index(of: toVc) == 0 {
                mNavigationView.animateExit(0.3, options: .layoutSubviews)
            } else {
                mNavigationView.setTheme(annotation.theme, duration: 0.3)
            }

            UIView.animateIgnoreInteraction(
                duration: 0.3,
                animations: {
                    self.view.layoutIfNeeded()
                },
                completion: { _ in
                    completion()
            })
        } else {
            completion()
        }
    }

    fileprivate func showTop() {
        mHeaderView.showSkipButton(false, animateDuration: 0.3)
        mDidTapSkipFunction = {}
        self.backRootVc(true)
    }
	
	/// 資生堂About画面への遷移
	fileprivate func showAboutShiseido() {
//        let vc = AboutShiseidoBrandViewController()
        let vc = UIViewController.GetViewControllerFromStoryboard("AboutShiseidoImageViewController", targetClass: AboutShiseidoImageViewController.self) as! AboutShiseidoImageViewController
		self.nextVc(vc, animated: true)
	}
    
    fileprivate func showNewApproach() {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: NewApproachViewController.self) as! NewApproachViewController
        self.nextVc(nextVc, animated:true)
    }

    // MARK: - NavigationControllerDelegate

    func nextVc<T: UIViewController>(_ toVc: T) where T: NavigationControllerAnnotation {
        animateSideBar(false, completion: {
            self.nextVc(toVc, animated: true)
        })
    }

    func prevVc() {
        animateSideBar(false, completion: {
            self.prevVc(true)
        })
    }

    func backRootVc() {
        animateSideBar(false, completion: {

            self.backRootVc(true, isFromDelegate: true)
        })
    }

    func requestReloadUpdateStatus() {
        self.reloadUpdateStatus()
    }

    func showNavigationView(_ animateDuration: TimeInterval?) {
        mNavigationView.show(true, animateDuration: animateDuration)
    }

    func hideNavigationView(_ animateDuration: TimeInterval?) {
        mNavigationView.show(false, animateDuration: animateDuration)
    }

    func showVideoSkipButtonWithDuration(_ animateDuration: TimeInterval?, didTapFunction: @escaping () -> ()) {
        mHeaderView.showSkipButton(true, animateDuration: animateDuration)
        mDidTapSkipFunction = didTapFunction
    }

    func hideVideoSkipButtonWithDuration(_ animateDuration: TimeInterval?) {
        mHeaderView.showSkipButton(false, animateDuration: animateDuration)
        mDidTapSkipFunction = {}
    }
	
	func setAboutShiseidoButtonEnabled(_ isEnabled: Bool) {
		mHeaderView.setAboutShiseidoEnabled(isEnabled)
	}

    // MARK: - HeaderViewDelegate

    func didHeaderViewAction(_ type: HeaderViewActionType) {
        switch type {
        case .home:
            animateSideBar(false, completion: {
                self.showTop()
            })
        case .list:
            animateSideBar(!mIsShowSideBar, completion: nil)
        case .skip:
            mDidTapSkipFunction()
        case .update:
            self.updateData()
		case .shiseido:
			self.showAboutShiseido()
        case .newApproach:
            self.showNewApproach()
        }
    }
    

    func didSelectOutApp(index: Int) {
        let outAppInfo = type(of: self).outAppInfos[index]
        
        if UIApplication.shared.canOpenURL(outAppInfo.url) {
            UIApplication.shared.openURL(outAppInfo.url)
        } else {
            let alertVc = UIAlertController(
                title: "Warning",
                message: "App is not installed",
                preferredStyle: .alert
            )
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVc.addAction(defaultAction)
            self.present(alertVc, animated: true, completion: nil)
        }
    }

    // MARK: - NavigationViewDelegate

    func didTapPrev() {
        animateSideBar(false, completion: {
            self.prevVc(true)
        })
    }
    func pushVc<T: UIViewController>(_ toVc: T) {
        let navigationController = UINavigationController(rootViewController: toVc)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }

    // MARK: - SideBarDelegate

    func didHSideBarAction(_ type: SideBarActionType) {
        animateSideBar(false, completion: {
            let currentVc = self.children.last
            switch type {
            case .home:
                self.showTop()
            case .recommended:
                if !(currentVc is RecommendedViewController) {
                    let recommendedVc = UIViewController.GetViewControllerFromStoryboard("RecommendedViewController", targetClass: RecommendedViewController.self) as! RecommendedViewController
                    self.nextVc(recommendedVc, animated: true)
                }
            case .settings:
                if !(currentVc is SettingViewController ||
                    currentVc is CountrySettingViewController ||
                    currentVc is TargetSettingViewController ||
                    currentVc is LanguageSettingViewController) {
                    let settingVc = UIViewController.GetViewControllerFromStoryboard(targetClass: SettingViewController.self) as! SettingViewController
                    self.nextVc(settingVc, animated: true)
                }
            }
        })
    }

    func nextVcFromSideBar<T: UIViewController>(_ nextVc: T) where T: NavigationControllerAnnotation {
        print(nextVc.self)
        let classNameNextVc = NSStringFromClass(type(of: nextVc))
        let classNameLastVc = NSStringFromClass(type(of: self.children.last!))
        animateSideBar(false, completion: {
            if classNameNextVc != classNameLastVc {
                self.nextVc(nextVc, animated: true)
            }
        })
    }
}
