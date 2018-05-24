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
    
    private var myScrollView: UIScrollView!
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    let button5 = UIButton()
    let button6 = UIButton()
    let button7 = UIButton()
    let button8 = UIButton()
    let button9 = UIButton()
    let button10 = UIButton()
    let button01 = UIButton()
    let button02 = UIButton()
    let button03 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myScrollView = UIScrollView()
        myScrollView.backgroundColor = UIColor(red: 0.3, green: 1.0, blue: 0.3, alpha: 0.05)            //スクロールビューの色
        myScrollView.layer.borderWidth = 1.0                                                            //スクロールビューの枠線太さ
        myScrollView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor   //スクロールビューの枠線色
        myScrollView.frame = CGRect(x: 0, y: 50, width: 1025, height: 216)
        myScrollView.contentSize = CGSize(width: 1651, height: 216)
        myScrollView.bounces = false
        myScrollView.indicatorStyle = .white
        myScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        //let button: [UIButton] = []
        //let button1 = UIButton()
        button1.setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        button1.setTitle("Liquid Foundation", for: .normal)
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button1.titleEdgeInsets = UIEdgeInsetsMake(7, 71, 0, 0);
        button1.frame = CGRect(x:49,y:10,width:300,height:91)
        button1.layer.borderWidth = 2.0
        button1.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button1.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button1)
        
        //let button2 = UIButton()
        button2.setBackgroundImage(UIImage(named: "08_02.png"), for: .normal)
        button2.setTitle("Makeup Base", for: .normal)
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button2.titleEdgeInsets = UIEdgeInsetsMake(7, 36, 0, 0);
        button2.frame = CGRect(x:362,y:10,width:300,height:91)
        button2.layer.borderWidth = 2.0
        button2.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button2.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button2)
        
        //let button3 = UIButton()
        button3.setBackgroundImage(UIImage(named: "08_03.png"), for: .normal)
        button3.setTitle("Powdery Foundation", for: .normal)
        button3.setTitleColor(UIColor.black, for: .normal)
        button3.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button3.titleEdgeInsets = UIEdgeInsetsMake(7, 93, 0, 0);
        button3.frame = CGRect(x:675,y:10,width:300,height:91)
        button3.layer.borderWidth = 2.0
        button3.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button3.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button3)
        
        //let button4 = UIButton()
        button4.setBackgroundImage(UIImage(named: "08_04.png"), for: .normal)
        button4.titleLabel!.numberOfLines = 2                                   //行数指定
        //button4.titleLabel!.lineSpacing = 10
        
        //行間指定
        
        button4.setTitle("Solid Emulsion \nFoundation", for: .normal)
        button4.setTitleColor(UIColor.black, for: .normal)
        button4.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button4.titleEdgeInsets = UIEdgeInsetsMake(-5, 44, 0, 0);
        button4.frame = CGRect(x:49,y:115,width:300,height:91)
        button4.layer.borderWidth = 2.0
        button4.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        
        let attributedText = NSMutableAttributedString(string: (button4.titleLabel?.text)!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        button4.setAttributedTitle(attributedText, for: .normal)
        
        button4.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button4)
        
        //let button5 = UIButton()
        button5.setBackgroundImage(UIImage(named: "08_05.png"), for: .normal)
        button5.setTitle("Cushion Foundation", for: .normal)
        button5.setTitleColor(UIColor.black, for: .normal)
        button5.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button5.titleEdgeInsets = UIEdgeInsetsMake(5, 89, 0, 0);
        button5.frame = CGRect(x:362,y:115,width:300,height:91)
        button5.layer.borderWidth = 2.0
        button5.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button5.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button5)
        
        //let button6 = UIButton()
        button6.setBackgroundImage(UIImage(named: "08_06.png"), for: .normal)
        button6.setTitle("Stick Foundation", for: .normal)
        button6.setTitleColor(UIColor.black, for: .normal)
        button6.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button6.titleEdgeInsets = UIEdgeInsetsMake(5, 62, 0, 0);
        button6.frame = CGRect(x:675,y:115,width:300,height:91)
        button6.layer.borderWidth = 2.0
        button6.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button6.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button6)
        
        //仮のボタン
        //let button01 = UIButton()
        button01.setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        button01.setTitle("仮", for: .normal)
        button01.setTitleColor(UIColor.black, for: .normal)
        button01.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(40))  //文字大きく変更
        button01.titleEdgeInsets = UIEdgeInsetsMake(7, 43, 0, 0);
        button01.frame = CGRect(x:988,y:10,width:300,height:91)
        button01.layer.borderWidth = 2.0
        button01.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button01.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button01)
        
        //仮のボタン
        //let button02 = UIButton()
        button02.setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        button02.setTitle("仮", for: .normal)
        button02.setTitleColor(UIColor.black, for: .normal)
        button02.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(40))  //文字大きく変更
        button02.titleEdgeInsets = UIEdgeInsetsMake(7, 43, 0, 0);
        button02.frame = CGRect(x:988,y:115,width:300,height:91)
        button02.layer.borderWidth = 2.0
        button02.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button02.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button02)
        
        //仮のボタン
        //let button03 = UIButton()
        button03.setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        button03.setTitle("仮", for: .normal)
        button03.setTitleColor(UIColor.black, for: .normal)
        button03.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(40))  //文字大きく変更
        button03.titleEdgeInsets = UIEdgeInsetsMake(7, 43, 0, 0);
        button03.frame = CGRect(x:1301,y:10,width:300,height:91)
        button03.layer.borderWidth = 2.0
        button03.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button03.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        myScrollView.addSubview(button03)
        
        self.view.addSubview(myScrollView)
        
        //let button7 = UIButton()
        button7.setBackgroundImage(UIImage(named: "08_07.png"), for: .normal)
        button7.setTitle("FACE", for: .normal)
        button7.setTitleColor(UIColor.black, for: .normal)
        button7.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button7.titleEdgeInsets = UIEdgeInsetsMake(7, -29, 0, 0);
        button7.frame = CGRect(x:49,y:311,width:300,height:91)
        button7.layer.borderWidth = 2.0
        button7.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button7.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        self.view.addSubview(button7)
        
        //let button8 = UIButton()
        button8.setBackgroundImage(UIImage(named: "08_08.png"), for: .normal)
        button8.setTitle("EYES", for: .normal)
        button8.setTitleColor(UIColor.black, for: .normal)
        button8.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button8.titleEdgeInsets = UIEdgeInsetsMake(7, -29, 0, 0);
        button8.frame = CGRect(x:362,y:311,width:300,height:91)
        button8.layer.borderWidth = 2.0
        button8.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button8.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        self.view.addSubview(button8)
        
        //let button9 = UIButton()
        button9.setBackgroundImage(UIImage(named: "08_09.png"), for: .normal)
        button9.setTitle("LIPS", for: .normal)
        button9.setTitleColor(UIColor.black, for: .normal)
        button9.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button9.titleEdgeInsets = UIEdgeInsetsMake(7, -33, 0, 0);
        button9.frame = CGRect(x:675,y:311,width:300,height:91)
        button9.layer.borderWidth = 2.0
        button9.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button9.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        self.view.addSubview(button9)
        
        //let button10 = UIButton()
        button10.setBackgroundImage(UIImage(named: "08_10.png"), for: .normal)
        button10.setTitle("TOOLS", for: .normal)
        button10.setTitleColor(UIColor.black, for: .normal)
        button10.titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(17.7))
        button10.titleEdgeInsets = UIEdgeInsetsMake(7, -16, 0, 0);
        button10.frame = CGRect(x:49,y:433,width:300,height:91)
        button10.layer.borderWidth = 2.0
        button10.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        button10.addTarget(self, action: "onTapBeautyCategory:", for: .touchUpInside)
        self.view.addSubview(button10)
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
