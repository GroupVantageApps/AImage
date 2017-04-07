//
//  UtmFeaturesView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/25.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit


class WhiteLucentFeaturesView: BaseView {
    @IBOutlet private var mVBase: UIView!

    private var sArr: [String]!

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
        sArr = UIUtil.get17SSArray() as AnyObject as! [String]
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let imgV = UIImageView.init(frame: CGRect.init(x: 223, y: 160, width: 45, height: 144))
        imgV.image = UIImage.init(named: "features_whitelucent_1")
        mVBase.addSubview(imgV)
        self.animate()
    }

    private func animate() {
        let circleWhite = UIImageView(frame: CGRect(x: 220, y: 355, width: 45, height: 45))
        circleWhite.translatesAutoresizingMaskIntoConstraints = true
        circleWhite.image = UIImage(named: "ss_pink")
        mVBase.addSubview(circleWhite)

        let UWhitelbl = self.getLabelText(
            sArr[18],
            frame: CGRect(x: 0, y: 0, width: 40, height: 20),
            fontSize: 16.5,
            tracking: 0,
            lineHeight: 0)
        UWhitelbl.center = CGPoint.init(x: 60, y: 60)
        UWhitelbl.alpha = 0
        circleWhite.addSubview(UWhitelbl)

        let circleMois = UIImageView(frame: CGRect(x: 220, y: 355, width: 45, height: 45))
        circleMois.translatesAutoresizingMaskIntoConstraints = true
        circleMois.image = UIImage(named: "ss_pink")
        mVBase.addSubview(circleMois)

        let Moislbl = self.getLabelText(
            sArr[19],
            frame: CGRect(x: 0, y: 0, width: 40, height: 20),
            fontSize: 16.5,
            tracking: 0,
            lineHeight: 0)
        Moislbl.center = CGPoint.init(x: 60, y: 60)
        Moislbl.alpha = 0
        circleMois.addSubview(Moislbl)

        let circlePro = UIImageView(frame: CGRect(x: 220, y: 355, width: 45, height: 45))
        circlePro.translatesAutoresizingMaskIntoConstraints = true
        circlePro.image = UIImage(named: "ss_pink")
        mVBase.addSubview(circlePro)

        let Prolbl = self.getLabelText(
            sArr[20],
            frame: CGRect(x: 0, y: 0, width: 40, height: 20),
            fontSize: 16.5,
            tracking: 0,
            lineHeight: 0)
        Prolbl.textAlignment = .center
        Prolbl.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        Prolbl.center = CGPoint.init(x: 60, y: 60)
        Prolbl.alpha = 0
        circlePro.addSubview(Prolbl)

        let circleEn = UIImageView(frame: CGRect(x: 220, y: 355, width: 45, height: 45))
        circleEn.translatesAutoresizingMaskIntoConstraints = true
        circleEn.image = UIImage(named: "ss_pink")
        mVBase.addSubview(circleEn)

        let Enhanlbl = self.getLabelText(
            sArr[21],
            frame: CGRect(x: 0, y: 0, width: 40, height: 20),
            fontSize: 16.5,
            tracking: 0,
            lineHeight: 0)
        Enhanlbl.textAlignment = .center
        Enhanlbl.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        Enhanlbl.center = CGPoint.init(x: 60, y: 60)
        Enhanlbl.alpha = 0
        circleEn.addSubview(Enhanlbl)

        let circleMake = UIImageView(frame: CGRect(x: 220, y: 355, width: 45, height: 45))
        circleMake.translatesAutoresizingMaskIntoConstraints = true
        circleMake.image = UIImage(named: "ss_pink")
        mVBase.addSubview(circleMake)

        let Makelbl = self.getLabelText(
            sArr[22],
            frame: CGRect(x: 0, y: 0, width: 40, height: 20),
            fontSize: 16.5,
            tracking: 0,
            lineHeight: 0)
        Makelbl.textAlignment = .center
        Makelbl.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        Makelbl.center = CGPoint.init(x: 60, y: 60)
        Makelbl.alpha = 0
        circleMake.addSubview(Makelbl)

        let circlepurple = UIImageView(frame: CGRect(x: 125, y: 250, width: 250, height: 250))
        circlepurple.translatesAutoresizingMaskIntoConstraints = true
        circlepurple.image = UIImage(named: "ss_purple_5")
        mVBase.addSubview(circlepurple)

        let hiddenpurple = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        hiddenpurple.translatesAutoresizingMaskIntoConstraints = true
        hiddenpurple.image = UIImage(named: "ss_purple")
        mVBase.addSubview(hiddenpurple)

        circleWhite.alpha = 0
        circleMois.alpha = 0
        circlePro.alpha = 0
        circleEn.alpha = 0
        circleMake.alpha = 0
        circlepurple.alpha = 0
        hiddenpurple.alpha = 0

        UIView.animateKeyframes(
            withDuration: 0.3,
            delay: 0.0,
            options: .calculationModeLinear,
            animations: {
                circleWhite.alpha=0.3
                circleWhite.frame = CGRect(x: 90, y:195, width: 120, height: 120)
                self.mVBase.addSubview(circleWhite)
        },
            completion: { finished in
                UIView.animateKeyframes(
                    withDuration: 0.2,
                    delay: 0.0,
                    options: .calculationModeLinear,
                    animations: {
                        UWhitelbl.alpha = 1
                        circleWhite.alpha = 1
                        self.mVBase.addSubview(circleWhite)
                },
                    completion: { finished in
                        UIView.animateKeyframes(
                            withDuration: 0.3,
                            delay: 0.0,
                            options: .calculationModeLinear,
                            animations: {
                                circleMois.alpha=0.3
                                circleMois.frame = CGRect(x: 60, y: 65, width: 120, height: 120)
                                self.mVBase.addSubview(circleMois)
                        },
                            completion: { finished in
                                UIView.animateKeyframes(
                                    withDuration: 0.2,
                                    delay: 0.0,
                                    options: .calculationModeLinear,
                                    animations: {
                                        Moislbl.alpha = 1
                                        circleMois.alpha = 1
                                        self.mVBase.addSubview(circleMois)
                                },
                                    completion: { finished in
                                        UIView.animateKeyframes(
                                            withDuration: 0.3,
                                            delay: 0.0,
                                            options: .calculationModeLinear,
                                            animations: {
                                                circlePro.alpha=0.3
                                                circlePro.frame = CGRect(x: 183, y: 0, width: 120, height: 120)
                                                self.mVBase.addSubview(circlePro)
                                        },
                                            completion: { finished in
                                                UIView.animateKeyframes(
                                                    withDuration: 0.2,
                                                    delay: 0.0,
                                                    options: .calculationModeLinear,
                                                    animations: {
                                                        Prolbl.alpha = 1
                                                        circlePro.alpha = 1
                                                        self.mVBase.addSubview(circlePro)
                                                },
                                                    completion: { finished in
                                                        UIView.animateKeyframes(
                                                            withDuration: 0.3,
                                                            delay: 0.0,
                                                            options: .calculationModeLinear,
                                                            animations: {
                                                                circleEn.alpha=0.3
                                                                circleEn.frame = CGRect(x: 308, y: 65, width: 120, height: 120)
                                                                self.mVBase.addSubview(circleEn)
                                                        },
                                                            completion: { finished in
                                                                UIView.animateKeyframes(
                                                                    withDuration: 0.2,
                                                                    delay: 0.0,
                                                                    options: .calculationModeLinear,
                                                                    animations: {
                                                                        Enhanlbl.alpha = 1
                                                                        circleEn.alpha = 1
                                                                        self.mVBase.addSubview(circleEn)
                                                                },
                                                                    completion: { finished in
                                                                        UIView.animateKeyframes(
                                                                            withDuration: 0.3,
                                                                            delay: 0.0,
                                                                            options: .calculationModeLinear,
                                                                            animations: {
                                                                                circleMake.alpha=0.3
                                                                                circleMake.frame = CGRect(x: 282, y: 195, width: 120, height: 120)
                                                                                self.mVBase.addSubview(circleMake)
                                                                        },
                                                                            completion: { finished in
                                                                                UIView.animateKeyframes(
                                                                                    withDuration: 0.2,
                                                                                    delay: 0.0,
                                                                                    options: .calculationModeLinear,
                                                                                    animations: {
                                                                                        Makelbl.alpha = 1
                                                                                        circleMake.alpha = 1
                                                                                        self.mVBase.addSubview(circleMake)
                                                                                },
                                                                                    completion: { finished in
                                                                                        UIView.animateKeyframes(
                                                                                            withDuration: 0.35,
                                                                                            delay: 0.0,
                                                                                            options: .calculationModeLinear,
                                                                                            animations: {
                                                                                                circlepurple.alpha = 0.05
                                                                                                self.mVBase.addSubview(circlepurple)
                                                                                        },
                                                                                            completion: { finished in
                                                                                                UIView.animateKeyframes(
                                                                                                    withDuration: 0.5,
                                                                                                    delay: 0.0,
                                                                                                    options: .calculationModeLinear,
                                                                                                    animations: {
                                                                                                        hiddenpurple.isHidden = true
                                                                                                        circlepurple.alpha=0.4
                                                                                                        circlepurple.frame = CGRect(x: 175, y: 110, width: 140, height: 140)
                                                                                                        self.mVBase.addSubview(circlepurple)
                                                                                                },
                                                                                                    completion: { finished in
                                                                                                        UIView.animateKeyframes(
                                                                                                            withDuration: 0.5,
                                                                                                            delay: 0.0,
                                                                                                            options: .calculationModeLinear,
                                                                                                            animations: {
                                                                                                                hiddenpurple.isHidden = true
                                                                                                                circlepurple.alpha=0.9
                                                                                                                circlepurple.frame = CGRect(x: 172, y: 108, width: 145, height: 145)
                                                                                                                self.mVBase.addSubview(circlepurple)
                                                                                                        },
                                                                                                            completion: { finished in})})})})})})})})})})})})})
    }

    private func getLabelText(_ text: String, frame: CGRect, fontSize: CGFloat, tracking: CGFloat, lineHeight: CGFloat) -> UILabel {
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.setFont(UIUtil.getSystemBold(fontSize))
        attrStr.setTextColor(UIUtil.grayColor())
        if tracking > 0 {
            attrStr.setTracking(Float(tracking))
        }
        if lineHeight > 0 {
            attrStr.setLineHeight(lineHeight)
        }
        let labelSize = attrStr.needDisplaySize(1000/2)
        let labelFrame = CGRect(x: CGFloat(frame.origin.x), y: CGFloat(frame.origin.y), width: CGFloat(labelSize.width), height: CGFloat(labelSize.height))
        let lbl = UILabel(frame: labelFrame)
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.backgroundColor = UIColor.clear
        lbl.attributedText = attrStr
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        return lbl
    }
}
