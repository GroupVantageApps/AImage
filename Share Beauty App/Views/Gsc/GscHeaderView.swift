//
//  GscHeaderView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/21.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

enum GscHeaderViewActionType: Int {
    case home, play, list, update, find, back
}

protocol GscHeaderViewDelegate: NSObjectProtocol {
    func didHeaderViewAction(_ type: GscHeaderViewActionType)
    func didSelectOutApp(index: Int)
}

class GscHeaderView: BaseView {
    @IBOutlet weak private var mBtnHome: BaseButton!
    @IBOutlet weak private var mBtnPlay: BaseButton!
    @IBOutlet weak var mBtnBack: BaseButton!
    @IBOutlet weak var mBtnFind: BaseButton!
    @IBOutlet weak private var mBtnOutApp: BaseButton!
    @IBOutlet weak private var mBtnUpdate: BaseButton!
    @IBOutlet weak private var mConstraintUpdateToOutApp: NSLayoutConstraint!

    @IBOutlet weak var mLblTitle: UILabel!
    @IBOutlet weak private var mImgVShiseido: UIImageView!
    private let mDropDown = DropDown()
    weak var delegate: GscHeaderViewDelegate?

    private var mConstraintWidthZero: NSLayoutConstraint?

    func setDropDown(dataSource: [String]) {
        mDropDown.dataSource = dataSource
        mDropDown.anchorView = mBtnOutApp
        mDropDown.bottomOffset = CGPoint(x: 0, y: mBtnOutApp.height)
        mDropDown.selectionAction = { [unowned self] (index, item) in
            self.delegate?.didSelectOutApp(index: index)
            self.mDropDown.deselectRowAtIndexPath(index)
        }
        mDropDown.direction = .bottom
    }
   
    @IBAction private func onTapHome(_ sender: AnyObject) {
        print(#function)
        delegate?.didHeaderViewAction(.home)
    }
    @IBAction func onTapOutApp(_ sender: Any) {
        print(#function)
        mDropDown.show()
    }
    @IBAction func onTapButton(_ sender: Any) {
        print(#function)
        delegate?.didHeaderViewAction(.update)
    }

    @IBAction func onTapFind(_ sender: Any) {
        print(#function)
        delegate?.didHeaderViewAction(.find)
    }

    @IBAction func onTapBack(_ sender: Any) {
        print(#function)
        delegate?.didHeaderViewAction(.back)
    }
    
    @IBAction func onTapPlay(_ sender: Any) {
        print(#function)
        delegate?.didHeaderViewAction(.play)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }


    func setUpdateEnabled(_ isEnabled: Bool) {
        mBtnUpdate.isHidden = !isEnabled
        if isEnabled {
            mConstraintUpdateToOutApp.constant = 20
            if mConstraintWidthZero != nil {
                mBtnUpdate.removeConstraint(mConstraintWidthZero!)
                mConstraintWidthZero = nil
            }
        } else {
            mConstraintUpdateToOutApp.constant = 0
            if mConstraintWidthZero == nil {
                mConstraintWidthZero = NSLayoutConstraint.makeWidth(item: mBtnUpdate, constant: 0)
                mBtnUpdate.addConstraint(mConstraintWidthZero!)
            }
        }
    }

}
