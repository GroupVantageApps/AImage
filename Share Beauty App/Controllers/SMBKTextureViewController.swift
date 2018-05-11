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
