//
//  WasoCleanserScentView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/20.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoCleanserScentView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setView()
    }
    
    func setView() {
        let width: CGFloat = mScrollView.width
        let height: CGFloat = mScrollView.height
        
        for page in 0...2 {
            let pageView = UIView(frame: CGRect(x: 0, y: height * CGFloat(page), width: width, height: height))

            // 背景
            let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            let image: UIImage = UIImage(named: "cleanser_scent_0\(page + 1).png")!
            imageView.image = image
            pageView.addSubview(imageView)
            
            let productName: UILabel = UILabel(frame: CGRect(x: 80, y: 40, width: 220, height: 0))
            productName.text = AppItemTable.getNameByItemId(itemId: 8029 + page * 8)
            productName.font = UIFont(name: "Reader-Bold", size: 40)
            productName.numberOfLines = 0
            productName.lineBreakMode = NSLineBreakMode.byWordWrapping
            productName.sizeToFit()
        
            let productImageV: UIImageView = UIImageView(frame: CGRect(x: productName.left, y: productName.bottom + 20, width: 220, height: 330))
            let productImage: UIImage = UIImage(named: "waso_570.png")!
            productImageV.image = productImage
            productImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let left: CGFloat = mContentView.centerX - 135
            
            let wanToTitle: UILabel = UILabel()
            wanToTitle.frame = CGRect(x: left, y: productName.top, width: 400, height: 0)
            wanToTitle.text = AppItemTable.getNameByItemId(itemId: 8030 + page * 8)
            wanToTitle.font = UIFont(name: "Reader-Bold", size: 25)
            wanToTitle.numberOfLines = 0
            wanToTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
            wanToTitle.sizeToFit()
            
            let contentTextFrame: CGRect = CGRect(x: left, y: wanToTitle.bottom + 15, width: 430, height: 0)
            let wanToText: UILabel = UILabel(frame: contentTextFrame)
            wanToText.text = AppItemTable.getNameByItemId(itemId: 8031 + page * 8)
            wanToText.font = UIFont(name: "Reader", size: 16)
            wanToText.numberOfLines = 0
            wanToText.lineBreakMode = NSLineBreakMode.byWordWrapping
            wanToText.sizeToFit()
            
            let scentTitle: UILabel = UILabel(frame: CGRect(x: left, y: wanToText.bottom + 40, width: wanToTitle.width, height: 0))
            scentTitle.text = AppItemTable.getNameByItemId(itemId: 8032 + page * 8)
            scentTitle.font = wanToTitle.font
            scentTitle.numberOfLines = 0
            scentTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
            scentTitle.sizeToFit()
            
            let scentText: UILabel = UILabel(frame: contentTextFrame)
            scentText.origin.y = scentTitle.bottom + 15
            scentText.text = AppItemTable.getNameByItemId(itemId: 8033 + page * 8)
            scentText.font = wanToText.font
            scentText.numberOfLines = 0
            scentText.lineBreakMode = NSLineBreakMode.byWordWrapping
            scentText.sizeToFit()
            
            let circleOneImageV: UIImageView = UIImageView()
            circleOneImageV.frame = CGRect(x: left, y: 320, width: 120, height: 120)
            //let circleOneImage: UIImage = UIImage(named: "waso_green_83.png")!
            //circleOneImageV.image = circleOneImage
            circleOneImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            print(circleOneImageV.frame)

            let circleTextFrame = CGRect(x: 0, y: circleOneImageV.bottom + 10, width: 130, height: 0)
            
            let circleOneText: UILabel = UILabel(frame: circleTextFrame)
            circleOneText.text = AppItemTable.getNameByItemId(itemId: 8034 + page * 8)
            circleOneText.font = UIFont(name: "Reader-Medium", size: 16)
            circleOneText.textAlignment = .center
            circleOneText.numberOfLines = 0
            circleOneText.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleOneText.sizeToFit()
            circleOneText.centerX = circleOneImageV.centerX - 5
            
            let circleTwoImageV: UIImageView = UIImageView(frame: circleOneImageV.frame)
            circleTwoImageV.origin.x = circleOneImageV.right + 30
            //let circleTwoImage: UIImage = UIImage(named: "waso_green_83.png")!
            //circleTwoImageV.image = circleTwoImage
            circleTwoImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let circleTwoText: UILabel = UILabel(frame: circleTextFrame)
            circleTwoText.text = AppItemTable.getNameByItemId(itemId: 8035 + page * 8)
            circleTwoText.font = circleOneText.font
            circleTwoText.textAlignment = NSTextAlignment.center
            circleTwoText.numberOfLines = 0
            circleTwoText.lineBreakMode = NSLineBreakMode.byCharWrapping
            circleTwoText.sizeToFit()
            circleTwoText.centerX = circleTwoImageV.centerX
            
            let copyText: UILabel = UILabel(frame: CGRect(x: width - 330, y: height - 90, width: 300, height: 0))
            copyText.text = AppItemTable.getNameByItemId(itemId: 8036 + page * 8)
            copyText.font = UIFont(name: "Reader", size: 12)
            copyText.textColor = UIColor.lightGray
            copyText.numberOfLines = 0
            copyText.lineBreakMode = NSLineBreakMode.byWordWrapping
            copyText.sizeToFit()
            
            pageView.addSubview(productName)
            //pageView.addSubview(productImageV)
            pageView.addSubview(wanToTitle)
            pageView.addSubview(wanToText)
            pageView.addSubview(scentTitle)
            pageView.addSubview(scentText)
            pageView.addSubview(circleOneImageV)
            pageView.addSubview(circleOneText)
            pageView.addSubview(circleTwoImageV)
            pageView.addSubview(circleTwoText)
            pageView.addSubview(copyText)
            
            mContentView.addSubview(pageView)
            
            // レイアウト確認用
//            productName.layer.borderWidth = 1
//            productImageV.layer.borderWidth = 1
//            wanToTitle.layer.borderWidth = 1
//            wanToText.layer.borderWidth = 1
//            scentTitle.layer.borderWidth = 1
//            scentText.layer.borderWidth = 1
//            circleOneImageV.layer.borderWidth = 1
//            circleOneText.layer.borderWidth = 1
//            circleTwoImageV.layer.borderWidth = 1
//            circleTwoText.layer.borderWidth = 1
//            copyText.layer.borderWidth = 1
        }
    }
}
