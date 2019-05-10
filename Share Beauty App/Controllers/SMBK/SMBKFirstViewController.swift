//
//  SMBKFirstViewController.swift
//  Share Beauty App
//
//  Created by 大倉 瑠維 on 2019/04/24.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SMBKFirstViewController: UIViewController, NavigationControllerAnnotation {
    
    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Makeup Beauty"
    var isEnterWithNavigationView = true
    private let mScreen = ScreenData(screenId: Const.screenIdNewApproach)
    
    
    let mSMKArr = LanguageConfigure.smk_csv
    // 自動画面遷移用
    var workItem = DispatchWorkItem() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        TODO ScreenIdもらう
        //        self.theme = mScreen.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workItem = DispatchWorkItem {
            print("executed")
            self.onTapNextBtn(self.mNextBtn)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: self.workItem)
        
        mFirstVTitle.text = mSMKArr["1"]
        mFirstVSubTitle.text = mSMKArr["2"]
        mFirstVText.text = mSMKArr["3"]
        mSecondVTitle.text = mSMKArr["4"]
        mItemBtn.setTitle(mSMKArr["5"], for: .normal)
        mSecondVText.text = mSMKArr["6"]
        
        textureBtns.append(contentsOf: [mFirstTextureBtn, mSecondTextureBtn, mThirdTextureBtn, mFourthTextureBtn, mToolBtn, mComplextionBtn])
        print("msmkarr:\(mSMKArr)")
        for (i, btn) in textureBtns.enumerated() {
            btn.setTitle(mSMKArr["\(7 + i)"], for: .normal)
            btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
    }
    
    private func animateFadeIn(target: UIView, delay: TimeInterval, completion: (() -> ())? = nil) {
        target.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: delay,
            animations: {
                target.alpha = 1
        },
            completion: { _ in
                completion?()
        })
    }
    
    private func secondViewFadeIn() {
        self.animateFadeIn(target: mSecondVTitle, delay: 0)
        self.animateFadeIn(target: mSecondVText, delay: 0)
        self.animateFadeIn(target: mItemBtn, delay: 0)
        
        for (_, btn) in textureBtns.enumerated() {
            self.animateFadeIn(target: btn, delay: Double(btn.tag) * 0.3)
        }
    }
    
    @IBAction func onTapTextureBtn(_ sender: Any) {
        print("onTapTextureBtn")
        if (sender as! UIButton).tag == 6 {
            let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: SMBK19AWTextureViewController.self) as! SMBK19AWTextureViewController
            print((sender as! UIButton).tag)
            nextVc.texture_id = (sender as! UIButton).tag
            let beautySecondIds = [70, 71, 72, 73, 74]
            let beautyIds = Utility.replaceParenthesis(beautySecondIds.description)
            nextVc.mProductList = ProductListData(productIds: nil, beautyIds: beautyIds, lineIds: "\(Const.lineIdMAKEUP)")
            delegate?.nextVc(nextVc)
        } else {
            let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: SMBKTextureViewController.self) as! SMBKTextureViewController
            print((sender as! UIButton).tag)
            nextVc.texture_id = (sender as! UIButton).tag
            let beautySecondIds = [70, 71, 72, 73, 74]
            let beautyIds = Utility.replaceParenthesis(beautySecondIds.description)
            nextVc.mProductList = ProductListData(productIds: nil, beautyIds: beautyIds, lineIds: "\(Const.lineIdMAKEUP)")
            delegate?.nextVc(nextVc)
        }
    }
    
    @IBAction func onTapItemBtn(_ sender: Any) {
        print("onTapItemBtn")
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: SMBKCategoryViewController.self) as! SMBKCategoryViewController
        delegate?.nextVc(nextVc)
    }
    
    @IBAction func onTapNextBtn(_ sender: Any) {
        firstV.isHidden = true
        secondV.isHidden = false
        self.secondViewFadeIn()
        self.workItem.cancel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
