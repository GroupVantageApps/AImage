//
//  IdealResultCollectionView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/13.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol IdealResultCollectionViewDelegate: IdealResultCellDelegate {
}

class IdealResultCollectionView: BaseView, IdealResultCellDelegate {
    static let idealResultCellTag = "IdealResultCell"
    static let mountVTag = "mountV"
    static let spaceVTag = "SpaceV"

    @IBOutlet weak fileprivate var mVContent: UIView!
    @IBInspectable var horizontalLine: Int = 1
    @IBInspectable var horizontalCellCount: Int = 1
    @IBInspectable var cellCount: Int = 0 {
        didSet {
            addCollectionView(self.cellCount)
        }
    }
    @IBInspectable var titleFontSize: CGFloat = 20.0
    @IBInspectable var subTitleFontSize: CGFloat = 14.0
    @IBInspectable var selected: Bool = false
    @IBInspectable var showedSubTitle: Bool = false
    @IBInspectable var cellAlpha: CGFloat = 0.5

    weak var delegate: IdealResultCollectionViewDelegate?
    var lines: [DataStructLine] = [] {
        didSet {
            cellCount = lines.count
            var i = 0
            for idealResultCell in mIdealResultCells {
                idealResultCell.line = lines[safe: i]
                i += 1
            }
        }
    }

    var selectedLineIds: [Int] = [] {
        didSet {
            let selectedIdealResultCells = mIdealResultCells.filter { idealResultCell -> Bool in
                if let lineId = idealResultCell.line?.lineId {
                     return selectedLineIds.contains(lineId)
                } else {
                    return false
                }
            }
            selectedIdealResultCells.forEach { (selectedIdealResultCell) in
                selectedIdealResultCell.selected = true
            }
        }
    }

