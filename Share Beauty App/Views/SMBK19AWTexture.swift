//
//  SMBK19AWTexture.swift
//  Share Beauty App
//
//  Created by 大倉 瑠維 on 2019/03/28.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class SMBK19AWTexture: UICollectionViewCell, IdealProductViewDelegate, IdealResultCollectionViewDelegate, TroubleViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var delegate: NavigationControllerDelegate?
    @IBOutlet weak var mSideView: UIView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    var mProductList: ProductListData!
    var selectedTextureProducts: [ProductData] = []
    private var mProductImages: [Int:UIImage]!
    private var mTroubleView: TroubleView!
    private var mShowTrobleIndexes: [Int] = []
    
    @IBOutlet weak var mTextureName: UILabel!
    @IBOutlet weak var mToUse: UILabel!
    @IBOutlet weak var mSubTitleLbl: UILabel!
    
    var indexPath: Int = 0
    var item = 0
    var texture_id = 0

    var productList: [ProductData] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
    }
    
    func setFoundations(products: [ProductData], images: [Int:UIImage]) {
        let sideImage: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.mSideView.frame.size.width, height: self.mSideView.frame.size.height))
        sideImage.image = UIImage(named: "03_back_06")
        sideImage.layer.zPosition = -1
        self.productList = products
        self.mProductImages = images
        self.mSideView.addSubview(sideImage)
        
        mTextureName.text = AppItemTable.getNameByItemId(itemId: 8545)
        mSubTitleLbl.text = AppItemTable.getNameByItemId(itemId: 8546)
        mTextureName.sizeToFit()
        mToUse.text = ""
        mToUse.sizeToFit()

        mCollectionView.register(UINib(nibName: "IdealProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
    }
    
    func setConcealers(products: [ProductData], images: [Int:UIImage]) {
        let sideImage: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.mSideView.frame.size.width, height: self.mSideView.frame.size.height))
        sideImage.image = UIImage(named: "03_back_07")
        sideImage.layer.zPosition = -1
        self.productList = products
        self.mProductImages = images
        self.mSideView.addSubview(sideImage)
        
        mTextureName.text = AppItemTable.getNameByItemId(itemId: 8547)
        mSubTitleLbl.text = AppItemTable.getNameByItemId(itemId: 8548)
        mTextureName.sizeToFit()
        mToUse.text = ""
        mToUse.sizeToFit()
        
        mCollectionView.register(UINib(nibName: "IdealProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        
    }

    func setPowders(products: [ProductData], images: [Int:UIImage]) {
        let sideImage: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.mSideView.frame.size.width, height: self.mSideView.frame.size.height))
        sideImage.image = UIImage(named: "03_back_08")
        sideImage.layer.zPosition = -1
        self.productList = products
        self.mProductImages = images
        self.mSideView.addSubview(sideImage)
        
        mTextureName.text = AppItemTable.getNameByItemId(itemId: 8549)
        mSubTitleLbl.text = AppItemTable.getNameByItemId(itemId: 8550)
        mTextureName.sizeToFit()
        mToUse.text = ""
        mToUse.sizeToFit()
        
        mCollectionView.register(UINib(nibName: "IdealProductView", bundle: nil), forCellWithReuseIdentifier: "cell")
        mCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "space")
        mCollectionView.allowsSelection = false
        mCollectionView.delegate = self
        mCollectionView.dataSource = self        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IdealProductView        
        cell.delegate = self
        cell.product = self.productList[indexPath.row]
        cell.productImage = mProductImages[indexPath.row]
        cell.troubleViewState(mShowTrobleIndexes.contains(indexPath.row))
        cell.indexPath = indexPath
        if self.productList[indexPath.row].newItemFlg == 1 {
            cell.isNew = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var width: CGFloat!
        width = (collectionView.width + 212) / 3.1
        let height: CGFloat = collectionView.height
        return CGSize(width: width, height: height)
    }
    
    func didTapCell(_ sender: IdealResultCell) {
        mCollectionView.reloadData()
    }
    
    func didTapClose() {
        mTroubleView.isHidden = true
    }

    func didTap(_ sender: IdealProductView) {
        let productId: Int? = sender.product?.productId
        if productId == nil {return}

        let productDetailVc = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
        productDetailVc.productId = productId!
        productDetailVc.relationProducts = self.productList
        self.delegate?.nextVc(productDetailVc)
    }
    
    func didTapTrouble(_ sender: DataStructTrouble) {
        mTroubleView.image = FileTable.getImage(sender.image)
        mTroubleView.isHidden = false
    }
    
    func didTapMirror(_ show: Bool, product: ProductData) {
        if show {
            mShowTrobleIndexes.append(self.productList.index(of: product)!)
        } else {
            mShowTrobleIndexes.remove(at: mShowTrobleIndexes.index(of: self.productList.index(of: product)!)!)
        }
    }

}
