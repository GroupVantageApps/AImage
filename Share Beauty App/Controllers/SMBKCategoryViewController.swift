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
    var mComplexionList: [Int:String] = [:]
    var mColorMakeupList: [Int:String] = [:]
    // Complexionのid [34, 41, 38, 37, 35, 39, 40, 42]
    // Color Makeupのid [70, 71, 72, 73]
    static let mDefaultList = [34, 35, 41, 39, 38, 40, 37, 42, 70, 71, 72, 73]
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
        let colorMakeupEntities:[BeautySecondEntity] = BeautySecondTable.getEntitiesFromBF(45)
        for e in complexionEntities {
            let translatedEntity: BeautySecondTranslateEntity = BeautySecondTranslateTable.getEntity(e.beautySecondId!)
            mComplexionList.updateValue(translatedEntity.name, forKey: translatedEntity.beautySecondId!)
        }
        for e in colorMakeupEntities {
            let translatedEntity: BeautySecondTranslateEntity = BeautySecondTranslateTable.getEntity(e.beautySecondId!)
            mColorMakeupList.updateValue(translatedEntity.name, forKey: translatedEntity.beautySecondId!)
        }
    }
    
    func setButtons() {
        let btnWidth = SMKCategoryButton().width
        let btnHeight = SMKCategoryButton().height
        let marginHorizon = 7
        var countOfComplexionBtn = 0
        var countOfColorMakeupBtn = 0
        
        for (index, beautySecondId) in SMBKCategoryViewController.mDefaultList.enumerated() {
            if let category = mComplexionList[beautySecondId] {
                let i = countOfComplexionBtn
                complexionBtns.append(SMKCategoryButton(id: beautySecondId, text: category))
                complexionBtns[i].setBackgroundImage(UIImage(named: "complexion_0\(index + 1).png"), for: .normal)
                if i % 2 == 0 {
                    complexionBtns[i].origin.x = CGFloat(Int(btnWidth) * i/2 + marginHorizon * i/2)
                } else {
                    complexionBtns[i].origin.y = btnHeight + 8
                    complexionBtns[i].origin.x = CGFloat(Int(btnWidth) * (i - 1) / 2 + marginHorizon * (i - 1) / 2)
                }
                complexionBtns[i].addTarget(self, action: #selector(onTapCategoryBtn(_:)), for: .touchUpInside)
                myScrollView.addSubview(complexionBtns[i])
                countOfComplexionBtn += 1
            } else if let category = mColorMakeupList[beautySecondId] {
                let i = countOfColorMakeupBtn
                colorMakeupBtns.append(SMKCategoryButton(id: beautySecondId, text: category))
                colorMakeupBtns[i].setBackgroundImage(UIImage(named: "makeup_0\(i + 1).png"), for: .normal)
                if i == 3 {
                    colorMakeupBtns[i].origin.y = btnHeight + 8
                } else {
                    colorMakeupBtns[i].origin.x = CGFloat(Int(btnWidth) * i + marginHorizon * i)
                }
                colorMakeupBtns[i].addTarget(self, action: #selector(onTapCategoryBtn(_:)), for: .touchUpInside)
                mColorMakeupView.addSubview(colorMakeupBtns[i])
                countOfColorMakeupBtn += 1
            }
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
