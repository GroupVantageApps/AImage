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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        TODO ScreenIdもらう
//        self.theme = mScreen.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
