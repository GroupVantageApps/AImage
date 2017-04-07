//
//  ScreenSaveViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/10/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ScreenSaveViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet private weak var mImgV: UIImageView!

    private let animator = Animator()
    private var mImages = [UIImage?]()
    private var mIndex: Int = 0

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.modalPresentationStyle = .overFullScreen
        self.transitioningDelegate = self
    }

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let items = AppItemTable.getItems(screenId: Const.screenIdScreenSaver)
//        items.forEach { (key: String, value: String) in
//            mImages.append(FileTable.getImage(Int(value)))
//        }
        mImages = [
            UIImage(named: "SHI-Web-F16-37_W27_HP_RougeRouge_opt.jpg"),
            UIImage(named: "SHI-Web-F16-39_W27_HP_Ultimune_opt.jpg"),
            ]
        self.mImgV.alpha = 0
        mImgV.image = mImages.first!
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animate(in: 2.0, stay: 3.0, out: 2.0)
    }

    private func updateImage() {
        mIndex += 1
        if mIndex > mImages.count - 1 {
            mIndex = 0
        }
        mImgV.image = mImages[mIndex]
    }

    private func animate(in fadein: TimeInterval, stay: TimeInterval, out fadeout: TimeInterval) {
        self.mImgV.alpha = 0
        UIView.animate(
            withDuration: fadein,
            animations: { [weak self] in
                self?.mImgV.alpha = 1
        }, completion: { [weak self] _ in
            UIView.animate(
                withDuration: fadeout,
                delay: stay,
                options: [],
                animations: {
                    self?.mImgV.alpha = 0
            },
                completion: { _ in
                    self?.updateImage()
                    self?.animate(in: fadein, stay: stay, out: fadeout)
            })
        })
    }

    // MARK: - UIViewControllerTransitioningDelegate

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // この画面に遷移してくるときに呼ばれるメソッド

        animator.presenting = true
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // この画面から遷移元に戻るときに呼ばれるメソッド
        animator.presenting = false
        return animator
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }
}

private class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 0.5
    var presenting = false // 遷移するときtrue（戻るときfalse）

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        var targetView: UIView!
        toVC?.beginAppearanceTransition(true, animated: true)
        fromVC?.beginAppearanceTransition(false, animated: true)
        if presenting {
            targetView = toVC!.view
            transitionContext.containerView.addSubview(targetView)
            targetView.alpha = 0
        } else {
            targetView = fromVC!.view
            targetView.alpha = 1
        }
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            animations: {
                if self.presenting {
                    targetView.alpha = 1
                } else {
                    targetView.alpha = 0
                }
        },
            completion: {_ in
                if !self.presenting {
                    targetView.removeFromSuperview()
                }
                transitionContext.completeTransition(true)
                toVC?.endAppearanceTransition()
                fromVC?.endAppearanceTransition()
        })
    }
}
