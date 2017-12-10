//
//  GscResultViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
class GscResultViewController: GscBaseViewController, UIScrollViewDelegate, GscHeaderViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLXTop)
    weak var delegate: NavigationControllerDelegate?
    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL, Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL]    

    @IBOutlet var mBtnOutApp: BaseButton!
    private let mDropDown = DropDown()
    
    @IBOutlet weak var mGscHeaderView: GscHeaderView!
    var lxArr = [String : String]()
    private var mConstraintWidthZero: NSLayoutConstraint?
    
    @IBOutlet weak var mThumnailCollectionV: UICollectionView!
    var mGroupType: String = ""
    var mSelect1Type: String = ""
    var mSelect2Type: String = ""
    var mThumnailProducts :[ProductData] = [ProductData]()
    var mTapLabel: UILabel!
    var mFindLabel: UILabel!
    
    var mBaseView: UIView!
    
    @IBOutlet weak var mProductNameV: UIView!
    @IBOutlet weak var mBGImgV: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mGscHeaderView.delegate = self
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            mGscHeaderView.setDropDown(dataSource: type(of: self).outAppFoundationInfos.map {$0.title})
        } else {
            mGscHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        }
        
        let selfWidth = self.view.bounds.width
        let selfHeight = self.view.bounds.height
        
        //SuncareLIneのProductデータ取得
        mThumnailProducts = ProductListData.init(lineId: 17).products
        mThumnailCollectionV.dataSource = self
        mThumnailCollectionV.delegate = self
        mThumnailCollectionV.reloadData()
        
        mScrollV.delegate = self
        
        let gscArr = LanguageConfigure.gsccsv
        
        
        //TODO
        mGroupType = LanguageConfigure.gscgroup
        if mGroupType == "A" {
            if mSelect1Type == "face" {
                mGscHeaderView.mLblTitle.text = gscArr["4"]
            } else {
                mGscHeaderView.mLblTitle.text = gscArr["5"]
                
            }
        } else {
            if mGroupType == "E" {
                if mSelect2Type == "active" {
                    mGscHeaderView.mLblTitle.text = gscArr["9"]
                }
                if mSelect2Type == "urban" {
                    mGscHeaderView.mLblTitle.text = gscArr["8"]
                }
                if mSelect2Type == "child" {
                    mGscHeaderView.mLblTitle.text = gscArr["7"]
                }
                if mSelect2Type == "sensitive" {
                    mGscHeaderView.mLblTitle.text = gscArr["6"]
                }
            } else {
                if mSelect2Type == "urban" {
                    mGscHeaderView.mLblTitle.text = gscArr["16"]
                }
                if mSelect2Type == "active" {
                    mGscHeaderView.mLblTitle.text = gscArr["17"]
                }
                if mSelect2Type == "child" {
                    mGscHeaderView.mLblTitle.text = gscArr["15"]
                }
                
            }
            
        }
        let bgImg = UIImage.init(named: "suncare_bg")
        mBGImgV.image = bgImg
        mVContent.bringSubview(toFront: mGscHeaderView)
        
        
        let selectLbl = UILabel.init(frame: CGRect(x: 5, y: 5, width: 45, height: 50))
        selectLbl.font = UIFont.init(name: "Optima-Bold", size: 12.0)
        selectLbl.numberOfLines = 2
        selectLbl.adjustsFontSizeToFitWidth = true
        selectLbl.textColor = UIColor.init(red: 0.25, green: 0.57, blue: 0.77, alpha: 1.0)
        mProductNameV.addSubview(selectLbl)
    
        if mSelect1Type == "face" {
            selectLbl.text = gscArr["4"]
        }else{
            selectLbl.text = gscArr["5"]
        }
        
        
            let dataDic = LanguageConfigure.gscplist
            print("dataDic:\(dataDic)")
            
            let desDic = dataDic[String(format: "description_%@", mSelect1Type)] as? Dictionary<String, AnyObject>
            
            let gcodeDic = dataDic["gcode"] as? Dictionary<String, AnyObject>
        
            let typeDic = dataDic["type"] as? Dictionary<String, AnyObject>
            
            print("desDic:\(String(describing: desDic))")
            print("gcodeDic:\(String(describing: gcodeDic))")
            print("typeDic:\(String(describing: typeDic))")
            
            if (gcodeDic != nil) {
                var productList :[String] = []
                
                if mGroupType == "A" {
                    if gcodeDic?[mSelect1Type] as! [String]  != nil {
                        productList = gcodeDic?[mSelect1Type] as! [String] 
                        
                    }
                } else {
                    let upperDic = gcodeDic?[mSelect1Type] as? Dictionary<String, AnyObject>
                    if upperDic?[mSelect2Type] as! [String] != nil {
                        productList = upperDic?[mSelect2Type] as! [String] 
                    } else {
                        
                    }
                }
                
                //defaultDisplay が 1のproductのみ表示
                //                let disPlayProductList = productList.filter { 
                //                    ProductData.init(productId: Int($0)!).defaultDisplay == 1
                //                }
                
                
                //imgがあるもののみ表示
                let disPlayProductList = productList.filter { 
                    FileTable.getImage(ProductData.init(productId: Int($0)!).image) != nil
                }
                
                let product = ProductData.init(productId: Int(productList[0])!)
                
                for (i, productId) in disPlayProductList.enumerated() {
                    let product = ProductData.init(productId: Int(productId)!)
                    let imgId = product.image
                    let img = FileTable.getImage(imgId)
                    
                    var x = i*240
                    var descriptionLabelWidth = 240
                    var margin_x = 0
                    
                    
                    if disPlayProductList.count < 5 {
                        x = i*240
                    } else if disPlayProductList.count == 5 {
                        x = i*200
                        descriptionLabelWidth = 200 - 20
                        margin_x = -20
                    } else {
                        x = i*160
                        descriptionLabelWidth = 160 - 20
                        margin_x = -40
                    }
                    
                    if (img != nil) {
                        let productImgV = UIImageView.init(image: img)
                        
                        productImgV.frame = CGRect(x: -55.0 + Double(margin_x) + Double(x), y: 160, width: 860/2*0.9, height: 819/2*0.9)
                        productImgV.layer.shadowColor = UIColor.black.cgColor
                        productImgV.layer.shadowOffset = CGSize(width: 15, height: 15)
                        productImgV.layer.shadowOpacity = 0.5
                        productImgV.layer.shadowRadius  = 10
                        productImgV.clipsToBounds = false
                        
                        if disPlayProductList.count > 5 {
                            if mGroupType == "A"{
                                productImgV.frame = CGRect(x: -55.0 + 10 + Double(x), y: 215, width: 860/2*0.9 - 100, height: 819/2*0.9 - 100)
                                productImgV.contentMode = .scaleAspectFill
                            }else{
                                productImgV.frame = CGRect(x: -55.0 + 10 + Double(x), y: 260, width: 860/2*0.9 - 100, height: 819/2*0.9 - 100)
                                productImgV.contentMode = .scaleAspectFill
                            }
                        }
                        
                        mVContent.addSubview(productImgV)
                    }
                    //下の白いバーの中の商品名
                    let productNameLbl = UILabel.init(frame: CGRect(x: 90 + margin_x + x, y: 5, width: descriptionLabelWidth, height: 30))
                    productNameLbl.font = UIFont.init(name: "Optima-Bold", size: 14.0)
                    productNameLbl.numberOfLines = 3
                    
                    productNameLbl.text = product.productName
                    
                    productNameLbl.textColor = UIColor.black
                    productNameLbl.adjustsFontSizeToFitWidth = true
                    mProductNameV.addSubview(productNameLbl)
                    
                    
                    if productId == "549" {//productId == "549"
                        let useTypeLbl = UILabel.init(frame: CGRect(x: 90 + margin_x + x, y: 135, width: 97, height: 30))
                        useTypeLbl.font = UIFont.init(name: "Optima-Bold", size: 12.0)
                        useTypeLbl.numberOfLines = 2
                        useTypeLbl.text =  AppItemTranslateTable.getEntity(7946).name
                        useTypeLbl.backgroundColor = UIColor.white
                        useTypeLbl.textColor = UIColor.init(red: 0.03, green: 0.31, blue: 0.51, alpha: 1.0)
                        useTypeLbl.adjustsFontSizeToFitWidth = true
                        useTypeLbl.textAlignment = .center;
                        mVContent.addSubview(useTypeLbl)
                    
                    }else{
                        let useTypeLbl = UILabel.init(frame: CGRect(x: 90 + margin_x + x, y: 135, width: 97, height: 30))
                        useTypeLbl.font = UIFont.init(name: "Optima-Bold", size: 12.0)
                        useTypeLbl.numberOfLines = 2
                        useTypeLbl.adjustsFontSizeToFitWidth = true
                        useTypeLbl.textAlignment = .center;
                        mVContent.addSubview(useTypeLbl)
                        
                        if mGroupType == "A"{
                            let productUseType = typeDic?[productId] as! String
                            switch productUseType {
                            case "urban" :
                                useTypeLbl.text = gscArr["12"]
                                useTypeLbl.backgroundColor = UIColor.white
                                useTypeLbl.textColor = UIColor.init(red: 0.03, green: 0.31, blue: 0.51, alpha: 1.0)
                            case "active" :
                                useTypeLbl.text = gscArr["13"]
                                useTypeLbl.backgroundColor = UIColor.init(red: 0.99, green: 0.69, blue: 0.24, alpha: 1.0)
                                useTypeLbl.textColor = UIColor.init(red: 0.10, green: 0.33, blue: 0.49, alpha: 1.0)
                            case "children" :
                                useTypeLbl.text = gscArr["14"]
                                useTypeLbl.backgroundColor = UIColor.init(red: 0.67, green: 0.84, blue: 0.93, alpha: 1.0)
                                useTypeLbl.textColor = UIColor.black
                            case "lip" :
                                useTypeLbl.text =  gscArr["23"] ?? "not set No.23"
                                useTypeLbl.backgroundColor = UIColor.white
                                useTypeLbl.textColor = UIColor.init(red: 0.03, green: 0.31, blue: 0.51, alpha: 1.0)
                            case "anytime" :
                                useTypeLbl.text =  gscArr["22"] ?? "not set No.22"
                                useTypeLbl.backgroundColor = UIColor.white
                                useTypeLbl.textColor = UIColor.init(red: 0.03, green: 0.31, blue: 0.51, alpha: 1.0)
                            default:
                                break
                            }
                        }
                       
                        
                    }
                    
                    
                }
                
                
                
                
                for (i, productId) in disPlayProductList.enumerated() {
                    let product = ProductData.init(productId: Int(productId)!)
                    var x = i*240
                    var w = 240
                    var margin_x = 70
                    if disPlayProductList.count < 5 {
                        x = i*240
                    } else if disPlayProductList.count == 5 {
                        x = i*200
                        w = 200 - 20
                        margin_x = 50
                    } else {
                        x = i*160
                        w = 160 - 20
                        margin_x = 40
                    }
                    
                    let productBtn = UIButton.init(frame: CGRect(x: margin_x + x, y: 130, width: w, height: 350))
                    productBtn.tag = Int(productId)!
                    productBtn.titleLabel?.text = ""
                    productBtn.addTarget(self, action: #selector(GscResultViewController.goDetailVc), for: .touchUpInside)
                    mVContent.addSubview(productBtn)
                    
                }
 
            }
        
        let subTitleLbl = UILabel.init(frame: CGRect(x: 20, y: 60, width: 500, height: 50))
        subTitleLbl.font = UIFont.init(name: "Optima-Bold", size: 20.0)
        subTitleLbl.text = gscArr["10"]
        subTitleLbl.textColor = UIColor.white
        mVContent.addSubview(subTitleLbl)
        
        if mGroupType == "A"{
            
            let customLetterSpacing = 0.5
            let AgroupSubTitleLbl = UILabel.init(frame: CGRect(x: 240, y: 60, width: 750, height: 50))
            AgroupSubTitleLbl.font = UIFont.init(name: "Optima-Bold", size: 16.0)
            AgroupSubTitleLbl.numberOfLines = 0
            let attributedText = NSMutableAttributedString.init(string: gscArr["18"] ?? "content is null" )
            attributedText.addAttribute(NSKernAttributeName, value: customLetterSpacing, range: NSRange(location: 0, length: attributedText.length))
            AgroupSubTitleLbl.attributedText = attributedText
            AgroupSubTitleLbl.textColor = UIColor.black
            AgroupSubTitleLbl.adjustsFontSizeToFitWidth = true
            mVContent.addSubview(AgroupSubTitleLbl)
        }
        
            
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("GscViewController.viewWillAppear")
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        print("GscViewController.viewDidAppear")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("GscViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("GscViewController.viewDidDisappear")
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
    @IBAction func outApp(_ sender: Any) {
        mDropDown.show()
    }
    
    @IBAction func goTop(_ sender: Any) {
        self.showTop()
    }
    
    func goDetailVc(_ sender: Any) {
        //TODO
        let tag = (sender as AnyObject).tag
        print(tag ?? 0)
        let product = ProductData.init(productId: tag ?? 0)
        if product.productId != 0 {
            print(product.productId)
            
            let nextVc = UIViewController.GetViewControllerFromStoryboard("GscNavigationViewController", targetClass: GscNavigationViewController.self) as! GscNavigationViewController
            nextVc.mProductId = product.productId
            self.navigationController?.pushViewController(nextVc, animated: false)
            
        }
    }
    
    // colllectionViewDelegate 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return mThumnailProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GscCell", for: indexPath as IndexPath) as! GscThumnailCollectionViewCell
        
        let product = mThumnailProducts[indexPath.row]
        cell.mThumnailImgV.image =  FileTable.getImage(product.image)
        cell.mNameLbl.text = product.productName
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = mThumnailProducts[indexPath.row]
        print(product.productName)
        print(product.productId)
        if product.productId != 0 {
            print(product.productId)
            
            let nextVc = UIViewController.GetViewControllerFromStoryboard("GscNavigationViewController", targetClass: GscNavigationViewController.self) as! GscNavigationViewController
            nextVc.mProductId = product.productId
            self.navigationController?.pushViewController(nextVc, animated: false)
            
        }
    }

}
