//
//  PagingHorizontalLayout.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/02/27.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class PagingHorizontalLayout: UICollectionViewLayout {

    var numberOfColumnsVertical: CGFloat!
    var numberOfColumnsHorizontal: CGFloat!
    var numberOfColumns: CGFloat!
    var space: CGFloat = 1

    var cache = [IndexPath:UICollectionViewLayoutAttributes]()

    private var itemSize: CGSize!

    override func prepare() {
        super.prepare()

        if !cache.isEmpty {
            return
        }

        guard let collectionView = self.collectionView else {
            return
        }

        let productParList = numberOfColumnsVertical * numberOfColumnsHorizontal
        let listCount = ceil(numberOfColumns / productParList)
        itemSize = CGSize(width: collectionView.width * listCount , height: collectionView.height)

        let columnWidth = (collectionView.width - space * (numberOfColumnsHorizontal - 1)) / CGFloat(numberOfColumnsHorizontal)
        let columnHeight = (collectionView.height - space * (numberOfColumnsVertical - 1)) / CGFloat(numberOfColumnsVertical)

        for section in 0..<collectionView.numberOfSections {
            let indexes = (0 ..< collectionView.numberOfItems(inSection: section)).map {$0}
            let lists = indexes.chunk(Int(productParList))
            var item = 0
            lists.enumerated().forEach { (i: Int, list: [Int]) in
                let verticals = list.chunk(Int(numberOfColumnsHorizontal))
                verticals.enumerated().forEach { (j: Int, vertical: [Int]) in
                    (0 ..< vertical.count).forEach { k in
                        let indexPath = IndexPath(item: item, section: section)

                        let x: CGFloat = collectionView.width * CGFloat(i) + columnWidth * CGFloat(k) + space * CGFloat(k)
                        let y: CGFloat = columnHeight * CGFloat(j) + space * CGFloat(j)

                        let frame = CGRect(x: x,
                                           y: y,
                                           width: columnWidth,
                                           height: columnHeight)
                        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                        attributes.frame = frame
                        cache[indexPath] = attributes
                        item += 1
                    }
                }
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var allAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in self.cache.values {

            if rect.intersects(attributes.frame) {
                allAttributes.append(attributes)
            }
        }

        return allAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath]
    }

    override var collectionViewContentSize: CGSize {
        return itemSize
    }
}
