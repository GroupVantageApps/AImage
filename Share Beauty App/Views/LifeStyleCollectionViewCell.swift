//
//  LifeStyleCollectionViewCell.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/11/11.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

protocol LifeStyleCollectionViewCellDelegate: NSObjectProtocol {
    func didSelect(index: Int)
    func didTapRecommend(index: Int)
}

class LifeStyleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var mBtnImage: BaseButton!
    @IBOutlet weak private var mBtnRecommend: BaseButton!
    @IBOutlet weak private var mTxtV: UITextView!
    @IBOutlet weak private var mVFocus: UIView!
    @IBOutlet weak var mCountsLabel: UILabel!

    var isRecommend: Bool = false {
        didSet {
            mBtnRecommend.isSelected = self.isRecommend
        }
    }

    var image: UIImage? {
        didSet {
            mBtnImage.setImage(image, for: .normal)
        }
    }

    var text: String = "" {
        didSet {
            if let attributeStr = self.makeStringFromhtml(string: text) {
                mTxtV.attributedText = attributeStr
            }
        }
    }

    var index: Int = 0

    weak var delegate: LifeStyleCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.isUserInteractionEnabled = false
        mBtnRecommend.imageView?.contentMode = .scaleToFill
    }

    private func makeStringFromhtml(string: String) -> NSAttributedString? {
        do {
            let encodedData = string.data(using: String.Encoding.utf8)!
            let attributedOptions: [String : AnyObject] = [
                NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType as AnyObject, //表示データのドキュメントタイプ
                NSCharacterEncodingDocumentAttribute : String.Encoding.utf8.rawValue as AnyObject, //表示データの文字エンコード
            ]
            //文字列の変換処理の実装（try 〜 catch構文を使っています。）
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            //HTMLとしてUITextViewに表示する
            return attributedString
        } catch {
            return nil
        }
    }

    func focusAnimation() {
        mVFocus.alpha = 0
        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            options: [.repeat, .autoreverse, .curveEaseIn		],
            animations: {
                self.mVFocus.alpha = 1
        },
            completion: nil
        )
    }
    func resetAnimation() {
        mVFocus.layer.removeAllAnimations()
        mVFocus.alpha = 0
    }

    @IBAction private func onTapImage(_ sender: Any) {
        self.delegate?.didSelect(index: self.index)
    }

    @IBAction func onTapRecommend(_ sender: Any) {
        self.delegate?.didTapRecommend(index: self.index)
    }
}
