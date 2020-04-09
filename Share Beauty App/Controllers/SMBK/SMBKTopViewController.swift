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
    @IBOutlet weak var thirdV: UIView!
    @IBOutlet weak var forthV: UIView!
    
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
    @IBOutlet weak var mThirdVTitle: UILabel!
    @IBOutlet weak var MakeupBtn: UIButton!
    @IBOutlet weak var ComplexionBtn: UIButton!
    @IBOutlet weak var mForthToolsBtn: UIButton!
    @IBOutlet weak var mForthItemBtn: UIButton!
    @IBOutlet weak var mForthImg: UIImageView!
    @IBOutlet weak var mForthTitleLbl: UILabel!
    @IBOutlet weak var mForthVText: UILabel!
    @IBOutlet weak var mForthComplexionBtn: UIButton!
    
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
            self.onTapNextBtn(self.mNextBtn!)
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
        
        let makeupTitle = AppItemTable.getNameByItemId(itemId: 8541)
        let complexionTitle = AppItemTable.getNameByItemId(itemId: 8543)
        MakeupBtn.setTitle(makeupTitle, for: .normal)
        MakeupBtn.titleLabel?.font = UIFont(name: "Reader-Bold", size: 25)
        MakeupBtn.titleEdgeInsets = UIEdgeInsets(top: 10, left: 50, bottom: 0, right: 0)
        MakeupBtn.setTitleColor(UIColor(red255: 255, green255: 255, blue255: 255, alpha: 1), for: .normal)
        ComplexionBtn.setTitle(complexionTitle, for: .normal)
        ComplexionBtn.titleLabel?.font = UIFont(name: "Reader-Bold", size: 25)
        ComplexionBtn.titleEdgeInsets = UIEdgeInsets(top: 10, left: -10, bottom: 0, right: 0)
        ComplexionBtn.setTitleColor(UIColor(red255: 255, green255: 255, blue255: 255, alpha: 1), for: .normal)        
        mComplextionBtn.isHidden = true
        let compButton = "> " + mSMKArr["29"]!
        mForthComplexionBtn.setTitle(compButton, for: .normal)
        mForthComplexionBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -110, bottom: 0, right: 0)
        mForthTitleLbl.text = AppItemTable.getNameByItemId(itemId: 8539)
        mForthVText.text = AppItemTable.getNameByItemId(itemId: 8540)
        
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
    
    private func thirdViewFadeIn() {
        self.animateFadeIn(target: mThirdVTitle, delay: 0)
        self.animateFadeIn(target: MakeupBtn, delay: 0)
        self.animateFadeIn(target: ComplexionBtn, delay: 0)
    }
    
    private func FothViewFadeIn() {
        self.animateFadeIn(target: mForthToolsBtn, delay: 0)
        self.animateFadeIn(target: mForthImg, delay: 0)
        self.animateFadeIn(target: mForthItemBtn, delay: 0)
    }
    
    @IBAction func onTapMakeupBtn(_ sender: Any) {
        thirdV.isHidden = true
        secondV.isHidden = false
        self.secondViewFadeIn()
        self.workItem.cancel()
    }
    
    @IBAction func onTapComplexionBtn(_ sender: Any) {
        thirdV.isHidden = true
        forthV.isHidden = false
        self.FothViewFadeIn()
        self.workItem.cancel()
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
        tapItem()
    }
    
    @IBAction func onTapForthItemBtn(_ sender: Any) {
        tapItem()
    }
    
    func tapItem() {
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: SMBKCategoryViewController.self) as! SMBKCategoryViewController
        delegate?.nextVc(nextVc)
    }
    
    @IBAction func onTapNextBtn(_ sender: Any) {
        firstV.isHidden = true
        thirdV.isHidden = false
        secondV.isHidden = true
        self.thirdViewFadeIn()
        self.workItem.cancel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
