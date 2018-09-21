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
    }
    
    func setView() {
        let width: CGFloat = mScrollView.width
        let height: CGFloat = mScrollView.height
        
        for page in 0...2 {
            let pageView = UIView(frame: CGRect(x: 0, y: height * CGFloat(page), width: width, height: height))

            // 背景
            let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            let image: UIImage = UIImage(named: "waso_scent_0\(page + 1).png")!
            imageView.image = image
            pageView.addSubview(imageView)
            
            let productName: UILabel = UILabel(frame: CGRect(x: 80, y: 40, width: 150, height: 0))
            productName.text = "WILD GARDEN"
            productName.font = UIFont(name: "Reader-Bold", size: 36)
            productName.numberOfLines = 0
            productName.lineBreakMode = NSLineBreakMode.byWordWrapping
            productName.sizeToFit()
            
            let productImageV: UIImageView = UIImageView(frame: CGRect(x: productName.left, y: productName.bottom + 30, width: 220, height: 330))
            let productImage: UIImage = UIImage(named: "waso_570.png")!
            productImageV.image = productImage
            productImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let wanToTitle: UILabel = UILabel(frame: CGRect(x: mContentView.centerX - 140, y: productName.top, width: 225, height: 0))
            wanToTitle.text = "I want to boost my concentration!"
            wanToTitle.font = UIFont(name: "Reader-Bold", size: 25)
            wanToTitle.numberOfLines = 0
            wanToTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
            wanToTitle.sizeToFit()
            
            let left: CGFloat = wanToTitle.left
            let wanToText: UILabel = UILabel(frame: CGRect(x: left, y: wanToTitle.bottom + 15, width: 430, height: 0))
            wanToText.text = "When you want to focus all your energies on your work and studies.\nThe fresh scent of Wild Garden is perfect for times when you need to refresh and reboot."
            wanToText.font = UIFont(name: "Reader", size: 16)
            wanToText.numberOfLines = 0
            wanToText.lineBreakMode = NSLineBreakMode.byWordWrapping
            wanToText.sizeToFit()
            
            let scentTitle: UILabel = UILabel(frame: CGRect(x: left, y: wanToText.bottom + 40, width: wanToTitle.width, height: 0))
            scentTitle.text = "Scent"
            scentTitle.font = wanToTitle.font
            scentTitle.numberOfLines = 0
            scentTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
            scentTitle.sizeToFit()
            
            let scentText: UILabel = UILabel(frame: wanToText.frame)
            scentText.origin.y = scentTitle.bottom + 15
            scentText.text = "A combination of an elegant floral bouguet and fresh aquatic green for a gentle, pure scent."
            scentText.font = wanToText.font
            scentText.numberOfLines = 0
            scentText.lineBreakMode = NSLineBreakMode.byWordWrapping
            scentText.sizeToFit()
            
            let circleOneImageV: UIImageView = UIImageView(frame: CGRect(x: left, y: scentText.bottom + 40, width: 120, height: 120))
            let circleOneImage: UIImage = UIImage(named: "waso_green_83.png")!
            circleOneImageV.image = circleOneImage
            circleOneImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let circleOneText: UILabel = UILabel(frame: CGRect(x: 0, y: circleOneImageV.bottom + 10, width: circleOneImageV.width + 34, height: 0))
            circleOneText.text = "Increased concentration"
            circleOneText.font = UIFont(name: "Reader-Medium", size: 16)
            circleOneText.textAlignment = .center
            circleOneText.numberOfLines = 0
            circleOneText.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleOneText.sizeToFit()
            circleOneText.centerX = circleOneImageV.centerX
            
            let circleTwoImageV: UIImageView = UIImageView(frame: circleOneImageV.frame)
            circleTwoImageV.origin.x = circleOneImageV.right + 30
            let circleTwoImage: UIImage = UIImage(named: "waso_green_83.png")!
            circleTwoImageV.image = circleTwoImage
            circleTwoImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let circleTwoText: UILabel = UILabel(frame: circleOneText.frame)
            circleTwoText.width = circleTwoImageV.width
            circleTwoText.text = "Able to reset myself"
            circleTwoText.font = circleOneText.font
            circleTwoText.textAlignment = NSTextAlignment.center
            circleTwoText.numberOfLines = 0
            circleTwoText.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleTwoText.sizeToFit()
            circleTwoText.centerX = circleTwoImageV.centerX
            
            let copyText: UILabel = UILabel(frame: CGRect(x: width - 330, y: height - 90, width: 300, height: 0))
            copyText.text = "Tested country : South Africa\nSubject : 103 females, age from 20 y.o. through 33 y.o. Tested term : From 5/2/2018 to 8/2/2018\nafter single use\nTested timing : Morning"
            copyText.font = UIFont(name: "Reader", size: 12)
            copyText.textColor = UIColor.lightGray
            copyText.numberOfLines = 0
            copyText.lineBreakMode = NSLineBreakMode.byWordWrapping
            copyText.sizeToFit()
            
            // レイアウト確認用
            //productName.layer.borderWidth = 1
            //productImageV.layer.borderWidth = 1
            //wanToTitle.layer.borderWidth = 1
            //wanToText.layer.borderWidth = 1
            //scentTitle.layer.borderWidth = 1
            //scentText.layer.borderWidth = 1
            //circleOneImageV.layer.borderWidth = 1
            //circleOneText.layer.borderWidth = 1
            //circleTwoImageV.layer.borderWidth = 1
            //circleTwoText.layer.borderWidth = 1
            //copyText.layer.borderWidth = 1

            pageView.addSubview(productName)
            pageView.addSubview(productImageV)
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
        }
    }
}
