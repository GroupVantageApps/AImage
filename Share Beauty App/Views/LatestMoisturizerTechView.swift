//
//  LatestMoisturizerTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LatestMoisturizerTechView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mFirstView: UIView!
    @IBOutlet weak var mSecondView: UIView!
    @IBOutlet weak var mThirdView: UIView!
    
    @IBOutlet weak var mCaseOneView: UIView!
    @IBOutlet weak var mCaseTwoView: UIView!
    
    private var firstTitle: UILabel = UILabel()
    private var firstSubText: UILabel = UILabel()
    
    private var productId: Int = 0
    private var isCase: Int = 0
    private let caseOneList: [Int] = [602, 614, 605, 604]
    private var textColor: UIColor = UIColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setView(productId: Int) {
        self.productId = productId

        if caseOneList.contains(self.productId) {
            self.isCase = 1
            self.textColor = UIColor(hex: "9c8170", alpha: 1)
        } else {
            self.isCase = 2
            self.textColor = UIColor(hex: "b1457c", alpha: 1)
        }
        self.setFirstView()
        self.setSecondView()
        self.setThirdView()
    }
    
    func setFirstView() {
        firstTitle.frame = CGRect(x: 0, y: 40, width: 0, height: 0)
        firstTitle.text = "ReNeura Technology+"
        firstTitle.font = UIFont(name: "Reader-Bold", size: 32)
        firstTitle.textAlignment = NSTextAlignment.center
        firstTitle.sizeToFit()
        firstTitle.centerX = mScrollView.centerX
        mFirstView.addSubview(firstTitle)

        firstSubText.frame = CGRect(x: 0, y: firstTitle.bottom + 20, width: 800, height: 0)
        firstSubText.text = "Works on the skin’s sensory nerves so it can smoothly detect and transmit information, even when it has started to show the effects of time. It enables the skin to quickly detect aging signs, quickening its self-repair and self-regeneration processes."
        firstSubText.font = UIFont(name: "Reader-Medium", size: 19)
        firstSubText.numberOfLines = 0
        firstSubText.lineBreakMode = NSLineBreakMode.byWordWrapping
        firstSubText.sizeToFit()
        firstSubText.centerX = mScrollView.centerX
        mFirstView.addSubview(firstSubText)
        
        for index in -1...1 {

            let circleSize: CGFloat = 280
            let circleView: UIView = UIView()
            circleView.frame = CGRect(x: 0, y: firstSubText.bottom + 50, width: circleSize, height: circleSize)
            circleView.layer.borderWidth = 1
            circleView.layer.cornerRadius = circleSize / 2
            circleView.backgroundColor = UIColor(hex: "ffffff", alpha: 0.5)
            circleView.centerX = mScrollView.centerX + CGFloat(260 * index)

            let imageV: UIImageView = UIImageView()
            imageV.frame = CGRect(x: 0, y: 40, width: 150, height: 110)
            //let image: UIImage = UIImage(named: "Iris_1_cmyk.png")!
            //imageV.image = image
            imageV.contentMode = UIViewContentMode.scaleAspectFit
            imageV.centerX = circleSize / 2
            imageV.layer.borderWidth = 1

            let markSize: CGFloat = 45
            let newMark: UIView = UIView()
            newMark.frame = CGRect(x: imageV.left - 15, y: imageV.top - 15, width: markSize, height: markSize)
            newMark.layer.cornerRadius = markSize / 2
            newMark.backgroundColor = UIColor(hex: "d62631", alpha: 1)
            if index == 0 {
                newMark.isHidden = false
            } else {
                newMark.isHidden = true
            }
            newMark.layer.borderWidth = 3
            newMark.layer.setBorderUIColor(UIColor.white)

            let markLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            markLabel.text = "NEW"
            markLabel.font = UIFont(name: "Reader-Bold", size: 12)
            markLabel.textColor = UIColor.white
            markLabel.sizeToFit()
            markLabel.center = CGPoint(x: markSize / 2, y: markSize / 2 + 1)
            markLabel.isHidden = false
            newMark.addSubview(markLabel)

            let imageTitle: UILabel = UILabel()
            imageTitle.frame = CGRect(x: 0, y: imageV.bottom + 5, width: 0, height: 0)
            imageTitle.text = "Active Response Powder"
            imageTitle.font = UIFont(name: "Reader-Bold", size: 13)
            imageTitle.textAlignment = NSTextAlignment.center
            imageTitle.sizeToFit()
            imageTitle.centerX = imageV.centerX

            let circleTitle: UILabel = UILabel()
            circleTitle.frame = CGRect(x: 0, y: imageTitle.bottom + 10, width: 0, height: 0)
            circleTitle.text = "2.RESPOND"
            circleTitle.font = UIFont(name: "Reader-Bold", size: 19)
            circleTitle.textAlignment = NSTextAlignment.center
            circleTitle.sizeToFit()
            circleTitle.centerX = imageV.centerX

            let description: UILabel = UILabel()
            description.frame = CGRect(x: 0, y: circleTitle.bottom + 5, width: imageV.width + 15, height: 0)
            description.text = "Prevents β noise and detects signs of aging, dryness, and UV damage by improving sensory communication."
            description.font = UIFont(name: "Reader", size: 10)
            description.textAlignment = NSTextAlignment.center
            description.numberOfLines = 0
            description.lineBreakMode = NSLineBreakMode.byWordWrapping
            description.sizeToFit()
            description.centerX = imageV.centerX
            
            circleView.addSubview(imageV)
            circleView.addSubview(newMark)
            circleView.addSubview(imageTitle)
            circleView.addSubview(circleTitle)
            circleView.addSubview(description)
            mFirstView.addSubview(circleView)
        }
    }
    
    func setSecondView() {
        let backImageV: UIImageView = UIImageView(frame: mScrollView.frame)
        let backImage: UIImage = UIImage(named: "moisture_tech_02_0\(isCase)")!
        backImageV.contentMode = UIViewContentMode.scaleAspectFit
        backImageV.image = backImage
        mSecondView.addSubview(backImageV)
        
        var title: String = String()
        var text: String = String()
        if isCase == 1 {
            mCaseOneView.isHidden = false
            mCaseTwoView.isHidden = true
            title = "KOMBU-Bounce Complex"
            text = "KOMBU-Bounce Complex contains powerful ocean minerals that nurture skin and visibly reduce wrinkles."
        } else if isCase == 2 {
            mCaseOneView.isHidden = true
            mCaseTwoView.isHidden = false
            title = "SAKURA-Bright Complex"
            text = "Sakura-BRIGHT Complex,which contains extract from the Yoshino cherry tree,targets the root cause of dark spots and visibly improves uneven skin tone.*"
        }
        
        let secondTitle: UILabel = UILabel()
        secondTitle.frame = CGRect(x: 0, y: 30, width: 0, height: 0)
        secondTitle.text = title
        secondTitle.font = firstTitle.font
        secondTitle.textColor = self.textColor
        secondTitle.textAlignment = NSTextAlignment.center
        secondTitle.sizeToFit()
        secondTitle.centerX = mScrollView.centerX
        mSecondView.addSubview(secondTitle)
        
        let secondSubText: UILabel = UILabel()
        secondSubText.frame = CGRect(x: 0, y: 0, width: 800, height: 0)
        secondSubText.text = text
        secondSubText.font = UIFont(name: "Reader-Medium", size: 24)
        secondSubText.textColor = self.textColor
        secondSubText.textAlignment = isCase == 1 ? NSTextAlignment.center : NSTextAlignment.left
        secondSubText.numberOfLines = 0
        secondSubText.lineBreakMode = NSLineBreakMode.byWordWrapping
        secondSubText.sizeToFit()
        secondSubText.centerX = mScrollView.centerX
        secondSubText.centerY = secondTitle.bottom + 40
        mSecondView.addSubview(secondSubText)
        
//        secondTitle.layer.borderWidth = 1
//        secondSubText.layer.borderWidth = 1
        
        if isCase == 1 {
            setCaseOneView(upperObject: secondSubText)
        } else if isCase == 2 {
            setCaseTwoView(upperObject: secondSubText)
        }
        mSecondView.addSubview(mCaseOneView)
        mSecondView.addSubview(mCaseTwoView)
    }
    
    func setCaseOneView(upperObject: AnyObject) {
        let caseMargin: CGFloat = 50
        let caseViewWidth: CGFloat = mScrollView.width - caseMargin * 2
        let caseViewHeight: CGFloat = mScrollView.height - upperObject.bottom - 20
        
        mCaseOneView.frame = CGRect(x: caseMargin, y: upperObject.bottom + 10, width: caseViewWidth, height: caseViewHeight)
        
        let leftView: UIView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: caseViewWidth / 2, height: caseViewHeight)
        
        let rightView: UIView = UIView()
        rightView.frame = CGRect(x: leftView.right, y: 0, width: caseViewWidth / 2, height: caseViewHeight)
        
        // leftView
        let topImageLabel: UILabel = UILabel()
        topImageLabel.frame = CGRect(x: 0, y: 30, width: 0, height: 0)
        topImageLabel.font = UIFont(name: "Reader", size: 11)
        //topImageLabel.textColor = UIColor.lightGray
        //topImageLabel.text = AppItemTable.getNameByItemId(itemId: itemId + i + 1)
        topImageLabel.text = "Enteromorpha linza"
        topImageLabel.numberOfLines = 0
        topImageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //topImageLabel.textAlignment = NSTextAlignment.right
        topImageLabel.sizeToFit()
        topImageLabel.centerX = leftView.centerX
        //topImageLabel.bottom = mScrollView.bottom - 30
        
        let imageSize: CGFloat = 240
        let imageV: UIImageView = UIImageView()
        let image: UIImage = UIImage(named: "page_02.png")!
        imageV.frame = CGRect(x: 0, y: topImageLabel.bottom + 20, width: imageSize, height: imageSize)
        imageV.image = image
        imageV.contentMode = UIViewContentMode.scaleAspectFit
        imageV.centerX = leftView.centerX
        
        let leftImageLabel: UILabel = UILabel()
        leftImageLabel.frame = topImageLabel.frame
        leftImageLabel.font = topImageLabel.font
        leftImageLabel.text = "Laminaria angustata,Undarin ponnatifula"
        leftImageLabel.numberOfLines = 0
        leftImageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        leftImageLabel.sizeToFit()
        leftImageLabel.right = imageV.left - 5
        leftImageLabel.bottom = imageV.bottom - 40
        
        let rightImageLabel: UILabel = UILabel()
        rightImageLabel.frame = topImageLabel.frame
        rightImageLabel.font = topImageLabel.font
        rightImageLabel.text = "Crytymrnia sparsa, Eucheuma denticum"
        rightImageLabel.numberOfLines = 0
        rightImageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        rightImageLabel.sizeToFit()
        rightImageLabel.left = imageV.right + 5
        rightImageLabel.bottom = leftImageLabel.bottom
        
        let centerLabel: UILabel = UILabel()
        centerLabel.frame = topImageLabel.frame
        centerLabel.font = UIFont(name: "Reader-Medium", size: 15)
        centerLabel.text = "Laminin-511"
        centerLabel.textColor = UIColor(hex: "d62631", alpha: 1)
        centerLabel.numberOfLines = 0
        centerLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        centerLabel.sizeToFit()
        centerLabel.centerX = imageV.centerX
        centerLabel.centerY = imageV.centerY + 10

        let bottomLabel: UILabel = UILabel()
        bottomLabel.frame = CGRect(x: 0, y: imageV.bottom + 10, width: leftView.width - 120, height: 0)
        bottomLabel.font = UIFont(name: "Reader-Medium", size: 16)
        bottomLabel.text = "A complex made up of three types of algae which promote the production of Laminin-511"
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = NSTextAlignment.center
        bottomLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        bottomLabel.sizeToFit()
        bottomLabel.centerX = imageV.centerX

        leftView.addSubview(imageV)
        leftView.addSubview(topImageLabel)
        leftView.addSubview(leftImageLabel)
        leftView.addSubview(rightImageLabel)
        leftView.addSubview(centerLabel)
        leftView.addSubview(bottomLabel)
        
        // レイアウト確認用
