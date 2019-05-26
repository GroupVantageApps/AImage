//
//  EyeTreatEffView.swift
//  Share Beauty App
//
//  Created by 大倉 瑠維 on 2019/04/27.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

class EyeTreatEffView: UIView, UIScrollViewDelegate {
    
    @IBOutlet weak var efficacyScrollV: UIScrollView!
    
    func convertSpecialCharacters(string: String) -> String {
        var newString = string
        let char_dictionary = [
            "&lt;" : "<",
            "&gt;" : ">",
            ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
    @objc private func onTapBeforeAfterBtn(_ sender: UIButton){
        print("tag:*\(sender.tag)")
        if sender.tag < 20{//Before
            
            sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.isEnabled = false
            if let afterBtn = self.viewWithTag(sender.tag + 10) as? UIButton {
                afterBtn.isEnabled = true
                afterBtn.backgroundColor = UIColor.clear
                afterBtn.setTitleColor(UIColor.black, for: .normal)
            }
            if let imageView = self.viewWithTag(sender.tag + 20) as? UIImageView{
                UIView.animate(withDuration: 1.0) {
                    imageView.alpha = 1
                }
            }
        }else{//After
            
            sender.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.isEnabled = false
            if let beforeBtn = self.viewWithTag(sender.tag - 10) as? UIButton {
                beforeBtn.isEnabled = true
                beforeBtn.backgroundColor = UIColor.clear
                beforeBtn.setTitleColor(UIColor.black, for: .normal)
            }
            if let imageView = self.viewWithTag(sender.tag + 10) as? UIImageView{
                UIView.animate(withDuration: 1.0) {
                    imageView.alpha = 0
                }
            }
        }
        
    }
    
    func setEffency19AW(productId:Int){
        efficacyScrollV.isPagingEnabled = true
        efficacyScrollV.delegate = self
        let mVContent = UIView()
        mVContent.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        var mVCurrentSelect: UIView?
        //var productId:Int!
        
        if productId == 618 {
            self.efficacyScrollV.contentSize = CGSize(width: self.size.width, height: self.size.height*2)

            for i in 0...1 {
                let title = UILabel()
                title.textColor = UIColor.black
                title.font = UIFont(name: "Reader-Bold", size: 22)
                if i == 0 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8166) // "Right after"
                } else if i == 1 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8174) // "After 4 weeks"
                }
                title.frame = CGRect(x: 0, y: 0+(Int(self.efficacyScrollV.frame.height)*i), width: 700, height: 40)
                title.centerX = self.centerX
                title.textAlignment = .center
                self.efficacyScrollV.addSubview(title)
            }
            
