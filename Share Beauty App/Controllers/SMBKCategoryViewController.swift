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
        
    }
    @IBAction func onTapBeautyCategory(_ sender: Any) {
        let beautyId = productList["\((sender as! UIButton).tag)"]
        let beautyIds = [beautyId] as! [Int]
        print("\(beautyIds)")
        let products = ProductListData(productIds: nil,
                                       beautyIds: beautyId!.description,
                                       lineIds: "18").products
        let productListVc = UIViewController.GetViewControllerFromStoryboard(targetClass: IdealResultViewController.self) as! IdealResultViewController
        productListVc.products = products
        delegate?.nextVc(productListVc)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
}
