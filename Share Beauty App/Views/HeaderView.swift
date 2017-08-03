//
//  HeaderView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/08/21.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

enum HeaderViewActionType: Int {
    case home, skip, list, update, shiseido
}

protocol HeaderViewDelegate: NSObjectProtocol {
    func didHeaderViewAction(_ type: HeaderViewActionType)
    func didSelectOutApp(index: Int)
}

class HeaderView: BaseView {
    @IBOutlet weak private var mBtnSkip: BaseButton!
    @IBOutlet weak private var mBtnOutApp: BaseButton!
    @IBOutlet weak private var mBtnUpdate: BaseButton!
	@IBOutlet weak var mBtnShiseido: BaseButton!
    @IBOutlet weak private var mConstraintUpdateToOutApp: NSLayoutConstraint!
	@IBOutlet weak var mConstraintShiseidoToUpdate: NSLayoutConstraint!

    private let mDropDown = DropDown()
    weak var delegate: HeaderViewDelegate?

    private var mConstraintWidthZero: NSLayoutConstraint?
	private var mShiseidoConstraintWidthZero: NSLayoutConstraint?

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

    @IBAction private func onTapList(_ sender: AnyObject) {
        delegate?.didHeaderViewAction(.list)
    }

    @IBAction private func onTapHome(_ sender: AnyObject) {
        delegate?.didHeaderViewAction(.home)
    }
    @IBAction private func onTapSkip(_ sender: AnyObject) {
        delegate?.didHeaderViewAction(.skip)
    }
    @IBAction func onTapOutApp(_ sender: Any) {
        mDropDown.show()
    }
    @IBAction func onTapButton(_ sender: Any) {
        delegate?.didHeaderViewAction(.update)
    }
	@IBAction func onTapShiseido(_ sender: Any) {
		delegate?.didHeaderViewAction(.shiseido)
	}

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }

    func showSkipButton(_ show: Bool, animateDuration: TimeInterval?) {
        if animateDuration == nil {
            mBtnSkip.alpha = CGFloat(show as NSNumber)
        } else {
            UIView.animateIgnoreInteraction(
                duration: animateDuration!,
                animations: {
                    self.mBtnSkip.alpha = CGFloat(show as NSNumber)
                },
                completion: { finished in
                }
            )
        }
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
	
    func setOutAppEnabled(_ isEnabled: Bool) {
        mBtnOutApp.isHidden = !isEnabled
        if isEnabled {
            mConstraintUpdateToOutApp.constant = 20
            if mConstraintWidthZero != nil {
                mBtnOutApp.removeConstraint(mConstraintWidthZero!)
                mConstraintWidthZero = nil
            }
        } else {
            mConstraintUpdateToOutApp.constant = 0
            if mConstraintWidthZero == nil {
                mConstraintWidthZero = NSLayoutConstraint.makeWidth(item: mBtnOutApp, constant: 0)
                mBtnOutApp.addConstraint(mConstraintWidthZero!)
            }
        }
    }
    
	func setAboutShiseidoEnabled(_ isEnabled: Bool) {
		mBtnShiseido.isHidden = !isEnabled
		if isEnabled {
			mConstraintShiseidoToUpdate.constant = 20
			if mShiseidoConstraintWidthZero != nil {
				mBtnShiseido.removeConstraint(mShiseidoConstraintWidthZero!)
				mShiseidoConstraintWidthZero = nil
			}
		} else {
			mConstraintShiseidoToUpdate.constant = 0
			if mShiseidoConstraintWidthZero == nil {
				mShiseidoConstraintWidthZero = NSLayoutConstraint.makeWidth(item: mBtnShiseido, constant: 0)
				mBtnShiseido.addConstraint(mShiseidoConstraintWidthZero!)
			}
		}
	}
}