            for i in 1...7{
                // テキストの場合
                let percentLabel = UILabel()
                percentLabel.textColor = UIColor.black
                percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
                
                if i == 1 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8167)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 100+(100*(i-1)), width: 160, height: 82)
                } else if i == 2 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8169)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 100+(100*(i-1)), width: 160, height: 82)
                } else if i == 3{
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8171)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 100+(100*(i-1)), width: 160, height: 82)
                } else if i == 4{
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8175)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 80+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 160, height: 82)
                } else if i == 5 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8177)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 80+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 160, height: 82)
                } else if i == 6 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8179)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 80+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 160, height: 82)
                } else {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8181)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 80+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 160, height: 82)
                }
                
                percentLabel.textAlignment = .center
                self.efficacyScrollV.addSubview(percentLabel)
            }
            
            for i in 1...7{
                let description = UILabel()
                description.textColor = UIColor.black
                description.font = UIFont(name: "Reader-Medium", size: 22)
                description.numberOfLines = 0
                description.textAlignment = .left
                
                if i == 1 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8168) // "of women felt it was deeply \n hydrating"
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 60+(100*(i-1)), width: 300, height: 150)
                } else if i == 2 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8170) // "of women felt their skin \n absorbed it quickly"
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 60+(100*(i-1)), width: 300, height: 150)
                } else if i == 3 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8172) // "of women felt it maintained their skin's moisture."
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 60+(100*(i-1)), width: 300, height: 150)
                } else if i == 4 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8176) // "of women felt their skin became \n more resilient."
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 40+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 300, height: 150)
                } else if i == 5 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8178) // "of women felt their skin became \n brighter and the clarity improved."
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 40+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 350, height: 150)
                } else if i == 6 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8180) // "of women felt it increased their skin's moisture after application."
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 40+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 350, height: 150)
                } else {
                    description.text = AppItemTable.getNameByItemId(itemId: 8182) // "of women felt their skin became more resistant to troubles like dryness and roughness."
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 40+(Int(self.efficacyScrollV.frame.height))+(100*(i-4)), width: 350, height: 150)
                }
                
                self.efficacyScrollV.addSubview(description)
            }
            
            //右下テキスト
            for i in 0...1{
                let text = UILabel()
                text.textColor = UIColor.lightGray
                text.font = UIFont(name: "Reader-Medium", size: 12)
                text.font = text.font.withSize(13)
                text.textAlignment = .right
                text.numberOfLines = 0
                if i == 0 {
                    text.text = AppItemTable.getNameByItemId(itemId: 8173)
                    text.frame = CGRect(x: 800, y: 450+(Int(self.efficacyScrollV.frame.height)*i), width: 200, height: 40)
                } else if i == 1 {
                    let decode = convertSpecialCharacters(string: AppItemTable.getNameByItemId(itemId: 8183)!)
                    text.text = decode
                    text.frame = CGRect(x: 700, y: 450+(Int(self.efficacyScrollV.frame.height)*i), width: 300, height: 60)
                }
                
                self.efficacyScrollV.addSubview(text)
            }
            
        } else if productId == 617 {
            self.efficacyScrollV.contentSize = CGSize(width: self.size.width, height: self.size.height*2)

            for i in 1...2{
                // テキスト
                let percentLabel = UILabel()
                percentLabel.textColor = UIColor.black
                percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
                
                if i == 1 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8193)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 80+(Int(self.efficacyScrollV.frame.height))+(30*i), width: 160, height: 82)
                } else if i == 2 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8197)
                    percentLabel.frame = CGRect(x: Int(self.centerX) - 230, y: 80+(Int(self.efficacyScrollV.frame.height))+250, width: 160, height: 82)
                }
                percentLabel.textAlignment = .center
                
                self.efficacyScrollV.addSubview(percentLabel)
            }
            for i in 1...2{
                let description = UILabel()
                description.textColor = UIColor.black
                description.font = UIFont(name: "Reader-Medium", size: 22)
                description.numberOfLines = 0
                description.textAlignment = .left
                
                if i == 1 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8194) // "of women felt it created \n a rich lather that lasted on their skin"
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 70+(Int(self.efficacyScrollV.frame.height)), width: 250, height: 150)
                } else if i == 2 {
                    description.text = AppItemTable.getNameByItemId(itemId: 8198) // "of women felt it \n softed their skin"
                    description.frame = CGRect(x: Int(self.centerX) - 50, y: 290+(Int(self.efficacyScrollV.frame.height)), width: 200, height: 150)
                }
                
                self.efficacyScrollV.addSubview(description)
            }
            
            //右下テキスト
            for i in 0...1{
                let text = UILabel()
                text.textColor = UIColor.lightGray
                text.font = UIFont(name: "Reader-Medium", size: 12)
                text.font = text.font.withSize(13)
                text.textAlignment = .right
                text.numberOfLines = 0
                text.frame = CGRect(x: 800, y: 450+(Int(self.efficacyScrollV.frame.height)*i), width: 200, height: 40)
                if i == 0 {
                    text.text = AppItemTable.getNameByItemId(itemId: 8191)
                } else if i == 1 {
                    text.text = AppItemTable.getNameByItemId(itemId: 8199)
                }
                
                self.efficacyScrollV.addSubview(text)
            }
            
            let generateV = UIView()
            
            for i in 1...2{
                var image:UIImage = UIImage(named:"graph_04.png")!
                if i == 1 {
                    image = UIImage(named:"graph19AW.png")!
                }
                let graphV = UIImageView(image:image)
                graphV.contentMode = .scaleToFill
                if i == 1{
                    graphV.frame = CGRect(x: 350, y: 100, width: 350, height: 300)//graph
                }else if i == 2{
                    graphV.frame = CGRect(x: 310, y: 100, width: 20, height: 26)//better
                }
                
                generateV.addSubview(graphV)
            }
            
            //graphText
            for i in 1...3{
                let graphLabel = UILabel()
                graphLabel.textColor = UIColor.black
                graphLabel.numberOfLines = 0
                graphLabel.textAlignment = NSTextAlignment.left
                graphLabel.font = UIFont(name: "Reader-Medium", size: 12)
                
                
                if i == 1{
                    graphLabel.frame = CGRect(x: 297, y:130, width: 60, height: 20)
                    graphLabel.text = AppItemTable.getNameByItemId(itemId: 8185) // "better"
                    graphLabel.font = graphLabel.font.withSize(16)
                    
                }else if i == 2{
                    graphLabel.frame = CGRect(x: 420 , y:405, width: 170, height: 80)
                    graphLabel.text = AppItemTable.getNameByItemId(itemId: 8188) // "Before"
                    graphLabel.font = graphLabel.font.withSize(14)
                    graphLabel.sizeToFit()
                    graphLabel.textAlignment = NSTextAlignment.center
                    
                }else if i == 3{
                    graphLabel.frame = CGRect(x: 598 , y:405, width: 170, height: 80)
                    graphLabel.text = AppItemTable.getNameByItemId(itemId: 8189) // "7days"
                    graphLabel.font = graphLabel.font.withSize(14)
                    graphLabel.sizeToFit()
                    graphLabel.textAlignment = NSTextAlignment.center
                }
                
                generateV.addSubview(graphLabel)
            }
            self.efficacyScrollV.addSubview(generateV)
            
            for i in 0...3 {
                // タイトル
                let title = UILabel()
                title.textColor = UIColor.black
                title.font = UIFont(name: "Reader-Bold", size: 22)
                let red = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
                
                if i == 0 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8190) // "Moisturizing effect: \n Improvement in skin's moisture in 1 week"
                    title.frame = CGRect(x: 0, y: 0+(Int(self.efficacyScrollV.frame.height)*i), width: 950, height: 50)
                    title.numberOfLines = 2
                    title.textAlignment = .left
                } else if i == 1 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8186) // "Moisturizing effect"
                    title.frame = CGRect(x: 0, y: 90, width: 700, height: 40)
                    title.textColor = red
                    title.textAlignment = .center
                } else if i == 2 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8192) // "Immidiately after"
                    title.frame = CGRect(x: 0, y: 0+(Int(self.efficacyScrollV.frame.height)), width: 700, height: 40)
                    title.textAlignment = .center
                } else if i == 3 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8196) // "1 week"
                    title.frame = CGRect(x: 0, y: 0+(Int(self.efficacyScrollV.frame.height)+250), width: 700, height: 40)
                    title.textAlignment = .center
                }
                title.centerX = self.centerX
                self.efficacyScrollV.addSubview(title)
            }
        }else if productId == 616{
            self.efficacyScrollV.contentSize = CGSize(width: self.size.width, height: self.size.height*3)

            let title = UILabel()
            title.textColor = UIColor.black
            title.font = UIFont(name: "Reader-Bold", size: 22)
            title.numberOfLines = 3 //t-hirai
            title.frame = CGRect(x: 0, y: 0+(Int(self.efficacyScrollV.frame.height)*0), width: 800, height: 80)//t-hirai
            title.centerX = self.centerX
            title.textAlignment = .center
            title.text = AppItemTable.getNameByItemId(itemId: 8237)
            
            let image_after = UIImage(named: "after_face")
            let faceImageV_after = UIImageView(image:image_after)
            faceImageV_after.contentMode = .scaleAspectFit
            faceImageV_after.clipsToBounds = true
            faceImageV_after.frame = CGRect(x: 0, y: 70+(Int(self.efficacyScrollV.frame.height)*0), width: 300, height: 300)
            faceImageV_after.centerX = self.centerX
            faceImageV_after.backgroundColor = UIColor.clear
            
            let image = UIImage(named: "before_face")
            let faceImageV = UIImageView(image:image)
            faceImageV.contentMode = .scaleAspectFit
            faceImageV.tag = 30 //300
            faceImageV.clipsToBounds = true
            faceImageV.frame = CGRect(x: 0, y: 70+(Int(self.efficacyScrollV.frame.height)*0), width: 300, height: 300)
            faceImageV.centerX = self.centerX
            faceImageV.backgroundColor = UIColor.clear
            
            let beforeBtn = UIButton()
            beforeBtn.isEnabled = false
            beforeBtn.frame = CGRect(x: 0, y: 400+(Int(self.efficacyScrollV.frame.height)*0), width: 145, height: 30)
            beforeBtn.origin.x = self.centerX - beforeBtn.frame.width - 10
            beforeBtn.setTitle(AppItemTable.getNameByItemId(itemId: 8238), for: .normal) // "Before"
            beforeBtn.isEnabled = false
            beforeBtn.setTitleColor(UIColor.white, for: .normal)
            beforeBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            beforeBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 12)
            beforeBtn.tag = 10//100
            beforeBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            let afterBtn = UIButton()
            afterBtn.isEnabled = true
            afterBtn.frame = CGRect(x: 0, y: 400+(Int(self.efficacyScrollV.frame.height)*0), width: 145, height: 30)
            afterBtn.origin.x = self.centerX + 10
            afterBtn.setTitle(AppItemTable.getNameByItemId(itemId: 8239), for: .normal) // "After 4 Weeks"
            afterBtn.isEnabled = true
            afterBtn.setTitleColor(UIColor.white, for: .normal)
            afterBtn.backgroundColor = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
            
            afterBtn.setTitleColor(UIColor.black, for: .normal)
            afterBtn.backgroundColor = UIColor.white
            afterBtn.titleLabel?.font = UIFont(name: "Reader-Medium", size: 12)
            afterBtn.tag = 20 //200
            afterBtn.addTarget(self, action: #selector(self.onTapBeforeAfterBtn(_:)), for: .touchUpInside)
            
            
            for j in 0...2{
                let image:UIImage = UIImage(named:"point_01.png")!
                let border = UIImageView(image:image)
                border.contentMode = .scaleToFill
                
                if j == 0{
                    border.frame = CGRect(x: Int(self.centerX) - Int(beforeBtn.frame.width) - 20, y: 398+(Int(self.efficacyScrollV.frame.height)*0), width: 1, height: 34)
                }else if j == 1{
                    border.frame = CGRect(x: Int(self.centerX), y: 398+(Int(self.efficacyScrollV.frame.height)*0), width: 1, height: 34)
                    
                }else if j == 2{
                    border.frame = CGRect(x: Int(self.centerX) + Int(afterBtn.frame.width) + 20, y: 398+(Int(self.efficacyScrollV.frame.height)*0), width: 1, height: 34)
                    
                }
                self.efficacyScrollV.addSubview(border)
                
            }
            
            self.efficacyScrollV.addSubview(title)
            self.efficacyScrollV.addSubview(faceImageV_after)
            self.efficacyScrollV.addSubview(faceImageV)
            self.efficacyScrollV.addSubview(beforeBtn)
            self.efficacyScrollV.addSubview(afterBtn)
            
            //左側
            let title2 = UILabel()
            title2.textColor = UIColor.black
            title2.font = UIFont(name: "Reader-Bold", size: 22)
            title2.text = AppItemTable.getNameByItemId(itemId: 8240) // "Immediately"
            title2.frame = CGRect(x: 0, y: 10+(Int(self.efficacyScrollV.frame.height)*1), width: 700, height: 40)
            title2.centerX = self.centerX/2
            title2.textAlignment = .center
            self.efficacyScrollV.addSubview(title2)
            
            for i in 1...3{
                // 画像の場合
                // let image:UIImage = UIImage(named:"percent_0\(i).png")!
                // let percentImageV = UIImageView(image:image)
                // percentImageV.contentMode = .scaleToFill
                // percentImageV.frame = CGRect(x: Int(self.centerX) - 230, y: 110 + Int(self.efficacyScrollV.frame.height)*3+(130*(i-1)), width: 150, height: 59)
                
                // self.efficacyScrollV.addSubview(percentImageV)
                
                // テキストの場合
                let percentLabel = UILabel()
                percentLabel.textColor = UIColor.black
                percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
                if i == 1 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8241)
                } else if i == 2 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8243)
                } else {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8245)
                }
                //Int(selfLeft.centerX) は　250？　置き換え予定
                percentLabel.frame = CGRect(x: 256 - 200, y: 110 + Int(self.efficacyScrollV.frame.height)*1+(130*(i-1)), width: 160, height: 82)
                percentLabel.textAlignment = .center
                self.efficacyScrollV.addSubview(percentLabel)
            }
            
            for i in 1...3{
                let description = UILabel()
                description.textColor = UIColor.black
                description.font = UIFont(name: "Reader-Medium", size: 20)
                description.numberOfLines = 0
                description.textAlignment = .left
                description.frame = CGRect(x: 256 - 20, y: 70 + Int(self.efficacyScrollV.frame.height)*1+(130*(i-1)), width: 235, height: 150)
                
                
                if i == 1{
                    description.text = AppItemTable.getNameByItemId(itemId: 8242) // "of women felt it moisturized the skin around the eyes."
                }else if i == 2{
                    description.text = AppItemTable.getNameByItemId(itemId: 8244)// "of women felt it made the skin around the eyes smoother"
                }else if i == 3{
                    description.text = AppItemTable.getNameByItemId(itemId: 8246) // "of women felt it was quick-absorbing."
                }
                self.efficacyScrollV.addSubview(description)
            }
            
            
            //右側
            let title3 = UILabel()
            title3.textColor = UIColor.black
            title3.font = UIFont(name: "Reader-Bold", size: 22)
            title3.text = AppItemTable.getNameByItemId(itemId: 8247) // "Next Morning"
            title3.frame = CGRect(x: 0, y: 10+(Int(self.efficacyScrollV.frame.height)*1), width: 700, height: 40)
            title3.centerX = 768
            title3.textAlignment = .center
            self.efficacyScrollV.addSubview(title3)
            
            for i in 1...3{
                // 画像の場合
                // let image:UIImage = UIImage(named:"percent_0\(i).png")!
                // let percentImageV = UIImageView(image:image)
                // percentImageV.contentMode = .scaleToFill
                // percentImageV.frame = CGRect(x: Int(self.centerX) - 230, y: 110 + Int(self.efficacyScrollV.frame.height)*3+(130*(i-1)), width: 150, height: 59)
                
                // self.efficacyScrollV.addSubview(percentImageV)
                
                // テキストの場合
                let percentLabel = UILabel()
                percentLabel.textColor = UIColor.black
                percentLabel.font = UIFont(name: "Reader-Bold", size: 82 )
                if i == 1 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8248)
                } else if i == 2 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8250)
                } else {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8252)
                }
                percentLabel.frame = CGRect(x: 768 - 200, y: 110 + Int(self.efficacyScrollV.frame.height)*1+(130*(i-1)), width: 160, height: 82)
                percentLabel.textAlignment = .center
                self.efficacyScrollV.addSubview(percentLabel)
            }
            
            for i in 1...3{
                let description = UILabel()
                description.textColor = UIColor.black
                description.font = UIFont(name: "Reader-Medium", size: 20)
                description.numberOfLines = 0
                description.textAlignment = .left
                description.frame = CGRect(x: 768 - 20, y: 70 + Int(self.efficacyScrollV.frame.height)*1+(130*(i-1)), width: 235, height: 150)
                
                
                if i == 1{
                    description.text = AppItemTable.getNameByItemId(itemId: 8249) // "of women felt it prevented eye area concernsfrom within."
                }else if i == 2{
                    description.text = AppItemTable.getNameByItemId(itemId: 8251)// "of women felt it made the skin around the eyes smoother"
                }else if i == 3{
                    description.text = AppItemTable.getNameByItemId(itemId: 8253) // "of women felt it was quick-absorbing."
                }
                self.efficacyScrollV.addSubview(description)
            }
            //三枚目
            
            
            let graph : UIImage = UIImage(named: "p6_graph.png")!
            let graphImage = UIImageView(image: graph)
            graphImage.contentMode = .scaleToFill
            graphImage.frame = CGRect(x: 170,y: 17+Int(self.efficacyScrollV.frame.height)*2,width: 318,height: 450)
            self.efficacyScrollV.addSubview(graphImage)
            
            
            let red : UIImage = UIImage(named: "p6_3months.png")!
            let redImage = UIImageView(image: red)
            redImage.contentMode = .scaleToFill
            redImage.frame = CGRect(x: 350,y: 470+Int(self.efficacyScrollV.frame.height)*2,width: 40,height: 20)
            self.efficacyScrollV.addSubview(redImage)
            
            let gray : UIImage = UIImage(named: "p6_1week.png")!
            let grayImage = UIImageView(image: gray)
            grayImage.contentMode = .scaleToFill
            grayImage.frame = CGRect(x: 170,y: 470+Int(self.efficacyScrollV.frame.height)*2,width: 40,height: 20)
            self.efficacyScrollV.addSubview(grayImage)
            
            let reddescription = UILabel()
            reddescription.textColor = UIColor.black
            reddescription.font = UIFont(name: "Reader-Medium", size: 17)
            reddescription.numberOfLines = 0
            reddescription.textAlignment = .left
            reddescription.text = AppItemTable.getNameByItemId(itemId: 8275)
            reddescription.frame = CGRect(x: 400,y: 470+Int(self.efficacyScrollV.frame.height)*2,width: 150,height: 20)
            self.efficacyScrollV.addSubview(reddescription)
        
            let graydescription = UILabel()
            graydescription.textColor = UIColor.black
            graydescription.font = UIFont(name: "Reader-Medium", size: 17)
            graydescription.numberOfLines = 0
            graydescription.textAlignment = .left
            graydescription.text = AppItemTable.getNameByItemId(itemId: 8274)
            graydescription.frame = CGRect(x: 220,y: 470+Int(self.efficacyScrollV.frame.height)*2,width: 150,height: 20)
            self.efficacyScrollV.addSubview(graydescription)
            
            for i in 1...6{
                
                let percentLabel = UILabel()
                let red = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
                percentLabel.textColor = UIColor.gray
                percentLabel.font = UIFont(name: "Reader-Bold", size: 20 )
                
                let percentLabel2 = UILabel()
                percentLabel2.textColor = red
                percentLabel2.font = UIFont(name: "Reader-Bold", size: 30 )
                
                let description = UILabel()
                description.textColor = UIColor.black
                description.font = UIFont(name: "Reader-Medium", size: 17)
                description.numberOfLines = 0
                description.textAlignment = .left
                
                
                if i == 1 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8255)
                    percentLabel2.text = AppItemTable.getNameByItemId(itemId: 8256)
                    description.text = AppItemTable.getNameByItemId(itemId: 8272)
                } else if i == 2 {
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8258)
                    percentLabel2.text = AppItemTable.getNameByItemId(itemId: 8255)
                    description.text = AppItemTable.getNameByItemId(itemId: 8269)
                } else if i == 3{
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8261)
                    percentLabel2.text = AppItemTable.getNameByItemId(itemId: 8262)
                    description.text = AppItemTable.getNameByItemId(itemId: 8266)
                } else if i == 4{
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8264)
                    percentLabel2.text = AppItemTable.getNameByItemId(itemId: 8265)
                    description.text = AppItemTable.getNameByItemId(itemId: 8263)
                } else if i == 5{
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8267)
                    percentLabel2.text = AppItemTable.getNameByItemId(itemId: 8256)
                    description.text = AppItemTable.getNameByItemId(itemId: 8260)
                } else if i == 6{
                    percentLabel.text = AppItemTable.getNameByItemId(itemId: 8270)
                    percentLabel2.text = AppItemTable.getNameByItemId(itemId: 8256)
                    description.text = AppItemTable.getNameByItemId(itemId: 8257)
                }
                percentLabel.frame = CGRect(x: 256 - 200, y: 20 + Int(self.efficacyScrollV.frame.height)*2+(75*(i-1)), width: 160, height: 42)
                percentLabel.textAlignment = .center
                self.efficacyScrollV.addSubview(percentLabel)
                
                percentLabel2.frame = CGRect(x: 256 - 205, y: 50 + Int(self.efficacyScrollV.frame.height)*2+(75*(i-1)), width: 160, height: 42)
                percentLabel2.textAlignment = .center
                self.efficacyScrollV.addSubview(percentLabel2)
                
                description.frame = CGRect(x: 768 - 256, y: 30 + Int(self.efficacyScrollV.frame.height)*2+(75*(i-1)), width: 500, height: 42)
                self.efficacyScrollV.addSubview(description)
            }
            
            //右下テキスト
            for i in 1...3{
                let text = UILabel()
                text.textColor = UIColor.lightGray
                text.font = UIFont(name: "Reader-Medium", size: 12)
                text.font = text.font.withSize(13)
                text.textAlignment = .right
                text.numberOfLines = 0
                text.frame = CGRect(x: 800, y: 450+(Int(self.efficacyScrollV.frame.height)*(i - 1)), width: 200, height: 40)
                
                if i == 2 || i == 3{
                    text.frame = CGRect(x: 500, y: 450+(Int(self.efficacyScrollV.frame.height)*(i - 1)), width: 500, height: 50)
                    text.text = AppItemTable.getNameByItemId(itemId: 8273) // "*39-year-old"
                    
                }

                self.efficacyScrollV.addSubview(text)
            }
        }
    }
}
