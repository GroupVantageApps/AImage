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
    @IBOutlet weak var mToolBtn: UIButton!
    
    let mSMKArr = LanguageConfigure.smk_csv

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        TODO ScreenIdもらう
//        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mFirstVTitle.text = mSMKArr["1"]
        //mFirstVSubTitle.text = mSMKArr["2"]
        //mFirstVText.text = mSMKArr["3"]
        //mSecondVTitle.text = mSMKArr["4"]
        mItemBtn.setTitle(mSMKArr["5"], for: .normal)
        //mSecondVText.text = mSMKArr["6"]
        mFirstTextureBtn.setTitle(mSMKArr["7"], for: .normal)
        mSecondTextureBtn.setTitle(mSMKArr["8"], for: .normal)
        mThirdTextureBtn.setTitle(mSMKArr["9"], for: .normal)
        mFourthTextureBtn.setTitle(mSMKArr["10"], for: .normal)
        mToolBtn.setTitle(mSMKArr["11"], for: .normal)
        
        mFirstTextureBtn.titleLabel?.textAlignment = .right
        mSecondTextureBtn.titleLabel?.textAlignment = .right
        mThirdTextureBtn.titleLabel?.textAlignment = .right
        mFourthTextureBtn.titleLabel?.textAlignment = .right
    }
    
    @IBAction func onTapTextureBtn(_ sender: Any) {
        print("onTapTextureBtn")
        let nextVc = UIViewController.GetViewControllerFromStoryboard(targetClass: SMBKTextureViewController.self) as! SMBKTextureViewController
        print((sender as! UIButton).tag)
        nextVc.texture_id = (sender as! UIButton).tag
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
