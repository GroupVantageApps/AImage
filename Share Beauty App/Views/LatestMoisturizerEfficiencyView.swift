//
//  LatestMoisturizerTechView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LatestMoisturizerEfficiencyView: UIView {
    
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
                self.setThirdView()
    }
    
        private func setThirdView() {
            let contryIdsA: [Int] = [21, 4]                  // EU, Middle East
            let contryIdsB: [Int] = [1, 2, 3, 13]            // US,Canada,BZ,Australia
            let contryIdsC: [Int] = [5, 6, 7, 8, 9, 10, 4]   // Asia
            let contryIdsD: [Int] = [1, 3, 2, 17, 13, 21]    // US,Brazil,Canada,India,Australia,Middle East
            //LanguageConfigure.regionId = 1
            //LanguageConfigure.countryId = 21
    
            
            let thirdTitle: UILabel = UILabel()
            thirdTitle.frame = CGRect(x: 0, y: 40, width: 0, height: 0)
            thirdTitle.text = AppItemTable.getNameByItemId(itemId: 8105)
            thirdTitle.font = UIFont(name: "Reader-Bold", size: 32)
            thirdTitle.textAlignment = NSTextAlignment.center
            thirdTitle.sizeToFit()
            thirdTitle.centerX = mThirdView.centerX
    
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
            copyLabel.right = mThirdView.right - 50
            copyLabel.bottom = mThirdView.bottom - 30
            
            
    
            mThirdView.addSubview(thirdTitle)
            mThirdView.addSubview(copyLabel)
        }
}