//        topImageLabel.textColor = .blue
//        leftImageLabel.textColor = .blue
//        rightImageLabel.textColor = .blue
//        bottomLabel.textColor = .blue
//
//        mCaseOneView.layer.borderWidth = 1
//        imageV.layer.borderWidth = 1
//        leftView.layer.borderWidth = 1
//        rightView.layer.borderWidth = 1
//        topImageLabel.layer.borderWidth = 1
//        leftImageLabel.layer.borderWidth = 1
//        rightImageLabel.layer.borderWidth = 1
//        centerLabel.layer.borderWidth = 1
//        bottomLabel.layer.borderWidth = 1
        
        // rightView
        let rightGraphTitle: UILabel = UILabel()
        rightGraphTitle.font = UIFont(name: "Reader-Bold", size: 16)
        rightGraphTitle.text = "【Promotes the production of Laminin-511】"
        rightGraphTitle.sizeToFit()
        rightGraphTitle.centerX = rightView.width / 2
        rightGraphTitle.top = 30
        
        let rightGraphSub: UILabel = UILabel()
        rightGraphSub.frame = CGRect(x: 0, y: rightGraphTitle.bottom + 5, width: 0, height: 0)
        rightGraphSub.font = UIFont(name: "Reader", size: 12)
        rightGraphSub.text = "(in vitro data)"
        rightGraphSub.sizeToFit()
        rightGraphSub.right = rightGraphTitle.right
        
        let graphV: UIImageView = UIImageView()
        //let graphImage: UIImage = UIImage(named: "page_02.png")!
        graphV.frame = CGRect(x: 0, y: rightGraphTitle.bottom + 20, width: 300, height: 260)
        //graphV.image = graphImage
        graphV.contentMode = UIViewContentMode.scaleAspectFit
        graphV.centerX = rightGraphTitle.centerX + 25
        
        let high: UILabel = UILabel()
        //high.frame = CGRect(x: 0, y: rightGraphTitle.bottom, width: 0, height: 0)
        high.font = UIFont(name: "Reader-Medium", size: 14)
        high.text = "high"
        high.sizeToFit()
        high.top = graphV.top + 10
        high.right = graphV.left
        
        let verticalLabel: UILabel = UILabel()
        verticalLabel.frame = CGRect(x: 0, y: 0, width: 120, height: 0)
        verticalLabel.font = UIFont(name: "Reader", size: 13)
        verticalLabel.text = "Lamini-511 production amount"
        verticalLabel.textAlignment = NSTextAlignment.right
        verticalLabel.numberOfLines = 0
        verticalLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        verticalLabel.sizeToFit()
        verticalLabel.right = graphV.left
        verticalLabel.bottom = graphV.bottom
        
        let firstParamLabel: UILabel = UILabel()
        firstParamLabel.frame = CGRect(x: graphV.left + 60, y: graphV.bottom, width: 0, height: 0)
        firstParamLabel.font = UIFont(name: "Reader", size: 13)
        firstParamLabel.text = "Controll"
        firstParamLabel.sizeToFit()
        
        let nextParamLabel: UILabel = UILabel()
        nextParamLabel.frame = CGRect(x: firstParamLabel.right + 70, y: graphV.bottom, width: 0, height: 0)
        nextParamLabel.font = UIFont(name: "Reader", size: 13)
        nextParamLabel.text = "With complex"
        nextParamLabel.sizeToFit()
        
        rightView.addSubview(rightGraphTitle)
        rightView.addSubview(rightGraphSub)
        rightView.addSubview(graphV)
        rightView.addSubview(high)
        rightView.addSubview(verticalLabel)
        rightView.addSubview(firstParamLabel)
        rightView.addSubview(nextParamLabel)
        
