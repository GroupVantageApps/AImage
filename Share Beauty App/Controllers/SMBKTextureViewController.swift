//
//  SMBKTextureViewController
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SMBKTextureViewController: UIViewController, NavigationControllerAnnotation {

    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Makeup Beauty"
    var isEnterWithNavigationView = true
    private let mScreen = ScreenData(screenId: Const.screenIdNewApproach)
    var texture_id = 0
    let productList = [ "1_10": 572, "2_10": 573, "2_11": 574, "2_12": 575, "3_10": 584, "3_11": 586, "3_12": 587, "4_10": 577, "4_11": 578, "4_12": 579, "5_10": 595, "5_11": 596, "5_12": 597 ]
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var mSideView: UIView!
    @IBOutlet weak var mSideTitle: UILabel!
    @IBOutlet weak var mSideSubText: UILabel!
    @IBOutlet weak var mTextureName: UILabel!
    @IBOutlet weak var mToUse: UILabel!

    let mSMKArr = LanguageConfigure.smk_csv

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        TODO ScreenIdもらう
//        self.theme = mScreen.name
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if texture_id == 1 {
            let button = self.view.viewWithTag(11)
            button?.isHidden = true
            let button_2 = self.view.viewWithTag(12)
            button_2?.isHidden = true
        }
        
        let sideImage: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.mSideView.frame.size.width, height: self.mSideView.frame.size.height))
        sideImage.image = UIImage(named: "03_back_0\(texture_id)")
        sideImage.layer.zPosition = -1
        self.mSideView.addSubview(sideImage)
        
        let textureLabelId = 12 + (texture_id - 1) * 4
        mTextureName.text = mSMKArr[String(textureLabelId)]
        if texture_id != 5 {
            mToUse.text = mSMKArr[String(textureLabelId + 1)]
            mSideTitle.text = mSMKArr[String(textureLabelId + 2)]
            mSideSubText.text = mSMKArr[String(textureLabelId + 3)]
        } else {
            mSideTitle.isHidden = true
            mSideSubText.isHidden = true
            mToUse.isHidden = true
        }
    }

    @IBAction func onTapProductDetail(_ sender: Any) {
        
        let product_id = productList["\(texture_id)_\((sender as! UIButton).tag)"]
        
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = product_id
        delegate?.nextVc(productDetailVc)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageV.image = UIImage.init(named: "smbk_texture_\(texture_id)")
      
    }

}
