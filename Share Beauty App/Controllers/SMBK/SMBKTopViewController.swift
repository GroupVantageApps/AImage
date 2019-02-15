//
//  SMBKTopViewController
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SMBKTopViewController: UIViewController, NavigationControllerAnnotation {

    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Makeup Beauty"
    var isEnterWithNavigationView = true
    private let mScreen = ScreenData(screenId: Const.screenIdNewApproach)
    
    @IBOutlet weak var firstV: UIView!
    @IBOutlet weak var secondV: UIView!
    
    @IBOutlet weak var mFirstVTitle: UILabel!
    @IBOutlet weak var mFirstVSubTitle: UILabel!
    @IBOutlet weak var mFirstVText: UILabel!
    @IBOutlet weak var mSecondVTitle: UILabel!
    @IBOutlet weak var mItemBtn: UIButton!
    @IBOutlet weak var mSecondVText: UILabel!
    @IBOutlet weak var mFirstTextureBtn: UIButton!
    @IBOutlet weak var mSecondTextureBtn: UIButton!
    @IBOutlet weak var mThirdTextureBtn: UIButton!
    @IBOutlet weak var mFourthTextureBtn: UIButton!
    var textureBtns: [UIButton] = []
    @IBOutlet weak var mToolBtn: UIButton!
    @IBOutlet weak var mComplextionBtn: UIButton!
    @IBOutlet weak var mNextBtn: UIButton!
    
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
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: SMBKTextureViewController.self) as! SMBKTextureViewController
        print((sender as! UIButton).tag)
        nextVc.texture_id = (sender as! UIButton).tag
        let beautySecondIds = [70, 71, 72, 73, 74]
        let beautyIds = Utility.replaceParenthesis(beautySecondIds.description)
        nextVc.mProductList = ProductListData(productIds: nil, beautyIds: beautyIds, lineIds: "\(Const.lineIdMAKEUP)")
        delegate?.nextVc(nextVc)
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
