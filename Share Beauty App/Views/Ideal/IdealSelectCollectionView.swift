//
//  IdealSelectCollectionView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/13.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol IdealSelectCollectionViewDelegate: IdealSelectCellDelegate {
    func didSelectCellSomeone(_ sender: IdealSelectCollectionView)
    func didSelectCellNone(_ sender: IdealSelectCollectionView)
}

class IdealSelectCollectionView: BaseView, IdealSelectCellDelegate {
    @IBOutlet weak fileprivate var mVContent: UIView!
    @IBInspectable var horizontalCellCount: Int = 1
    @IBInspectable var space: CGFloat = 5
    @IBInspectable var titleFontSize: CGFloat = 20.0
    @IBInspectable var subTitleFontSize: CGFloat = 14.0
    @IBInspectable var selected: Bool = false
    @IBInspectable var selectedImgSize: CGFloat = 27
    @IBInspectable var showedSubTitle: Bool = false
    @IBInspectable var cellAlpha: CGFloat = 0.5

    weak var delegate: IdealSelectCollectionViewDelegate?
    var lines: [DataStructLine] = [] {
        didSet {
            addCollectionView(lines.count)
            var i = 0
            for idealSelectCell in mIdealSelectCells {
                idealSelectCell.line = lines[safe: i]
                i += 1
            }
        }
    }

    var stepLowers: [DataStructStepLower] = [] {
        didSet {
            addCollectionView(stepLowers.count)
            var i = 0
            for idealSelectCell in mIdealSelectCells {
                idealSelectCell.stepLower = stepLowers[safe: i]
                if let stepLower = stepLowers[safe: i] {
                    idealSelectCell.enabled = Bool(truncating: stepLower.valid as NSNumber)
                }
                i += 1
            }
        }
    }
    fileprivate var mIsSelectSomeone: Bool = false {
        didSet {
            
            if oldValue == mIsSelectSomeone {
                //return
            }
            if mIsSelectSomeone {
                delegate?.didSelectCellSomeone(self)
            } else {
                delegate?.didSelectCellNone(self)
            }
        }
    }

    fileprivate var mIdealSelectCells: [IdealSelectCell] = []
    fileprivate var mIsLayouted: Bool = false

    override func awakeFromNib() {
        print("======awakeFromNib======")
    }

    override func layoutSubviews() {
        print("======layoutSubviews======")
        super.layoutSubviews()
        layoutCollectionView()
    }

    fileprivate func layoutCollectionView() {
        if mIsLayouted {
            return
        } else {
            mIsLayouted = true
        }

        var mVContentConstraints: [NSLayoutConstraint] = []
        let mountViews = mVContent.subviews
        for mountView in mountViews {
            let left = NSLayoutConstraint(item: mountView, attribute: .left, relatedBy: .equal, toItem: mVContent, attribute: .left, multiplier: 1.0, constant: 0)
            let right = NSLayoutConstraint(item: mountView, attribute: .right, relatedBy: .equal, toItem: mVContent, attribute: .right, multiplier: 1.0, constant: 0)
            mVContentConstraints += [left, right]
            if mountView === mountViews.first {
                let top = NSLayoutConstraint(item: mountView, attribute: .top, relatedBy: .equal, toItem: mVContent, attribute: .top, multiplier: 1.0, constant: 0)
                mVContentConstraints.append(top)
            } else {
                let height = NSLayoutConstraint(item: mountView, attribute: .height, relatedBy: .equal, toItem: mountViews.first!, attribute: .height, multiplier: 1.0, constant: 0)
                mVContentConstraints.append(height)
            }

            if mountView === mountViews.last {
                let bottom = NSLayoutConstraint(item: mountView, attribute: .bottom, relatedBy: .equal, toItem: mVContent, attribute: .bottom, multiplier: 1.0, constant: 0)
                mVContentConstraints.append(bottom)
            } else {
                let bottom = NSLayoutConstraint(item: mountViews.after(mountView)!, attribute: .top, relatedBy: .equal, toItem: mountView, attribute: .bottom, multiplier: 1.0, constant: space)
                mVContentConstraints.append(bottom)
            }
            var mountConstraints: [NSLayoutConstraint] = []
            let idealSelectCells = mountView.subviews
            for idealSelectCell in idealSelectCells {
                let top = NSLayoutConstraint(item: idealSelectCell, attribute: .top, relatedBy: .equal, toItem: mountView, attribute: .top, multiplier: 1.0, constant: 0)
                let bottom = NSLayoutConstraint(item: idealSelectCell, attribute: .bottom, relatedBy: .equal, toItem: mountView, attribute: .bottom, multiplier: 1.0, constant: 0)

                let constant = space * CGFloat(horizontalCellCount - 1) / CGFloat(horizontalCellCount)
                let width = NSLayoutConstraint(item: idealSelectCell, attribute: .width, relatedBy: .equal, toItem: mountView, attribute: .width, multiplier: 1.0 / CGFloat(horizontalCellCount), constant: -constant)

                mountConstraints += [top, bottom, width]

                if idealSelectCell === idealSelectCells.first {
                    let left = NSLayoutConstraint(item: idealSelectCell, attribute: .left, relatedBy: .equal, toItem: mountView, attribute: .left, multiplier: 1.0, constant: 0)
                    mountConstraints.append(left)
                }

                if idealSelectCell !== idealSelectCells.last {
                    let right = NSLayoutConstraint(item: idealSelectCells.after(idealSelectCell)!, attribute: .left, relatedBy: .equal, toItem: idealSelectCell, attribute: .right, multiplier: 1.0, constant: space)
                    mountConstraints.append(right)
                }
            }
            mountView.addConstraints(mountConstraints)
        }
        mVContent.addConstraints(mVContentConstraints)
    }

    fileprivate func addCollectionView(_ cellCount: Int) {
        if mVContent.subviews.count != 0 {
            return
        }
        print("addCollectionView")
        let horizontalLine = Int(ceilf(Float(cellCount) / Float(horizontalCellCount)))

        for i in 0...(horizontalLine-1) {
            let mountView = UIView()
            mountView.translatesAutoresizingMaskIntoConstraints = false
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

            for _ in 0...(lineCellCount-1) {
                let idealSelectCell = IdealSelectCell()
                mIdealSelectCells.append(idealSelectCell)
                idealSelectCell.mainViewAlpha = self.cellAlpha
                idealSelectCell.selected = self.selected
                idealSelectCell.delegate = self
                idealSelectCell.showedSubTitle = self.showedSubTitle
                idealSelectCell.titleFontSize = self.titleFontSize
                idealSelectCell.subTitleFontSize = self.subTitleFontSize
                idealSelectCell.selectedImgSize = self.selectedImgSize
                idealSelectCell.translatesAutoresizingMaskIntoConstraints = false
                mountView.addSubview(idealSelectCell)
            }
        }
    }

    func selectAllCells() {
        mIdealSelectCells.forEach { cell in
            if cell.enabled {
                cell.selected = true
            }
        }
    }

    func deselectAllCells() {
        mIdealSelectCells.forEach { cell in
            if cell.enabled {
                cell.selected = false
            }
        }
    }

    // MARK: - IdealSelectCellDelegate
    func didTapCell(_ sender: IdealSelectCell) {
        sender.selected = !sender.selected
        var isSelectSomeone = false
        for idealSelectCell in mIdealSelectCells {
            if idealSelectCell.selected {
                isSelectSomeone = true
                break
            }
        }
        delegate?.didTapCell(sender)
        mIsSelectSomeone = isSelectSomeone
    }
}
