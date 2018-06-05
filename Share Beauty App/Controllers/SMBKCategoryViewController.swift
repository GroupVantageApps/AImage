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
    @IBOutlet weak var mViewBtn: UIButton!
    
    var complexionBtns: [SMKCategoryButton] = []
    var colorMakeupBtns: [SMKCategoryButton] = []
    var mComplexionList: [BeautySecondTranslateEntity] = []
    var mColorMakeupList: [BeautySecondTranslateEntity] = []
    var selectedBeautySecondIds: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myScrollView = UIScrollView()
        myScrollView.frame = CGRect(x: 50, y: 0, width: 884, height: self.mComplexionView.height)
        myScrollView.contentSize = CGSize(width: 1775, height: self.mComplexionView.height)
        myScrollView.bounces = true
        myScrollView.indicatorStyle = .white
        mComplexionView.addSubview(self.myScrollView)
        
        let entity = AppItemTable.getEntity(7797)
        mViewBtn.setTitle(entity.itemName, for: .normal)
        mViewBtn.isHidden = true
        self.setProductList()
        self.setButtons()
    }
    
    func setProductList() {
        // DBからデータ取得
        let complexionEntities:[BeautySecondEntity] = BeautySecondTable.getEntitiesFromBF(33)
        
        let colorMakeupEntities:[BeautySecondEntity] = BeautySecondTable.getEntitiesFromBF(45).filter { 70 <= $0.beautySecondId! && $0.beautySecondId! <= 73}
        for e in complexionEntities {
            let translatedEntity: BeautySecondTranslateEntity = BeautySecondTranslateTable.getEntity(e.beautySecondId!)
            mComplexionList.append(translatedEntity)
        }
        mComplexionList.sort(by: {$0.displayOrder! < $1.displayOrder!})

        for e in colorMakeupEntities {
            let translatedEntity: BeautySecondTranslateEntity = BeautySecondTranslateTable.getEntity(e.beautySecondId!)
            mColorMakeupList.append(translatedEntity)
        }
        mColorMakeupList.sort(by: {$0.displayOrder! < $1.displayOrder!})
    }
    
    func setButtons() {
        let btnWidth = SMKCategoryButton().width
        let btnHeight = SMKCategoryButton().height
        let marginHorizon = 7
        
        for (i, complexion) in mComplexionList.enumerated() {
            complexionBtns.append(SMKCategoryButton(id: complexion.beautySecondId!,text: complexion.name))
            complexionBtns[i].setBackgroundImage(UIImage(named: "complexion_\(complexion.beautySecondId!).png"), for: .normal)
            if i % 2 == 0 {
                complexionBtns[i].origin.x = CGFloat(Int(btnWidth) * i/2 + marginHorizon * i/2)
            } else {
                complexionBtns[i].origin.y = btnHeight + 8
                complexionBtns[i].origin.x = CGFloat(Int(btnWidth) * (i - 1) / 2 + marginHorizon * (i - 1) / 2)
            }
            complexionBtns[i].addTarget(self, action: #selector(onTapCategoryBtn(_:)), for: .touchUpInside)
            myScrollView.addSubview(complexionBtns[i])
        }
        for (i, colorMakeup) in mColorMakeupList.enumerated() {
            colorMakeupBtns.append(SMKCategoryButton(id: colorMakeup.beautySecondId!,text: colorMakeup.name))
            colorMakeupBtns[i].setBackgroundImage(UIImage(named: "makeup_0\(i + 1).png"), for: .normal)
            if i == 3 {
                colorMakeupBtns[i].origin.y = btnHeight + 8
            } else {
                colorMakeupBtns[i].origin.x = CGFloat(Int(btnWidth) * i + marginHorizon * i)
            }
            colorMakeupBtns[i].addTarget(self, action: #selector(onTapCategoryBtn(_:)), for: .touchUpInside)
            mColorMakeupView.addSubview(colorMakeupBtns[i])
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
    
    func onTapCategoryBtn(_ sender: SMKCategoryButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.layer.borderWidth = 1.5
            sender.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
            if let index = selectedBeautySecondIds.index(where: { $0 == sender.beautySecondId }) {
                selectedBeautySecondIds.remove(at: index)
            }
        } else {
            sender.isSelected = true
            sender.layer.borderWidth = 2.0
            sender.layer.borderColor = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
            selectedBeautySecondIds.append(sender.beautySecondId)
        }
        if selectedBeautySecondIds.count == 0 {
            mViewBtn.isHidden = true
        } else {
            mViewBtn.isHidden = false
        }
    }
    
    @IBAction func onTapViewBtn(_ sender: Any) {
        let beautyIds = Utility.replaceParenthesis(selectedBeautySecondIds.description)
        let products = ProductListData(productIds: nil, beautyIds: beautyIds, lineIds: "\(Const.lineIdMAKEUP)").products
        let nextVc = UIViewController.GetViewControllerFromStoryboard("IdealResultViewController", targetClass: IdealResultViewController.self) as! IdealResultViewController
        nextVc.products = products
        delegate?.nextVc(nextVc)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
