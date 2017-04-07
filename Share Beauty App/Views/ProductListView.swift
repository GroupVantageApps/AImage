//
//  ProductListView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/27.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol ProductListViewDelegate: CollectionProductViewDelegate {
}

class ProductListView: BaseView, CollectionProductViewDelegate, UIScrollViewDelegate {
    @IBOutlet private var mVMain: UIView!
    @IBOutlet private var mScrollV: UIScrollView!
    private var mCollectionProductViews: [CollectionProductView] = []

    weak var delegate: ProductListViewDelegate?
    @IBInspectable var holizontalCellCount: Int = 1
    @IBInspectable var varticalCellCount: Int = 1
    var products: [ProductData]! = [] {
        didSet {
            makeCollectionProductView()
            layoutICollectionProductViews()
            var i = 0
            products.forEach({ product in
                if let collectionProductView = mCollectionProductViews[safe: i] {
                    collectionProductView.product = product
                }
                i += 1
            })
        }
    }

    private func makeCollectionProductView() {
        mScrollV.delegate = self
        mScrollV.maximumZoomScale = 3.0
        mScrollV.minimumZoomScale = 1.0

        mVMain.subviews.forEach({ subView in
            subView.removeFromSuperview()
        })

        for _ in 0..<varticalCellCount {
            let mountView = UIView()
            mountView.translatesAutoresizingMaskIntoConstraints = false
            mVMain.addSubview(mountView)
            for _ in 0..<holizontalCellCount {
                let productView = CollectionProductView()
                productView.translatesAutoresizingMaskIntoConstraints = false
                productView.backgroundColor = UIColor.white
                productView.delegate = self
                mountView.addSubview(productView)
                mCollectionProductViews.append(productView)
            }
        }
        self.layoutIfNeeded()
    }

    private func layoutICollectionProductViews() {
        var constraints: [NSLayoutConstraint] = []
        mVMain.subviews.forEach { mountView in
            let left = NSLayoutConstraint.equalLeftEdge(item: mountView, toItem: mVMain)
            let right = NSLayoutConstraint.equalRightEdge(item: mountView, toItem: mVMain)
            constraints += [left, right]
            if mountView === mVMain.subviews.first {
                let top = NSLayoutConstraint.equalTopEdge(item: mountView, toItem: mVMain)
                constraints.append(top)
            } else {
                let height = NSLayoutConstraint.equalHeight(item: mountView, toItem: mVMain.subviews.first!)
                constraints.append(height)
            }
            if mountView === mVMain.subviews.last {
                let bottom = NSLayoutConstraint.equalBottomEdge(item: mountView, toItem: mVMain)
                constraints.append(bottom)
            } else {
                let topBottom = NSLayoutConstraint.connectTopBottomEdge(item: mVMain.subviews.after(mountView)!, toItem: mountView, space: 1)
                constraints.append(topBottom)
            }
            var constraintsMountView: [NSLayoutConstraint] = []
            mountView.subviews.forEach({ productView in
                let top = NSLayoutConstraint.equalTopEdge(item: productView, toItem: mountView)
                let bottom = NSLayoutConstraint.equalBottomEdge(item: productView, toItem: mountView)
                constraintsMountView += [top, bottom]
                if productView === mountView.subviews.first {
                    let left = NSLayoutConstraint.equalLeftEdge(item: productView, toItem: mountView)
                    constraintsMountView.append(left)
                } else {
                    let width = NSLayoutConstraint.equalWidth(item: productView, toItem: mountView.subviews.first!)
                    constraintsMountView.append(width)
                }
                if productView === mountView.subviews.last {
                    let right = NSLayoutConstraint.equalRightEdge(item: productView, toItem: mountView)
                    constraintsMountView.append(right)
                } else {
                    let leftRight = NSLayoutConstraint.connectLeftRightEdge(item: mountView.subviews.after(productView)!, toItem: productView, space: 1)
                    constraintsMountView.append(leftRight)
                }
            })
            mountView.addConstraints(constraintsMountView)
        }
        mVMain.addConstraints(constraints)
    }

    func resetZoom() {
        mScrollV.zoomScale = mScrollV.minimumZoomScale
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVMain
    }

    func didSelectProduct(_ productView: CollectionProductView) {
        delegate?.didSelectProduct(productView)
    }
}
