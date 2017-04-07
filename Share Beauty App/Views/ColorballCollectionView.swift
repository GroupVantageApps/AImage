//
//  ColorballCollectionView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/10/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class ColorballCollectionView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet private weak var mCollectionView: UICollectionView!

    var cellWidth: CGFloat = 100
    var cellHeight: CGFloat = 100

    var contentSize: CGSize {
        get {
            return mCollectionView.contentSize
        }
    }

    var collorballs = [DataStructColorball]() {
        didSet {
            let nib = UINib(nibName: "ColorballView", bundle: nil)
            mCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
            mCollectionView.delegate = self
            mCollectionView.dataSource = self
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorballView
        cell.colorball = collorballs[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collorballs.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
