//
//  TroubleView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/10/02.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol TroubleViewDelegate: NSObjectProtocol {
    func didTapClose()
}

class TroubleView: BaseView, UIScrollViewDelegate {
    @IBOutlet weak private var mImgV: UIImageView!
    @IBOutlet weak private var mScrollV: UIScrollView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        mScrollV.delegate = self
    }

    var image: UIImage? {
        didSet {
            mImgV.image = self.image
        }
    }
    weak var delegate: TroubleViewDelegate?

    @IBAction func onTapClose(_ sender: AnyObject) {
        self.delegate?.didTapClose()
        mScrollV.zoomScale = 1.0
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mImgV
    }
}
