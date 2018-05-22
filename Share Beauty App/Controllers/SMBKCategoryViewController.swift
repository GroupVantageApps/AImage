//
//  SMBKCategoryViewController
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SMBKCategoryViewController: UIViewController, NavigationControllerAnnotation {

    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Makeup Beauty"
    var isEnterWithNavigationView = true
     let productList = [ "10": 34, "11": 41, "12": 35, "13": 38, "14": 37, "15": 31, "16": 70, "17": 71, "18": 72, "19": 73]
    private let mScreen = ScreenData(screenId: Const.screenIdNewApproach)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        TODO ScreenIdもらう
//        self.theme = mScreen.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        button.setTitle("Liquid Foundation", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button.titleEdgeInsets = UIEdgeInsetsMake(7, 71, 0, 0);
        button.frame = CGRect(x:49,y:60,width:300,height:91)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        self.view.addSubview(button)
    }
    
    @IBAction func onTapBeautyCategory(_ sender: Any) {
        let button = sender as! UIButton

        
        if button.isSelected == true {
            button.isSelected = false
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        } else {
            button.isSelected = true
            button.layer.borderWidth = 3.0
            button.layer.borderColor = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        }
        
//        let beautyId = productList["\((sender as! UIButton).tag)"]
//        let beautyIds = [beautyId] as! [Int]
//        print("\(beautyIds)")
//        let products = ProductListData(productIds: nil,
//                                       beautyIds: beautyId!.description,
//                                       lineIds: "18").products
//        let productListVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealResultViewController.self) as! IdealResultViewController
//        productListVc.products = products
//        delegate?.nextVc(productListVc)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
}
