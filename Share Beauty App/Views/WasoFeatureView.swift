//
//  WasoFeatureView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import APNGKit


class WasoFeatureView: BaseView {
    @IBOutlet weak private var apngImageV: APNGImageView!
    @IBOutlet weak private var mRightImageV: UIImageView!
    @IBOutlet weak private var mVShake: UIView!
    @IBOutlet weak var mConstraintShakeCenter: NSLayoutConstraint!
    @IBOutlet weak var mConstraintShakeTop: NSLayoutConstraint!
    @IBOutlet weak private var mLblhukidashi: UILabel!

    private var mIsShowHukidashi = false
	
	fileprivate var guideFrameView: UIView? = nil
	fileprivate var guideIconView: UIImageView? = nil
	fileprivate var onGuideFrameImageView: UIImageView? = nil
    
    var hukidashi_tap_enable: Bool = true
    
    deinit {
        apngImageV.startAnimating()
        apngImageV.image = nil
    }

    var apng: APNGImage? {
        didSet {
            if apng != nil {
                apngImageV.image = apng
            }
        }
    }
    var image: UIImage? {
        didSet {
            mRightImageV.image = image
        }
    }
    var hukidashiText: String? {
        didSet {
            mLblhukidashi.text = hukidashiText
        }
    }

    func startAnimation() {
        apngImageV.startAnimating()
    }
	
	/// タップ案内view表示
	func showGuideView(frameColor: UIColor) {
		guard let image = self.image else {
			return
		}
		
		if self.guideFrameView != nil {
			return
		}
		
		let arrowImage = #imageLiteral(resourceName: "button_waso_feature_show_hukidashi")
		let insetValue: CGFloat = 3.0	// フレーム余白
		
		// 新しいimageViewのframe最大値を求める
		var maxImageViewFrame = self.mRightImageV.bounds.insetBy(dx: insetValue, dy: insetValue)
		maxImageViewFrame.size.width -= arrowImage.size.width
		
		// 画像の縮小率を計算する
		let reductionRatio = min(maxImageViewFrame.width / image.size.width, maxImageViewFrame.height / image.size.height)
		
		// 縮小率を適用した場合の画像サイズを求める
		let reductionImageSize = CGSize(width: image.size.width * reductionRatio, height: image.size.height * reductionRatio) 
		
		// mRightImageVをコンテナとして扱い、新しく案内view及び画像viewを構成する
		self.mRightImageV.image = nil
		self.mRightImageV.backgroundColor = UIColor.clear
		
		// 適用後画像サイズを基準に、各view.frameを決める
		// image view
		self.onGuideFrameImageView = UIImageView(frame: CGRect(x: arrowImage.size.width + insetValue, y: (self.mRightImageV.height - reductionImageSize.height) / 2, width: reductionImageSize.width, height: reductionImageSize.height))
		guard let onGuideFrameImageView = self.onGuideFrameImageView else {
			return
		}
		onGuideFrameImageView.contentMode = .scaleAspectFit
		onGuideFrameImageView.image = image
		
		// frame view
		var guideFrame = onGuideFrameImageView.bounds.insetBy(dx: -insetValue, dy: -insetValue)
		guideFrame.size.width += arrowImage.size.width
		self.guideFrameView = UIView(frame: CGRect(x: 0.0, y: (self.mRightImageV.height - guideFrame.height) / 2, width: guideFrame.width, height: guideFrame.height))
		guard let guideFrameView = self.guideFrameView else {
			return
		}
		guideFrameView.backgroundColor = frameColor
		guideFrameView.isUserInteractionEnabled = false
		
		// arrow icon
		self.guideIconView = UIImageView(frame: CGRect(x: 0.0, y: guideFrameView.frame.origin.y, width: arrowImage.size.width, height: guideFrameView.height))
		guard let iconView = self.guideIconView else {
			return
		}
		iconView.contentMode = .scaleAspectFit
		iconView.image = arrowImage
		
		self.mRightImageV.addSubview(guideFrameView)
		self.mRightImageV.addSubview(iconView)
		self.mRightImageV.addSubview(onGuideFrameImageView)
	}
	
	/// 案内フレームのアニメーション
	func beginGuideFrameAnimation() {
		guard let frameView = self.guideFrameView else {
			return
		}
		
		UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseOut], animations: {
			frameView.alpha = 0.2
		}, completion: { flg in
			frameView.alpha = 1.0
		})
	}

    private func showHukidashi() {
        if mIsShowHukidashi { return }

        mVShake.alpha = 0
        mConstraintShakeCenter.isActive = false
        mConstraintShakeTop.isActive = true
        self.layoutIfNeeded()

        mConstraintShakeTop.isActive = false
        mConstraintShakeCenter.isActive = true

        UIView.animateIgnoreInteraction(
            duration: 1,
            animations: {
                self.mVShake.alpha = 1
                self.layoutIfNeeded()
        }, completion: { _ in
            self.mIsShowHukidashi = true
        })
    }

    private func hideHukidashi() {
        if !mIsShowHukidashi { return }
        UIView.animateIgnoreInteraction(
            duration: 0.3,
            animations: {
                self.mVShake.alpha = 0
        }, completion: { _ in
            self.mIsShowHukidashi = false
        })
    }

    @IBAction func onTapImage(_ sender: Any) {
        if self.hukidashi_tap_enable {
            self.showHukidashi()
        }
    }

    @IBAction func onTapClose(_ sender: Any) {
        self.hideHukidashi()
    }
}