    fileprivate var mIdealResultCells: [IdealResultCell] = []
    fileprivate var mIsLayouted: Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCollectionView()
    }

    fileprivate func layoutCollectionView() {
        if mIsLayouted {
            return
        } else {
            mIsLayouted = true
        }
        print("layoutCollectionView")
        let spaceViews: [UIView] = mVContent.subviews.filter {$0.stringTag == IdealResultCollectionView.spaceVTag}
        let mountViews: [UIView] = mVContent.subviews.filter {$0.stringTag == IdealResultCollectionView.mountVTag}
        var constraints: [NSLayoutConstraint] = []
        for spaceView in spaceViews {
            let left = NSLayoutConstraint(item: spaceView, attribute: .left, relatedBy: .equal, toItem: mVContent, attribute: .left, multiplier: 1.0, constant: 0)
            let right = NSLayoutConstraint(item: spaceView, attribute: .right, relatedBy: .equal, toItem: mVContent, attribute: .right, multiplier: 1.0, constant: 0)
            let height = NSLayoutConstraint(item: spaceView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1)
            constraints += [left, right, height]
            if spaceView === spaceViews.first {
                let top = NSLayoutConstraint(item: spaceView, attribute: .top, relatedBy: .equal, toItem: mVContent, attribute: .top, multiplier: 1.0, constant: 0)
                constraints.append(top)
            } else if spaceView === spaceViews.last {
                let bottom = NSLayoutConstraint(item: spaceView, attribute: .bottom, relatedBy: .equal, toItem: mVContent, attribute: .bottom, multiplier: 1.0, constant: 0)
                constraints.append(bottom)
            }
        }
        var i = 0
        for mountView in mountViews {
            let left = NSLayoutConstraint(item: mountView, attribute: .left, relatedBy: .equal, toItem: mVContent, attribute: .left, multiplier: 1.0, constant: 0)
            let right = NSLayoutConstraint(item: mountView, attribute: .right, relatedBy: .equal, toItem: mVContent, attribute: .right, multiplier: 1.0, constant: 0)
            let top = NSLayoutConstraint(item: mountView, attribute: .top, relatedBy: .equal, toItem: spaceViews[i], attribute: .bottom, multiplier: 1.0, constant: 0)
            let bottom = NSLayoutConstraint(item: mountView, attribute: .bottom, relatedBy: .equal, toItem: spaceViews[i+1], attribute: .top, multiplier: 1.0, constant: 0)

            constraints += [left, right, top, bottom]

            if mountView !== mountViews.first {
                let height = NSLayoutConstraint(item: mountView, attribute: .height, relatedBy: .equal, toItem: mountViews.first!, attribute: .height, multiplier: 1.0, constant: 0)
                constraints.append(height)
            }
            i += 1
            let subviewSpaceViews: [UIView] = mountView.subviews.filter {$0.stringTag == IdealResultCollectionView.spaceVTag}
            for spaceView in subviewSpaceViews {
                let top = NSLayoutConstraint(item: spaceView, attribute: .top, relatedBy: .equal, toItem: mountView, attribute: .top, multiplier: 1.0, constant: 0)
                let bottom = NSLayoutConstraint(item: spaceView, attribute: .bottom, relatedBy: .equal, toItem: mountView, attribute: .bottom, multiplier: 1.0, constant: 0)
                var spaceWidthConstant: CGFloat!
                if spaceView === subviewSpaceViews.first || spaceView === subviewSpaceViews.last {
                    spaceWidthConstant = 0
                } else {
                    spaceWidthConstant = 1
                }
                let width = NSLayoutConstraint(item: spaceView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: spaceWidthConstant)
                constraints += [top, bottom, width]
                if spaceView === subviewSpaceViews.first {
                    let left = NSLayoutConstraint(item: spaceView, attribute: .left, relatedBy: .equal, toItem: mVContent, attribute: .left, multiplier: 1.0, constant: 0)
                    constraints.append(left)
                }
            }
            self.layoutInternal(mountView, subviewSpaceViews: subviewSpaceViews)
        }
        mVContent.addConstraints(constraints)
    }

    fileprivate func layoutInternal(_ mountView: UIView, subviewSpaceViews: [UIView]) {
        var constraints: [NSLayoutConstraint] = []
        var j = 0
        let idealResultCells: [UIView] = mountView.subviews.filter {$0.stringTag == IdealResultCollectionView.idealResultCellTag}
        for idealResultCell in idealResultCells {
            let top = NSLayoutConstraint(item: idealResultCell, attribute: .top, relatedBy: .equal, toItem: mountView, attribute: .top, multiplier: 1.0, constant: 0)
            let bottom = NSLayoutConstraint(item: idealResultCell, attribute: .bottom, relatedBy: .equal, toItem: mountView, attribute: .bottom, multiplier: 1.0, constant: 0)
            let width = NSLayoutConstraint(item: idealResultCell, attribute: .width, relatedBy: .equal, toItem: mountView, attribute: .width, multiplier: 1.0 / CGFloat(horizontalCellCount), constant: 0)
            let left = NSLayoutConstraint(item: idealResultCell, attribute: .left, relatedBy: .equal, toItem: subviewSpaceViews[j], attribute: .right, multiplier: 1.0, constant: 0)
            let right = NSLayoutConstraint(item: idealResultCell, attribute: .right, relatedBy: .equal, toItem: subviewSpaceViews[j+1], attribute: .left, multiplier: 1.0, constant: 0)
            constraints += [top, bottom, width, left, right]
            j += 1
        }
        mountView.addConstraints(constraints)
    }

    fileprivate func addCollectionView(_ cellCount: Int) {
        if mVContent.subviews.count != 0 {
            return
        }
        print("addCollectionView")
//        let horizontalLine = Int(ceilf(Float(cellCount) / Float(horizontalCellCount)))
        for i in 0...(horizontalLine-1) {
            let mountView = UIView()
            mountView.translatesAutoresizingMaskIntoConstraints = false
            mountView.stringTag = IdealResultCollectionView.mountVTag
            mVContent.addSubview(mountView)
            var lineCellCount = 0

            if horizontalLine == 1 {
                lineCellCount = cellCount
            } else {
                if i == (horizontalLine - 1) {
                    lineCellCount = horizontalCellCount - (horizontalCellCount * horizontalLine - cellCount)
                } else {
                    lineCellCount = horizontalCellCount
                }
            }

            for i in 0...(horizontalCellCount-1) {
                let idealResultCell = IdealResultCell()
                mIdealResultCells.append(idealResultCell)
                idealResultCell.stringTag = IdealResultCollectionView.idealResultCellTag
                idealResultCell.mainViewAlpha = self.cellAlpha
                idealResultCell.selected = self.selected
                if i < lineCellCount {
                    idealResultCell.delegate = self
                }
                idealResultCell.showedSubTitle = self.showedSubTitle
                idealResultCell.titleFontSize = self.titleFontSize
                idealResultCell.subTitleFontSize = self.subTitleFontSize
                idealResultCell.translatesAutoresizingMaskIntoConstraints = false
                mountView.addSubview(idealResultCell)
            }
            for _ in 0...horizontalCellCount {
                let spaceView = UIView()
                spaceView.translatesAutoresizingMaskIntoConstraints = false
                spaceView.backgroundColor = UIColor.black
                spaceView.stringTag = IdealResultCollectionView.spaceVTag
                mountView.addSubview(spaceView)
            }
        }
        for _ in 0...horizontalLine {
            let spaceView = UIView()
            spaceView.translatesAutoresizingMaskIntoConstraints = false
            spaceView.backgroundColor = UIColor.black
            spaceView.stringTag = IdealResultCollectionView.spaceVTag
            mVContent.addSubview(spaceView)
        }
    }

    // MARK: - IdealResultCellDelegate
    func didTapCell(_ sender: IdealResultCell) {
        sender.selected = !sender.selected
        delegate?.didTapCell(sender)
    }
}
