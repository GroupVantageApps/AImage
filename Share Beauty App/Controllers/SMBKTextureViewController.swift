//
//  SMBKTextureViewController
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SMBKTextureViewController: UIViewController, NavigationControllerAnnotation, IdealProductViewDelegate, IdealResultCollectionViewDelegate, TroubleViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Makeup Beauty"
    var isEnterWithNavigationView = true
    private let mScreen = ScreenData(screenId: Const.screenIdNewApproach)
    var texture_id = 0
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    var mProductList: ProductListData!
    var selectedTextureProducts: [ProductData] = []
    private var mProductImages: [Int:UIImage]!
    // let productList = [ "1_10": 572, "2_10": 573, "2_11": 574, "2_12": 575, "3_10": 584, "3_11": 586, "3_12": 587, "4_10": 577, "4_11": 578, "4_12": 579, "5_10": 595, "5_11": 596, "5_12": 597 ]
    // let productLists = [572, 573, 574, 575, 584, 586, 587, 577, 578, 579, 595, 596, 597 ]
    private var mTroubleView: TroubleView!
    private var mShowTrobleIndexes: [Int] = []

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
        
        mCollectionView.register(UINib(nibName: "IdealProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
        
        selectedTextureProducts = mProductList.products.filter { $0.texure == mTextureName.text }
        mProductImages = [:]
        selectedTextureProducts.enumerated().forEach { (i: Int, product: ProductData) in
            mProductImages[i] = FileTable.getImage(product.image)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("IdealFirstSelectViewController.viewWillAppear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        viewDidLayoutSubviewsOnce {
            mCollectionView.delegate = self
            mCollectionView.dataSource = self
        }
    }
    
    func didTap(_ sender: IdealProductView) {
        let productId: Int? = sender.product?.productId
        if productId == nil {return}
        
        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = productId!
        productDetailVc.relationProducts = selectedTextureProducts
        self.delegate?.nextVc(productDetailVc)
    }
    
    func didTapTrouble(_ sender: DataStructTrouble) {
        mTroubleView.image = FileTable.getImage(sender.image)
        mTroubleView.isHidden = false
    }
    
    func didTapCell(_ sender: IdealResultCell) {
        mCollectionView.reloadData()
//        var targetIndex: Int?
//
//        if targetIndex != nil {
//            mCollectionView.scrollToItem(at: IndexPath(row: targetIndex!, section: 0), at: .left, animated: true)
//        }
    }
    func didTapClose() {
        mTroubleView.isHidden = true
    }
    
    func didTapMirror(_ show: Bool, product: ProductData) {
        if show {
            mShowTrobleIndexes.append(selectedTextureProducts.index(of: product)!)
        } else {
            mShowTrobleIndexes.remove(at: mShowTrobleIndexes.index(of: selectedTextureProducts.index(of: product)!)!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTextureProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IdealProductView
        cell.delegate = self
        cell.product = selectedTextureProducts[indexPath.row]
        cell.productImage = mProductImages[indexPath.row]
        cell.troubleViewState(mShowTrobleIndexes.contains(indexPath.row))
        cell.indexPath = indexPath
        cell.isNew = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat!
        width = collectionView.width / 3.1
        let height: CGFloat = collectionView.height
        return CGSize(width: width, height: height)
    }
    
}
