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
    
    private func setFirstView() {
        firstTitle.frame = CGRect(x: 0, y: 40, width: 0, height: 0)
        firstTitle.text = AppItemTable.getNameByItemId(itemId: 8080)
        firstTitle.font = UIFont(name: "Reader-Bold", size: 32)
        firstTitle.textAlignment = NSTextAlignment.center
        firstTitle.sizeToFit()
        firstTitle.centerX = mScrollView.centerX
        mFirstView.addSubview(firstTitle)
        
        firstSubText.frame = CGRect(x: 0, y: firstTitle.bottom + 20, width: 800, height: 0)
        firstSubText.text = AppItemTable.getNameByItemId(itemId: 8081)
        firstSubText.font = UIFont(name: "Reader-Medium", size: 19)
        firstSubText.numberOfLines = 0
        firstSubText.lineBreakMode = NSLineBreakMode.byWordWrapping
        firstSubText.sizeToFit()
        firstSubText.centerX = mScrollView.centerX
        mFirstView.addSubview(firstSubText)
        
        let imageNames = ["Ashitaba", "Active", "Natsume"]
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
            let image: UIImage = UIImage(named: imageNames[index + 1])!
            imageV.image = image
            imageV.contentMode = UIViewContentMode.scaleAspectFill
            imageV.centerX = circleSize / 2
            
            let markSize: CGFloat = 45
            let newMark: UIView = UIView()
            newMark.frame = CGRect(x: imageV.left - 15, y: imageV.top - 15, width: markSize, height: markSize)
            newMark.layer.cornerRadius = markSize / 2
            newMark.backgroundColor = UIColor(hex: "d62631", alpha: 1)
            if index == 1 {
                newMark.isHidden = false
            } else {
                newMark.isHidden = true
            }
            newMark.layer.borderWidth = 3
            newMark.layer.setBorderUIColor(UIColor.white)
            
            let markLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            markLabel.text = AppItemTable.getNameByItemId(itemId: 8091)
            markLabel.font = UIFont(name: "Reader-Bold", size: 12)
            markLabel.textColor = UIColor.white
            markLabel.sizeToFit()
            markLabel.center = CGPoint(x: markSize / 2, y: markSize / 2 + 1)
            markLabel.isHidden = false
            newMark.addSubview(markLabel)
            
            let imageTitle: UILabel = UILabel()
            imageTitle.frame = CGRect(x: 0, y: imageV.bottom + 5, width: 0, height: 0)
            imageTitle.text = AppItemTable.getNameByItemId(itemId: 8085 + index * 3)
            imageTitle.font = UIFont(name: "Reader-Bold", size: 13)
            imageTitle.textAlignment = NSTextAlignment.center
            imageTitle.sizeToFit()
            imageTitle.centerX = imageV.centerX
            
            let circleTitle: UILabel = UILabel()
            circleTitle.frame = CGRect(x: 0, y: imageTitle.bottom + 10, width: 0, height: 0)
            circleTitle.text = AppItemTable.getNameByItemId(itemId: 8086 + index * 3)
            circleTitle.font = UIFont(name: "Reader-Bold", size: 19)
            circleTitle.textAlignment = NSTextAlignment.center
            circleTitle.sizeToFit()
            circleTitle.centerX = imageV.centerX
            
            let description: UILabel = UILabel()
            description.frame = CGRect(x: 0, y: circleTitle.bottom + 5, width: imageV.width + 15, height: 0)
            description.text = AppItemTable.getNameByItemId(itemId: 8087 + index * 3)
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
    
    private func setSecondView() {
        var title: String! = String()
        var text: String! = String()
        if isCase == 1 {
            mCaseOneView.isHidden = false
            mCaseTwoView.isHidden = true
            title = AppItemTable.getNameByItemId(itemId: 8092)
            text = AppItemTable.getNameByItemId(itemId: 8093)
        } else if isCase == 2 {
            mCaseOneView.isHidden = true
            mCaseTwoView.isHidden = false
            title = AppItemTable.getNameByItemId(itemId: 8128)
            text = AppItemTable.getNameByItemId(itemId: 8129)
        }
        
        let secondTitle: UILabel = UILabel()
        secondTitle.frame = CGRect(x: 0, y: 30, width: 0, height: 0)
        secondTitle.text = title
        secondTitle.font = firstTitle.font
        secondTitle.textColor = self.textColor
        secondTitle.textAlignment = NSTextAlignment.center
        secondTitle.sizeToFit()
        secondTitle.centerX = mScrollView.centerX
        
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
        
        let commentLabel: UILabel = UILabel()
        commentLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        commentLabel.text = AppItemTable.getNameByItemId(itemId: 8079)
        commentLabel.font = UIFont(name: "Reader", size: 14)
        commentLabel.textColor = self.textColor
        commentLabel.sizeToFit()
        commentLabel.right = secondSubText.right - 5
        commentLabel.bottom = secondSubText.bottom - 5
        
        mSecondView.addSubview(secondTitle)
        mSecondView.addSubview(secondSubText)
        mSecondView.addSubview(commentLabel)
        
        if isCase == 1 {
            setCaseOneView(upperObject: secondSubText)
            commentLabel.isHidden = true
        } else if isCase == 2 {
            setCaseTwoView(upperObject: secondSubText)
        }
        mSecondView.addSubview(mCaseOneView)
        mSecondView.addSubview(mCaseTwoView)
    }
    
    private func setCaseOneView(upperObject: UIView ) {
        let caseMargin: CGFloat = 50
        let caseViewWidth: CGFloat = mScrollView.width - caseMargin * 2
        let caseViewHeight: CGFloat = mScrollView.height - upperObject.bottom - 20
        
        mCaseOneView.frame = CGRect(x: caseMargin, y: upperObject.bottom + 10, width: caseViewWidth, height: caseViewHeight)
        
        let leftView: UIView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: caseViewWidth / 2, height: caseViewHeight)
        
        let rightView: UIView = UIView()
        rightView.frame = CGRect(x: leftView.right, y: 0, width: caseViewWidth / 2, height: caseViewHeight)
        
        // leftView
        let imageLabelFrame: CGRect = CGRect(x: 0, y: 30, width: 120, height: 0)
        let topImageLabel: UILabel = UILabel(frame: imageLabelFrame)
        topImageLabel.font = UIFont(name: "Reader", size: 11)
        topImageLabel.text = AppItemTable.getNameByItemId(itemId: 8094)
        topImageLabel.numberOfLines = 0
        topImageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        topImageLabel.sizeToFit()
        topImageLabel.centerX = leftView.centerX
        
        let triangleV: UIView = UIView()
        triangleV.frame = CGRect(x: 0, y: topImageLabel.bottom + 20, width: 240, height: 220)
        triangleV.centerX = leftView.centerX
        
        let imageSize: CGSize = CGSize(width: 90, height: 90)
        
        let topImageV: UIImageView = UIImageView()
        let tImage: UIImage = UIImage(named: "Enteromorpha_linza")!
        topImageV.size = imageSize
        topImageV.image = tImage
        topImageV.layer.cornerRadius = imageSize.width / 2
        topImageV.contentMode = UIViewContentMode.scaleAspectFill
        topImageV.clipsToBounds = true
        topImageV.centerX = triangleV.width / 2
        
        let leftImageV: UIImageView = UIImageView()
        let lImage: UIImage = UIImage(named: "Laminaria")!
        leftImageV.size = imageSize
        leftImageV.image = lImage
        leftImageV.layer.cornerRadius = imageSize.width / 2
        leftImageV.contentMode = UIViewContentMode.scaleAspectFill
        leftImageV.clipsToBounds = true
        leftImageV.bottom = triangleV.height
        
        let rightImageV: UIImageView = UIImageView()
        let rImage: UIImage = UIImage(named: "Crytymrnia")!
        rightImageV.size = imageSize
        rightImageV.image = rImage
        rightImageV.layer.cornerRadius = imageSize.width / 2
        rightImageV.contentMode = UIViewContentMode.scaleAspectFill
        rightImageV.clipsToBounds = true
        rightImageV.right = triangleV.width
        rightImageV.bottom = triangleV.height
        
        let circleSize: CGFloat = 120
        let circleView: UIView = UIView()
        circleView.frame = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
        circleView.layer.borderWidth = 1
        circleView.layer.cornerRadius = circleSize / 2
        circleView.center = CGPoint(x: triangleV.width / 2, y: triangleV.height / 2 + 20)
        
        let centerLabel: UILabel = UILabel()
        centerLabel.frame = topImageLabel.frame
        centerLabel.font = UIFont(name: "Reader-Medium", size: 15)
        centerLabel.text = AppItemTable.getNameByItemId(itemId: 8095)
        centerLabel.textColor = UIColor(hex: "d62631", alpha: 1)
        centerLabel.numberOfLines = 0
        centerLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        centerLabel.sizeToFit()
        centerLabel.center = circleView.center
        
        let leftImageLabel: UILabel = UILabel(frame: imageLabelFrame)
        leftImageLabel.font = topImageLabel.font
        leftImageLabel.text = AppItemTable.getNameByItemId(itemId: 8096)
        leftImageLabel.numberOfLines = 0
        leftImageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        leftImageLabel.sizeToFit()
        leftImageLabel.right = triangleV.left - 5
        leftImageLabel.centerY = triangleV.bottom - 40
        
        let rightImageLabel: UILabel = UILabel(frame: imageLabelFrame)
        rightImageLabel.font = topImageLabel.font
        rightImageLabel.text = AppItemTable.getNameByItemId(itemId: 8097)
        rightImageLabel.numberOfLines = 0
        rightImageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        rightImageLabel.sizeToFit()
        rightImageLabel.left = triangleV.right + 5
        rightImageLabel.centerY = leftImageLabel.centerY
        
        let bottomLabel: UILabel = UILabel()
        bottomLabel.frame = CGRect(x: 0, y: triangleV.bottom + 20, width: leftView.width - 100, height: 0)
        bottomLabel.font = UIFont(name: "Reader-Medium", size: 16)
        bottomLabel.text = AppItemTable.getNameByItemId(itemId: 8098)
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = NSTextAlignment.center
        bottomLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        bottomLabel.sizeToFit()
        bottomLabel.centerX = triangleV.centerX
        
        triangleV.addSubview(circleView)
        triangleV.addSubview(topImageV)
        triangleV.addSubview(leftImageV)
        triangleV.addSubview(rightImageV)
        triangleV.addSubview(centerLabel)
        
        leftView.addSubview(triangleV)
        leftView.addSubview(topImageLabel)
        leftView.addSubview(leftImageLabel)
        leftView.addSubview(rightImageLabel)
        leftView.addSubview(bottomLabel)
        
        // rightView
        let rightGraphTitle: UILabel = UILabel()
        rightGraphTitle.font = UIFont(name: "Reader-Bold", size: 16)
        rightGraphTitle.text = AppItemTable.getNameByItemId(itemId: 8099)
        rightGraphTitle.sizeToFit()
        rightGraphTitle.centerX = rightView.width / 2
        rightGraphTitle.top = 30
        
        let rightGraphSub: UILabel = UILabel()
        rightGraphSub.frame = CGRect(x: 0, y: rightGraphTitle.bottom + 5, width: 0, height: 0)
        rightGraphSub.font = UIFont(name: "Reader", size: 12)
        rightGraphSub.text = AppItemTable.getNameByItemId(itemId: 8100)
        rightGraphSub.sizeToFit()
        rightGraphSub.right = rightGraphTitle.right
        
        let graphV: UIImageView = UIImageView()
        let graphImage: UIImage = UIImage(named: "laminin_graph")!
        graphV.frame = CGRect(x: 0, y: rightGraphTitle.bottom + 20, width: 300, height: 260)
        graphV.image = graphImage
        graphV.contentMode = UIViewContentMode.scaleAspectFit
        graphV.centerX = rightGraphTitle.centerX + 25
        
        let high: UILabel = UILabel()
        high.font = UIFont(name: "Reader-Medium", size: 14)
        high.text = AppItemTable.getNameByItemId(itemId: 8101)
        high.sizeToFit()
        high.top = graphV.top + 10
        high.right = graphV.left - 5
        
        let verticalLabel: UILabel = UILabel()
        verticalLabel.frame = CGRect(x: 0, y: 0, width: 120, height: 0)
        verticalLabel.font = UIFont(name: "Reader", size: 13)
        verticalLabel.text = AppItemTable.getNameByItemId(itemId: 8102)
        verticalLabel.textAlignment = NSTextAlignment.right
        verticalLabel.numberOfLines = 0
        verticalLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        verticalLabel.sizeToFit()
        verticalLabel.right = graphV.left - 5
        verticalLabel.bottom = graphV.bottom
        
        let firstParamLabel: UILabel = UILabel()
        firstParamLabel.font = UIFont(name: "Reader", size: 13)
        firstParamLabel.text = AppItemTable.getNameByItemId(itemId: 8103)
        firstParamLabel.sizeToFit()
        firstParamLabel.top = graphV.bottom + 5
        firstParamLabel.centerX = graphV.left + 85
        
        let nextParamLabel: UILabel = UILabel()
        nextParamLabel.font = UIFont(name: "Reader", size: 13)
        nextParamLabel.text = AppItemTable.getNameByItemId(itemId: 8104)
        nextParamLabel.sizeToFit()
        nextParamLabel.top = graphV.bottom + 5
        nextParamLabel.centerX = graphV.right - 75
        
        rightView.addSubview(rightGraphTitle)
        rightView.addSubview(rightGraphSub)
        rightView.addSubview(graphV)
        rightView.addSubview(high)
        rightView.addSubview(verticalLabel)
        rightView.addSubview(firstParamLabel)
        rightView.addSubview(nextParamLabel)
        
        mCaseOneView.addSubview(leftView)
        mCaseOneView.addSubview(rightView)
    }
    
    private func setCaseTwoView(upperObject: UIView) {
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
        
        let imageNames = ["Tormenti", "Pyrola_Incarnata", "sakura", "Western_Hawthorn"]
        for index in 0...3 {
            let imageSize: CGFloat = 140
            let circleImageV: UIImageView = UIImageView()
            circleImageV.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
            let image: UIImage = UIImage(named: imageNames[index])!
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
                circleImageV.top = 0
            } else {
                circleImageV.top = lowerSideY + 40
            }
            
            let circleLabel: UILabel = UILabel()
            circleLabel.frame = CGRect(x: 0, y: circleImageV.bottom + 5, width: 140, height: 0)
            circleLabel.font = UIFont(name: "Reader-Medium", size: 11)
            circleLabel.text = AppItemTable.getNameByItemId(itemId: 8130 + index)
            circleLabel.textAlignment = NSTextAlignment.center
            circleLabel.numberOfLines = 0
            circleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleLabel.sizeToFit()
            circleLabel.centerX = circleImageV.centerX
            circleLabel.centerY = circleImageV.bottom + 20
            
            if index == 0 {
                lowerSideY = circleImageV.bottom
                rightSideX = circleImageV.right
            }
            leftView.addSubview(circleImageV)
            leftView.addSubview(circleLabel)
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
            
            let description = UILabel()
            description.frame = CGRect(x: numberLabel.right + 10, y: 0, width: 180, height: 0)
            description.font = UIFont(name: "Reader", size: 15)
            description.text = AppItemTable.getNameByItemId(itemId: 8133 + num)
            description.numberOfLines = 0
            description.lineBreakMode = NSLineBreakMode.byWordWrapping
            description.sizeToFit()
            description.centerY = numberLabel.centerY - 5
            
            centerView.addSubview(numberLabel)
            centerView.addSubview(description)
        }
        centerView.addSubview(borderView)
        
        // right view
        //var graphHeight: CGFloat = 0
        for index in 0...1 {
            let graphImageV: UIImageView = UIImageView()
            graphImageV.frame = CGRect(x: rightView.width - 230, y: rightView.height / 2 * CGFloat(index), width: 230, height: 150)
            let image: UIImage = UIImage(named: "sakura_graph_0\(index + 1)")!
            graphImageV.image = image
            graphImageV.contentMode = UIViewContentMode.scaleAspectFit
            rightView.addSubview(graphImageV)
            
            let high: UILabel = UILabel()
            high.font = UIFont(name: "Reader-Medium", size: 11)
            high.text = AppItemTable.getNameByItemId(itemId: 8101)
            high.sizeToFit()
            high.top = graphImageV.top + 15
            high.right = graphImageV.left + 20
            
            let verticalLabel: UILabel = UILabel()
            verticalLabel.frame = CGRect(x: 0, y: 0, width: 75, height: 0)
            verticalLabel.font = UIFont(name: "Reader", size: 9)
            verticalLabel.text = AppItemTable.getNameByItemId(itemId: 8141 + index)
            verticalLabel.numberOfLines = 0
            verticalLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            verticalLabel.sizeToFit()
            verticalLabel.right = graphImageV.left + 20
            verticalLabel.centerY = graphImageV.centerY + 10
            
            let firstParamLabel: UILabel = UILabel()
            firstParamLabel.font = UIFont(name: "Reader", size: 10)
            firstParamLabel.text = AppItemTable.getNameByItemId(itemId: 8138)
            firstParamLabel.sizeToFit()
            firstParamLabel.centerX = graphImageV.left + 75
            firstParamLabel.top = graphImageV.bottom + 5
            
            let nextParamLabel: UILabel = UILabel()
            nextParamLabel.font = firstParamLabel.font
            nextParamLabel.text = AppItemTable.getNameByItemId(itemId: 8139)
            nextParamLabel.sizeToFit()
            nextParamLabel.centerX = firstParamLabel.centerX + 75
            nextParamLabel.top = firstParamLabel.top
            
            let nextParamComment: UILabel = UILabel()
            nextParamComment.frame = CGRect(x: nextParamLabel.left + 20, y: nextParamLabel.bottom, width: 0, height: 0)
            nextParamComment.font = UIFont(name: "Reader", size: 7)
            nextParamComment.text = AppItemTable.getNameByItemId(itemId: 8140)
            nextParamComment.sizeToFit()
            
            rightView.addSubview(high)
            rightView.addSubview(verticalLabel)
            rightView.addSubview(firstParamLabel)
            rightView.addSubview(nextParamLabel)
            rightView.addSubview(nextParamComment)
        }
        
        mCaseTwoView.addSubview(leftView)
        mCaseTwoView.addSubview(centerView)
        mCaseTwoView.addSubview(rightView)
    }
    
    private func setThirdView() {
        let contryIdsA: [Int] = [21, 4]                  // EU, Middle East
        let contryIdsB: [Int] = [1, 2, 3, 13]            // US,Canada,BZ,Australia
        let contryIdsC: [Int] = [5, 6, 7, 8, 9, 10, 4]   // Asia
        let contryIdsD: [Int] = [1, 3, 2, 17, 13, 21]    // US,Brazil,Canada,India,Australia,Middle East
        //LanguageConfigure.regionId = 1
        //LanguageConfigure.countryId = 21
        
        let thirdTitle: UILabel = UILabel()
        thirdTitle.frame = firstTitle.frame
        thirdTitle.text = AppItemTable.getNameByItemId(itemId: 8105)
        thirdTitle.font = firstTitle.font
        thirdTitle.textAlignment = NSTextAlignment.center
        thirdTitle.sizeToFit()
        thirdTitle.centerX = mScrollView.centerX
        
        var percentY: CGFloat = thirdTitle.bottom + 40
        var percentDic: [Int:[String]] = [602:["85%", "80%", "85%"],
                                          614:["89%", "80%", "86%"],
                                          604:["00", "00", "00"],
                                          605:["84%", "82%", "86%"],
                                          606:["90%", "96%", "89%"],
                                          607:["93%", "98%", "86%"],
                                          608:["00", "00", "00"]]

        var itemIdDic: [Int: Int] = [602: 8111,
                                     614: 8111,
                                     604: 100,
                                     605: 8124,
                                     606: 8143,
                                     607: 8147,
                                     608: 100]
        
        if contryIdsA.contains(LanguageConfigure.countryId) {
            percentDic.updateValue(["94%", "89%", "89%"], forKey: 604)
            itemIdDic.updateValue(8116, forKey: 604)
            print("country pattern is A")
        }
        if contryIdsB.contains(LanguageConfigure.countryId) {
            percentDic.updateValue(["91%", "93%", "92%"], forKey: 604)
            itemIdDic.updateValue(8120, forKey: 604)
            print("country pattern is B")
        }
        if contryIdsC.contains(LanguageConfigure.countryId) {
            percentDic.updateValue(["94%", "88%", "94%"], forKey: 608)
            itemIdDic.updateValue(8151, forKey: 608)
            print("country pattern is C")
        }
        if contryIdsD.contains(LanguageConfigure.countryId) {
            percentDic.updateValue(["100%", "92%", "97%"], forKey: 608)
            itemIdDic.updateValue(8155, forKey: 608)
            print("country pattern is D")
        }
        
        for index in 0...2 {
            let percentLabel = UILabel()
            percentLabel.frame = CGRect(x: mThirdView.centerX - 250, y: percentY, width: 0, height: 0)
            percentLabel.font = UIFont(name: "Reader-Bold", size: 80)
            percentLabel.textColor = self.textColor
            
            percentLabel.text = percentDic[self.productId]?[index]
            percentLabel.sizeToFit()
            percentY = percentLabel.bottom + 20
            
            let description = UILabel()
            description.frame = CGRect(x: percentLabel.right + 20, y: 0, width: 400, height: 0)
            description.font = UIFont(name: "Reader", size: 18)
            description.text = AppItemTable.getNameByItemId(itemId: itemIdDic[self.productId]! + index)
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
        if productId == 614 {
            copyLabel.text = AppItemTable.getNameByItemId(itemId: itemIdDic[self.productId]! + 4)
        } else {
            copyLabel.text = AppItemTable.getNameByItemId(itemId: itemIdDic[self.productId]! + 3)
        }
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
