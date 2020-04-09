//
//  GscBaseViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/24.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import SwiftSpinner
import SCLAlertView
import AVFoundation
import AVKit

class GscBaseViewController: UIViewController {
    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL, Const.outAppInfoUvInfo, Const.outAppInfoSoftener, Const.outAppInfoNavigator]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL]
 
    private var mUpdateStatusClosure: ((ContentDownloadResult) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("GscBase.viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("GscBase.viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("GscBase.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("GscBase.viewDidDisappear")
    }
    func didTapPrev() {
       _ = self.navigationController?.popViewController(animated: false)
    }
    func didHeaderViewAction(_ type: GscHeaderViewActionType) {
        switch type {
        case .home:
            self.showTop()
            
        case .GSChome:
            self.showGSChome()
            
        case .play:
            self.playMovie()
            
        case .update:
            self.updateData()
            
        case .find:
            let toVc = UIViewController.GetViewControllerFromStoryboard("GscTopViewController", targetClass: GscTopViewController.self) as! GscTopViewController
            toVc.fromFindBtn = true
            self.navigationController?.pushViewController(toVc, animated: false)
            
        case .back:
            self.backVC()
            
        default:
            break
        }
    }

    func playMovie() {
        let path = Utility.getDocumentPath(String(format: "gsc_movie/gsc_movie/scMovie1.mp4"))
        let videoURL = NSURL(fileURLWithPath: path)
        let avPlayer: AVPlayer = AVPlayer(url: videoURL as URL)
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        NotificationCenter.default.addObserver(self, selector:#selector(self.endMovie),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayerVc.player?.currentItem)
        self.present(avPlayerVc, animated: true, completion: {
        })
        avPlayer.play()
    }
    
    func backVC() {
        _ = self.navigationController?.popViewController(animated: false)
    }
    

    func showTop() {
        print("showTop")
        print("長押しボタン")
        let toVc = UIViewController.GetViewControllerFromStoryboard("Main", targetClass: NavigationViewController.self) as! NavigationViewController
        let navigationController = UINavigationController(rootViewController: toVc)
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
    func showGSChome() {
        print("showGSChome")
        if LanguageConfigure.isSuncareStandAloneApp {
            let toVc = UIViewController.GetViewControllerFromStoryboard("GscTopViewController", targetClass: GscTopViewController.self) as! GscTopViewController
            self.navigationController?.pushViewController(toVc, animated: false)
        } else {
            let toVc = UIViewController.GetViewControllerFromStoryboard("Main", targetClass: NavigationViewController.self) as! NavigationViewController
            let navigationController = UINavigationController(rootViewController: toVc)
            navigationController.isNavigationBarHidden = true
            UIApplication.shared.keyWindow?.rootViewController = navigationController
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
    
    private func reloadUpdateStatus() {
        if DownloadConfigure.downloadStatus != .success{return}
        if mUpdateStatusClosure != nil {return}
        mUpdateStatusClosure = {  _ in
            self.mUpdateStatusClosure = nil
        }
        ContentDownloader.default.downloadUpdateStatus(completion: mUpdateStatusClosure)
    }
    
    private func complete() {
        DownloadConfigure.downloadStatus = .success
        SwiftSpinner.hide()
        self.reloadUpdateStatus()
    }
    
    private func error(message: String) {
        DownloadConfigure.downloadStatus = .failure
        SwiftSpinner.hide()
        SCLAlertView().showError("Error", subTitle: "please update")
        self.reloadUpdateStatus()
    }
    
    private func updateData() {
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

    @objc func endMovie() {
        print(#function)
    }
}