//        rightGraphTitle.textColor = .blue
//        rightGraphSub.textColor = .blue
//        high.textColor = .blue
//        verticalLabel.textColor = .blue
//        firstParamLabel.textColor = .blue
//        nextParamLabel.textColor = .blue
//
//        rightGraphTitle.layer.borderWidth = 1
//        rightGraphSub.layer.borderWidth = 1
//        graphV.layer.borderWidth = 1
//        high.layer.borderWidth = 1
//        verticalLabel.layer.borderWidth = 1
//        firstParamLabel.layer.borderWidth = 1
//        nextParamLabel.layer.borderWidth = 1
        
        mCaseOneView.addSubview(leftView)
        mCaseOneView.addSubview(rightView)
    }
    
    func setCaseTwoView(upperObject: AnyObject) {
        let caseMargin: CGFloat = 40
        let caseViewWidth: CGFloat = mScrollView.width - caseMargin * 2
        let caseViewHeight: CGFloat = mScrollView.height - upperObject.bottom - 20
        
        mCaseTwoView.frame = CGRect(x: caseMargin, y: upperObject.bottom + 10, width: caseViewWidth, height: caseViewHeight)
        
        let leftView: UIView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: caseViewWidth / 3 + 30, height: caseViewHeight)

        let centerView: UIView = UIView()
        centerView.frame = CGRect(x: leftView.right, y: 0, width: (caseViewWidth - leftView.width) / 2, height: caseViewHeight)
        
        let rightView: UIView = UIView()
        rightView.frame = CGRect(x: centerView.right, y: 0, width: (caseViewWidth - leftView.width) / 2, height: caseViewHeight)
        
        //left view
        var lowerSideY: CGFloat = 0
        var rightSideX: CGFloat = 0
        
        for index in 0...3 {
            let imageSize: CGFloat = 140
            let circleImageV: UIImageView = UIImageView()
            circleImageV.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
            let image: UIImage = UIImage(named: "Iris_1_cmyk.png")!
            circleImageV.image = image
            circleImageV.layer.cornerRadius = imageSize / 2
            circleImageV.contentMode = UIViewContentMode.scaleAspectFill
            circleImageV.clipsToBounds = true
            if index % 2 == 0 {
                circleImageV.left = 30
            } else {
                circleImageV.left = rightSideX + 15
            }
            if index <= 1 {
                circleImageV.top = 10
            } else {
                circleImageV.top = lowerSideY + 15
            }
            
            let circleLabel: UILabel = UILabel()
            circleLabel.frame = CGRect(x: 0, y: circleImageV.bottom + 5, width: 0, height: 0)
            circleLabel.font = UIFont(name: "Reader-Medium", size: 12)
            circleLabel.text = "Tormentilla Extract"
            circleLabel.textAlignment = NSTextAlignment.center
            circleLabel.sizeToFit()
            circleLabel.centerX = circleImageV.centerX
            
            if index == 0 {
                lowerSideY = circleLabel.bottom
                rightSideX = circleImageV.right
            }
            leftView.addSubview(circleImageV)
            leftView.addSubview(circleLabel)
            
//            circleImageV.layer.borderWidth = 1
//            circleLabel.layer.borderWidth = 1
        }
        
        // center view
        let borderView: UIView = UIView()
        borderView.frame = CGRect(x: 10, y: 10, width: 1, height: caseViewHeight - 20)
        borderView.layer.borderWidth = 1
        borderView.layer.setBorderUIColor(self.textColor)
        
        for num in 1...4 {
            let numberLabel = UILabel()
            numberLabel.frame = CGRect(x: 30, y: 50 + (num - 1) * 70, width: 0, height: 0)
            numberLabel.font = UIFont(name: "Reader-Bold", size: 50)
            numberLabel.textColor = self.textColor
            
            numberLabel.text = "\(num)."
            numberLabel.sizeToFit()
            //percentY = numberLabel.bottom + 20
            
            let description = UILabel()
            description.frame = CGRect(x: numberLabel.right + 10, y: 0, width: 180, height: 0)
            description.font = UIFont(name: "Reader", size: 15)
            //description.text = AppItemTable.getNameByItemId(itemId: itemId + i + 1)
            description.text = "Suppresses blood vessel- stimulating factor"
            description.numberOfLines = 0
            description.lineBreakMode = NSLineBreakMode.byWordWrapping
            description.sizeToFit()
            description.centerY = numberLabel.centerY - 5
            
            centerView.addSubview(numberLabel)
            centerView.addSubview(description)
            
//            numberLabel.layer.borderWidth = 1
//            description.layer.borderWidth = 1
        }
        centerView.addSubview(borderView)
        
        // right view
        var graphHeight: CGFloat = 0
        for index in 0...1 {
            let graphImageV: UIImageView = UIImageView()
            graphImageV.frame = CGRect(x: 20, y: 10 + graphHeight * CGFloat(index), width: 250, height: caseViewHeight / 2 - 30)
            //let image: UIImage = UIImage(named: "Iris_1_cmyk.png")!
            //graphImageV.image = image
            graphImageV.contentMode = UIViewContentMode.scaleAspectFill
            graphHeight = graphImageV.bottom
            rightView.addSubview(graphImageV)
            
//            graphImageV.layer.borderWidth = 1
        }
        
        mCaseTwoView.addSubview(leftView)
        mCaseTwoView.addSubview(centerView)
        mCaseTwoView.addSubview(rightView)
        
