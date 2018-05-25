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
    // Complexionのid [34, 41, 38, 37, 35, 39, 40, 42]
    // Color Makeupのid [70, 71, 72, 73]
    // 「VIEW」 app_item_id 7797
    // Complextionに相当するidはm_beauty_first_translate 33です。この配下にm_beauty_second_translateがいます。
    // DB : m_beauty_second_translate
    private let mScreen = ScreenData(screenId: Const.screenIdNewApproach)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        TODO ScreenIdもらう
//        self.theme = mScreen.name
    }
    
    @IBOutlet weak var mComplexionView: UIView!
    @IBOutlet weak var mColorMakeupView: UIView!
    private var myScrollView: UIScrollView!
    @IBOutlet weak var mLeftBtn: UIButton!
    @IBOutlet weak var mRightBtn: UIButton!
    let mMargin: CGFloat = 50
    
    class ByItemButton: UIButton {
        override init(frame: CGRect) {
            super.init(frame: frame)
            //            self.setTitle("Liquid Foundation", for: .normal)
            self.setTitleColor(UIColor.black, for: .normal)
            self.titleLabel!.font = UIFont(name: "Reader-Medium", size: CGFloat(17.7))
//            self.titleEdgeInsets = UIEdgeInsetsMake(7, 71, 0, 0);
            self.frame = CGRect(x:0, y:0, width:290, height:95)
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
            self.addTarget(self, action: #selector(SMBKCategoryViewController.onTapBeautyCategory(_:)), for: .touchUpInside)
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    var complexionBtns: [ByItemButton] = []
    var makeupBtns: [ByItemButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myScrollView = UIScrollView()
        //スクロールビューの色
//        myScrollView.backgroundColor = UIColor(red: 0.3, green: 1.0, blue: 0.3, alpha: 0.05)
        //スクロールビューの枠線太さ
//        myScrollView.layer.borderWidth = 1.0
        //スクロールビューの枠線色
//        myScrollView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0).cgColor
    
        myScrollView.frame = CGRect(x: 50, y: 0, width: 884, height: self.mComplexionView.height)
        myScrollView.contentSize = CGSize(width: 1775, height: self.mComplexionView.height)
        myScrollView.bounces = true
        myScrollView.indicatorStyle = .white
//        myScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mComplexionView.addSubview(self.myScrollView)

//        print("ComplexionView--info: \(mComplexionView.origin) : \(mComplexionView.size)")
//        print("scrollview--info: \(myScrollView.origin) : \(myScrollView.size)")
        self.setProductList()
        self.setButtons()
        
    }
    
    func setProductList() {
        // DBからデータ取得
        let entities:[BeautySecondEntity] = BeautySecondTable.getEntitiesFromBF(33)
        print("#entity codes (SMKCategory)#")
        for e in entities {
            print(e.code)
        }
    }

    func setButtons() {
        let btnWidth = ByItemButton().width
        let btnHeight = ByItemButton().height
        
        // Complexion ボタン配置
        complexionBtns.append(ByItemButton())
        complexionBtns[0].setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        complexionBtns[0].setTitle("Liquid Foundation", for: .normal)
        complexionBtns[0].titleEdgeInsets = UIEdgeInsetsMake(7, 60, 0, 0);
        myScrollView.addSubview(complexionBtns[0])
        
        complexionBtns.append(ByItemButton())
        complexionBtns[1].setBackgroundImage(UIImage(named: "08_02.png"), for: .normal)
        complexionBtns[1].setTitle("Makeup Base", for: .normal)
        complexionBtns[1].titleEdgeInsets = UIEdgeInsetsMake(7, 36, 0, 0);
        complexionBtns[1].origin.x = btnWidth + 7
        myScrollView.addSubview(complexionBtns[1])
        
        complexionBtns.append(ByItemButton())
        complexionBtns[2].setBackgroundImage(UIImage(named: "08_03.png"), for: .normal)
        complexionBtns[2].setTitle("Powdery Foundation", for: .normal)
        complexionBtns[2].titleEdgeInsets = UIEdgeInsetsMake(7, 93, 0, 0);
        complexionBtns[2].origin.x = btnWidth * 2 + 14
        myScrollView.addSubview(complexionBtns[2])
        
        complexionBtns.append(ByItemButton())
        complexionBtns[3].setBackgroundImage(UIImage(named: "08_04.png"), for: .normal)
        complexionBtns[3].setTitle("Solid Emulsion \nFoundation", for: .normal)
        complexionBtns[3].titleLabel?.numberOfLines = 2
        complexionBtns[3].titleEdgeInsets = UIEdgeInsetsMake(7, 43, 0, 0);
        complexionBtns[3].origin.y = btnHeight + 8
        //行間指定
        let attributedText = NSMutableAttributedString(string: (complexionBtns[3].titleLabel?.text)!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        complexionBtns[3].setAttributedTitle(attributedText, for: .normal)
        //
        myScrollView.addSubview(complexionBtns[3])
        
        complexionBtns.append(ByItemButton())
        complexionBtns[4].setBackgroundImage(UIImage(named: "08_05.png"), for: .normal)
        complexionBtns[4].setTitle("Cushion Foundation", for: .normal)
        complexionBtns[4].titleEdgeInsets = UIEdgeInsetsMake(5, 89, 0, 0);
        complexionBtns[4].origin.x = btnWidth + 7
        complexionBtns[4].origin.y = btnHeight + 8
        myScrollView.addSubview(complexionBtns[4])
        
        complexionBtns.append(ByItemButton())
        complexionBtns[5].setBackgroundImage(UIImage(named: "08_06.png"), for: .normal)
        complexionBtns[5].setTitle("Stick Foundation", for: .normal)
        complexionBtns[5].titleEdgeInsets = UIEdgeInsetsMake(5, 62, 0, 0);
        complexionBtns[5].origin.x = btnWidth * 2 + 14
        complexionBtns[5].origin.y = btnHeight + 8
        myScrollView.addSubview(complexionBtns[5])
        
        complexionBtns.append(ByItemButton())
        complexionBtns[6].setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        complexionBtns[6].setTitle("仮", for: .normal)
        complexionBtns[6].titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(40))
        
        complexionBtns[6].origin.x = myScrollView.width + 7
        myScrollView.addSubview(complexionBtns[6])

        complexionBtns.append(ByItemButton())
        complexionBtns[7].setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        complexionBtns[7].setTitle("仮", for: .normal)
        complexionBtns[7].titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(40))
        complexionBtns[7].origin.x = myScrollView.width + btnWidth + 14
        myScrollView.addSubview(complexionBtns[7])

        complexionBtns.append(ByItemButton())
        complexionBtns[8].setBackgroundImage(UIImage(named: "08_01.png"), for: .normal)
        complexionBtns[8].setTitle("仮", for: .normal)
        complexionBtns[8].titleLabel!.font = UIFont(name: "Reader-Medium",size: CGFloat(40))
        complexionBtns[8].origin.x = myScrollView.width + 7
        complexionBtns[8].origin.y = btnHeight + 8
        myScrollView.addSubview(complexionBtns[8])
        
        // Color Makeup ボタン配置
        makeupBtns.append(ByItemButton())
        makeupBtns[0].setBackgroundImage(UIImage(named: "08_07.png"), for: .normal)
        makeupBtns[0].setTitle("FACE", for: .normal)
        makeupBtns[0].titleEdgeInsets = UIEdgeInsetsMake(7, -29, 0, 0);
        mColorMakeupView.addSubview(makeupBtns[0])
        
        makeupBtns.append(ByItemButton())
        makeupBtns[1].setBackgroundImage(UIImage(named: "08_08.png"), for: .normal)
        makeupBtns[1].setTitle("EYES", for: .normal)
        makeupBtns[1].titleEdgeInsets = UIEdgeInsetsMake(7, -29, 0, 0);
        makeupBtns[1].origin.x = btnWidth + 7
        mColorMakeupView.addSubview(makeupBtns[1])
        
        makeupBtns.append(ByItemButton())
        makeupBtns[2].setBackgroundImage(UIImage(named: "08_09.png"), for: .normal)
        makeupBtns[2].setTitle("LIPS", for: .normal)
        makeupBtns[2].titleEdgeInsets = UIEdgeInsetsMake(7, -33, 0, 0);
        makeupBtns[2].origin.x = btnWidth * 2 + 14
        mColorMakeupView.addSubview(makeupBtns[2])
        
        makeupBtns.append(ByItemButton())
        makeupBtns[3].setBackgroundImage(UIImage(named: "08_10.png"), for: .normal)
        makeupBtns[3].setTitle("TOOLS", for: .normal)
        makeupBtns[3].titleEdgeInsets = UIEdgeInsetsMake(7, -16, 0, 0);
        makeupBtns[3].origin.y = btnHeight + 8
        mColorMakeupView.addSubview(makeupBtns[3])
    }
    
    func onTapBeautyCategory(_ sender: Any) {
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
    }
    
    @IBAction func onTapScrollBtn(_ sender: UIButton) {
        var offset = CGPoint()
        if sender.tag == 0 {
            offset = CGPoint(x: 0, y: 0)
        } else if sender.tag == 1 {
            offset = CGPoint(x: 891, y: 0)
        }
        self.myScrollView.setContentOffset(offset, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
}
