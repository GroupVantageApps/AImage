//
//  SMBKTextureViewController
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/05.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SMBK19AWTextureViewController: UIViewController, NavigationControllerAnnotation, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource {
    var mCollectionView: UICollectionView!
    
    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Makeup Beauty"
    var isEnterWithNavigationView = true
    private let mScreen = ScreenData(screenId: Const.screenIdNewApproach)
    var texture_id = 0
    
    @IBOutlet weak var mScrollV: UIScrollView!
    @IBOutlet weak var mCollectionV: UICollectionView!
    @IBOutlet weak var mMainV: UIView!
    private var mContentWidth: CGFloat = 0

    
    var mProductList: ProductListData!
    var selectedTextureProducts: [ProductData] = []
    var selectedCoTextureProducts: [ProductData] = []
    var selectedFdTextureProducts: [ProductData] = []
    var selectedPoTextureProducts: [ProductData] = []
    var selectedAllTextureProducts: [[ProductData]] = []
    private var mProductImages: [Int:UIImage]!
    private var mTroubleView: TroubleView!
    private var mShowTrobleIndexes: [Int] = []
    var myScrollView = UIScrollView()
    var screenHeight:CGFloat!
    var screenWidth:CGFloat!
    
    @IBOutlet weak var mSideView: UIView!
    @IBOutlet weak var mSideTitle: UILabel!
    @IBOutlet weak var mSideSubText: UILabel!
    @IBOutlet weak var mTextureName: UILabel!
    @IBOutlet weak var mToUse: UILabel!
    
    let mSMKArr = LanguageConfigure.smk_csv
    let mTextureNames = ["DEW TEXTURE", "GEL TEXTURE", "POWDER TEXTURE", "INK TEXTURE"]
    var startPoint : CGPoint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        TODO ScreenIdもらう
        //        self.theme = mScreen.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mCollectionV.register(UINib(nibName: "SMBK19AWTexture", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionV.allowsSelection = false
        
        mCollectionV.delegate = self
        mCollectionV.dataSource = self
        
        mScrollV.delegate = self

        selectedTextureProducts = mProductList.products.filter { $0.beautySecondId == 74 }
        for product in selectedTextureProducts {
            if product.texture == "complexion_Co" {
                selectedCoTextureProducts.append(product)
            } else if product.texture == "complexion_Fd" {
                selectedFdTextureProducts.append(product)
            } else {
                selectedPoTextureProducts.append(product)
            }
        }
        selectedAllTextureProducts.append(selectedCoTextureProducts)
        selectedAllTextureProducts.append(selectedFdTextureProducts)
        selectedAllTextureProducts.append(selectedPoTextureProducts)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        mCollectionV.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mScrollV.contentSize.width = mContentWidth
        mMainV.width = mContentWidth
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mMainV
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedAllTextureProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SMBK19AWTexture
        cell.productList = selectedAllTextureProducts[indexPath.row]
        cell.indexPath = indexPath.row
        cell.texture_id = texture_id
        cell.delegate = self.delegate
        mProductImages = [:]

        if indexPath.row == 0 {
            selectedFdTextureProducts.enumerated().forEach { (i: Int, product: ProductData) in
                mProductImages[i] = FileTable.getImage(product.image)
            }
            cell.setFoundations(products: selectedFdTextureProducts, images: mProductImages)
        } else if indexPath.row == 1 {
            selectedCoTextureProducts.enumerated().forEach { (i: Int, product: ProductData) in
                mProductImages[i] = FileTable.getImage(product.image)
            }
            cell.setConcealers(products: selectedCoTextureProducts, images: mProductImages)
        } else {
            selectedPoTextureProducts.enumerated().forEach { (i: Int, product: ProductData) in
                mProductImages[i] = FileTable.getImage(product.image)
            }
            cell.setPowders(products: selectedPoTextureProducts, images: mProductImages)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.width
        let height: CGFloat = collectionView.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.startPoint = scrollView.contentOffset;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = self.startPoint.y;
    }
}