//        mCaseTwoView.layer.borderWidth = 1
//        leftView.layer.borderWidth = 1
//
//        centerView.layer.borderWidth = 1
//        rightView.layer.borderWidth = 1
    }
    
    func setThirdView() {
        let imageV: UIImageView = UIImageView(frame: mScrollView.frame)
        let image: UIImage = UIImage(named: "moisture_tech_\(productId)")!
        
        imageV.contentMode = UIViewContentMode.scaleAspectFit
        imageV.image = image
        mThirdView.addSubview(imageV)
        
        let thirdTitle: UILabel = UILabel()
        thirdTitle.frame = firstTitle.frame
        thirdTitle.text = "After 4 weeks of use:"
        thirdTitle.font = firstTitle.font
        thirdTitle.textAlignment = NSTextAlignment.center
        thirdTitle.sizeToFit()
        thirdTitle.centerX = mScrollView.centerX
        
        var percentY: CGFloat = thirdTitle.bottom + 40
        for index in 0...2 {
            let percentLabel = UILabel()
            percentLabel.frame = CGRect(x: mThirdView.centerX - 250, y: percentY, width: 0, height: 0)
            percentLabel.font = UIFont(name: "Reader-Bold", size: 80)
            percentLabel.textColor = self.textColor
            
            let percentDic: [Int:[String]] = [602:["85%", "80%", "85%"],
                                              614:["89%", "80%", "86%"],
                                              604:["94%", "84%", "87%"],
                                              605:["94%", "84%", "87%"],
                                              606:["90%", "96%", "89%"],
                                              607:["93%", "98%", "86%"],
                                              608:["94%", "88%", "94%"],]
            percentLabel.text = percentDic[self.productId]?[index]
            percentLabel.sizeToFit()
            percentY = percentLabel.bottom + 20
            
            let description = UILabel()
            description.frame = CGRect(x: percentLabel.right + 20, y: 0, width: 400, height: 0)
            description.font = UIFont(name: "Reader", size: 18)
            //description.text = AppItemTable.getNameByItemId(itemId: itemId + i + 1)
            description.text = "of women felt the product made their fine lines less visible."
            description.numberOfLines = 0
            description.lineBreakMode = NSLineBreakMode.byWordWrapping
            description.sizeToFit()
            description.centerY = percentLabel.centerY - 5
            
            mThirdView.addSubview(percentLabel)
            mThirdView.addSubview(description)
        }
        
        let copyLabel: UILabel = UILabel()
        copyLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 0)
        copyLabel.font = UIFont(name: "Reader", size: 11)
        copyLabel.textColor = UIColor.lightGray
        //copyLabel.text = AppItemTable.getNameByItemId(itemId: itemId + i + 1)
        copyLabel.text = "Test Country: France\nTested on 111 woman\nParticipants: Female, 35-49 years old\nTest period: 2 months"
        copyLabel.numberOfLines = 0
        copyLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        copyLabel.textAlignment = NSTextAlignment.right
        copyLabel.sizeToFit()
        copyLabel.right = mScrollView.right - 50
        copyLabel.bottom = mScrollView.bottom - 30
        
        mThirdView.addSubview(thirdTitle)
        mThirdView.addSubview(copyLabel)
    }
}
