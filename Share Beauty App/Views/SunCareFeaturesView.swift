//
//  UtmFeaturesView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SunCareFeaturesView: BaseView {
    @IBOutlet weak private var mVBalloon1: UIView!
    @IBOutlet weak private var mVBalloon2: UIView!
    @IBOutlet weak private var mVBalloon3: UIView!

    @IBOutlet weak private var mImgBalloon1: UIImageView!
    @IBOutlet weak private var mImgBalloon2: UIImageView!
    @IBOutlet weak private var mImgBalloon3: UIImageView!

    @IBOutlet weak private var mImghukidashi: UIImageView!
    @IBOutlet weak private var mLblhukidashi: UILabel!

    @IBOutlet weak private var mLblBalloon1: UILabel!
    @IBOutlet weak private var mLblBalloon2: UILabel!
    @IBOutlet weak private var mLblBalloon3: UILabel!

    @IBOutlet weak private var mButtonBalloon1: BaseButton!
    @IBOutlet weak private var mButtonBalloon2: BaseButton!
    @IBOutlet weak private var mButtonBalloon3: BaseButton!
    @IBOutlet weak private var mVShake: UIView!

    @IBOutlet weak private var mButton1: BaseButton!
    @IBOutlet weak private var mConstraintTopShake: NSLayoutConstraint!

    weak var delegate: UtmFeaturesViewDelegate?
    var isSCP = false
    var isGSC = true
    var isGSCFragrance = false

    private var mSSArr: [String]!
    private var mShowTag: Int = 0

    @IBInspectable var topPadding: CGFloat = 0 {
        didSet {
            mConstraintTop.constant = topPadding
        }
    }
    @IBInspectable var bottomPadding: CGFloat = 0 {
        didSet {
            mConstraintBottom.constant = bottomPadding
        }
    }
    @IBOutlet weak private var mConstraintTop: NSLayoutConstraint!
    @IBOutlet weak private var mConstraintBottom: NSLayoutConstraint!

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        let utmArr = UIUtil.getUtmArray() as AnyObject as! [String]
        mButton1.setTitle(utmArr[7], for: .normal)
        mSSArr = UIUtil.get17SSArray() as AnyObject as? [String]
        mButtonBalloon1.addTarget(self, action: #selector(self.animateShake(_:)), for: .touchUpInside)
        mButtonBalloon2.addTarget(self, action: #selector(self.animateShake(_:)), for: .touchUpInside)
        mButtonBalloon3.addTarget(self, action: #selector(self.animateShake(_:)), for: .touchUpInside)
        if isSCP {
            mVBalloon2.isHidden = true
            mVBalloon3.isHidden = true
            self.applyAttrText(
                mSSArr[12],
                fontSize: 18,
                tracking: 0,
                lineHeight: 0,
                lbl: mLblBalloon1
            )
        } else if isGSC {
            mVBalloon2.isHidden = false
            mVBalloon3.isHidden = false
            self.applyAttrText(
                mSSArr[12],
                fontSize: 18,
                tracking: 0,
                lineHeight: 0,
                lbl: mLblBalloon1
            )

            self.applyAttrText(
                mSSArr[14],
                fontSize: 18,
                tracking: 0,
                lineHeight: 0,
                lbl: mLblBalloon2
            )

            self.applyAttrText(
                mSSArr[16],
                fontSize: 18,
                tracking: 0,
                lineHeight: 0,
                lbl: mLblBalloon3
            )
        } else if isGSCFragrance {
            let gscArr = LanguageConfigure.gsccsv
            print(gscArr)
            mVBalloon2.isHidden = false
            mVBalloon3.isHidden = true
            mButtonBalloon2.isHidden = true
            self.applyAttrText(
                mSSArr[12],
                fontSize: 18,
                tracking: 0,
                lineHeight: 0,
                lbl: mLblBalloon1
            )
            
            self.applyAttrText(
                AppItemTranslateTable.getEntity(7967).name,
                fontSize: 18,
                tracking: 0,
                lineHeight: 0,
                lbl: mLblBalloon2
            )
        }

        mLblhukidashi.numberOfLines = 0
        mLblhukidashi.textAlignment = .center
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.showGSCAnimation()
    }

    @IBAction func onTapTech(_ sender: AnyObject) {
        delegate?.didTapTech()
    }

    func showGSCAnimation() {
        let shearValue: CGFloat = -0.1
        // You can change this to anything you want
        let shearTransform = CGAffineTransform(a: 1.0, b: 0.0, c: shearValue, d: 1.0, tx: 0.0, ty: 0.0)
        let bshearValue: CGFloat = 0.0
        // You can change this to anything you want
        let bshearTransform = CGAffineTransform(a: 1.0, b: 0.0, c: bshearValue, d: 1.0, tx: 0.0, ty: 0.0)
        var imageView: UIImageView?
        if isSCP || isGSCFragrance {
            imageView = mImgBalloon1
        } else {
            let ran = arc4random() % 3 + 1
            switch ran {
            case 1:
                imageView = mImgBalloon1
            case 2:
                imageView = mImgBalloon2
            case 3:
                imageView = mImgBalloon3
            default:
                break
            }
        }
        UIView.animateKeyframes(
            withDuration: 0.6,
            delay: 0,
            options: [],
            animations: {
                UIView.setAnimationRepeatCount(3)
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: {() -> Void in
                    imageView?.transform = shearTransform
                })
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {() -> Void in
                    imageView?.transform = bshearTransform
                })
        },
            completion: { finished in
                if self.isGSC {
                    self.showGSCAnimation()
                }
        })
    }

    @objc private func animateShake(_ sender: BaseButton) {
        if mVShake.alpha == 1 && mShowTag == sender.tag {
            UIView.animateIgnoreInteraction(
                duration: 0.3,
                animations: {
                    self.mVShake.alpha = 0
            })
        } else {
            var str: String!
            switch sender.tag {
            case 1:
                str = mSSArr[13]
            case 2:
                str = mSSArr[15]
            case 3:
                str = mSSArr[17]
            default:
                break
            }
            let strAttr = self.getLabelText(str, fontSize: 18, tracking: 0, lineHeight: 0)
            mLblhukidashi.attributedText = strAttr
            let imageHukidashi = UIImage(named: "ss_hukidashi_" + String(sender.tag) + ".png")
            mImghukidashi.image = imageHukidashi
            mVShake.alpha = 0
            mConstraintTopShake.constant = 0
            self.layoutIfNeeded()
            mConstraintTopShake.constant = 140
            UIView.animateIgnoreInteraction(
                duration: 1,
                animations: {
                    self.mVShake.alpha = 1
                    self.layoutIfNeeded()
            }, completion: { finished in
                self.mShowTag = sender.tag
            })
        }
    }

    private func getLabelText(_ text: String, fontSize: CGFloat, tracking: CGFloat, lineHeight: CGFloat) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setFont(UIUtil.getReaderMedium(fontSize))
        attrStr.setTextColor(UIUtil.grayColor())
        if tracking > 0 {
            attrStr.setTracking(Float(tracking))
        }
        if lineHeight > 0 {
            attrStr.setLineHeight(lineHeight)
        }
        return attrStr
    }

    private func applyAttrText(_ text: String, fontSize: CGFloat, tracking: CGFloat, lineHeight: CGFloat, lbl: UILabel) {
        let attrStr = self.getLabelText(text, fontSize: fontSize, tracking: tracking, lineHeight: lineHeight)
        lbl.backgroundColor = UIColor.clear
        lbl.attributedText = attrStr
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
    }
}
