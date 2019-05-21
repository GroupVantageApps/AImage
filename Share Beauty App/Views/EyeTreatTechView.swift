//
//  EyeTreatTechView.swift
//  Share Beauty App
//
//  Created by 中川明 on 2019/04/26.
//  Copyright © 2019 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class EyeTreatTechView: UIView, UIScrollViewDelegate {
    
    @IBOutlet weak var mScrollV: UIScrollView!
    
    func setTechnology19AW(){
        mScrollV.isPagingEnabled = true
        mScrollV.delegate = self
        let generateV = UIView()
        generateV.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        //generateV.backgroundColor = UIColor.lightGray
        
        let red = UIColor(red: 185.0/255.0, green: 0.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        var mVCurrentSelect: UIView?
        
        for i in 0...1{
            self.mScrollV.contentSize = CGSize(width: self.size.width, height: self.size.height*2)
            if i == 0{
                let titleLabel = UILabel()
                titleLabel.frame = CGRect(x: 20 , y: 20+(513*i), width: 600, height: 30)
                titleLabel.text = AppItemTable.getNameByItemId(itemId: 8200)// "Smoothing Defense Complex"
                titleLabel.font = UIFont(name: "Reader-Bold", size: 22)
                titleLabel.numberOfLines = 0
                titleLabel.minimumScaleFactor = 0.5
                titleLabel.textColor = UIColor.black
                
                let titleDescription = UILabel()
                titleDescription.frame = CGRect(x: 150, y: 50+(513*i), width: 600, height: 120)

                titleDescription.text = AppItemTable.getNameByItemId(itemId: 8201) // "The SHISEIDO original technology provides a shield-like effect to reduce damage caused by friction.  It also protects the  stratum corneum, and maintains moisture of the eye area"
                titleDescription.font = UIFont(name: "Reader-regular", size: 16)
                titleDescription.numberOfLines = 0
                titleDescription.textAlignment = NSTextAlignment.left
                titleDescription.textColor = UIColor.black
                titleDescription.adjustsFontForContentSizeCategory = true
                titleDescription.minimumScaleFactor = 0.4
                
                let line:UIImage = UIImage(named:"utm_line.png")!
                let utmLine = UIImageView(image:line)
                utmLine.frame = CGRect(x: 135, y: 85+(513*i), width: 1, height: 50)
                utmLine.contentMode = .scaleToFill

                generateV.addSubview(utmLine)
                generateV.addSubview(titleLabel)
                generateV.addSubview(titleDescription)
                
                let title = UILabel()
                title.frame = CGRect(x:  768 - 120, y: 180+(513*i), width: 340, height: 27)
                title.text = AppItemTable.getNameByItemId(itemId: 8203)//"Shiseido-Original"
                title.textAlignment = .left
                title.font = UIFont(name: "Reader-Bold", size: 16)
                title.textAlignment = NSTextAlignment.left
                title.textColor = red
                //title.backgroundColor = red
                DispatchQueue.main.asyncAfter(deadline: .now() + 9.2) {
                    generateV.addSubview(title)
                }
                
                
                
                for i in 1...3{
                    let title = UILabel()
                    let description = UILabel()
                    title.textColor = UIColor.black
                    title.font = UIFont(name: "Reader-Bold", size: 18)
                    title.textAlignment = .left
                    title.frame = CGRect(x: 768 - 120, y: 150+(513*0)+(70*(i-1)), width: 340, height: 100) //width: 400
                    title.numberOfLines = 1
                    title.adjustsFontSizeToFitWidth = true
                    title.minimumScaleFactor = 0.2
                    description.textColor = UIColor.black
                    description.font = UIFont(name: "Reader-regular", size: 12)
                    description.numberOfLines = 0
                    description.sizeToFit()
                    description.textAlignment = .left
                    description.frame = CGRect(x: 768 - 120, y: 185+(513*0)+(70*(i-1)), width: 340, height: 100)
                    description.adjustsFontSizeToFitWidth = true
                    description.minimumScaleFactor = 0.3
                    if i == 1{
                        title.text = AppItemTable.getNameByItemId(itemId: 8204)//"Skin Shield (Smoothing Oil"
                        title.frame = CGRect(x: 768 - 120, y: 165+(513*0)+(70*(i-1)), width: 400, height: 100)
                        title.textColor = red
                        description.text = AppItemTable.getNameByItemId(itemId: 8205) // "Reduces friction from the skin surface."
                        description.frame = CGRect(x: 768 - 120, y: 185+(513*0)+(70*(i-1)), width: 340, height: 100)
                    }else if i == 2{
                        title.text = AppItemTable.getNameByItemId(itemId: 8206) //"Cell Shield (high fructose corn syry"
                        description.text = AppItemTable.getNameByItemId(itemId: 8207)// "Directly bonds with the stratum corneum to protect its moisture and lessen damage"
                        description.frame = CGRect(x: 768 - 120, y: 185+(513*0)+(70*(i-1)), width: 340, height: 100)
                        

                    }else if i == 3{
                        title.text = AppItemTable.getNameByItemId(itemId: 8208) //"Lipid shield (Macadamia nut oil)"
                        description.text = AppItemTable.getNameByItemId(itemId: 8209) // "Blends into intra-cellular lipids to protect the stratum corneum cells for a brighter, moisturized eye area."
                        description.frame = CGRect(x: 768 - 120, y: 195+(513*0)+(70*(i-1)), width: 340, height: 100)
                    }
                    

                    DispatchQueue.main.asyncAfter(deadline: .now() + 9.2) {
                        generateV.addSubview(title)
                        generateV.addSubview(description)
                    }

                }
                
                let path = Bundle.main.path(forResource: "UTM_Edited33", ofType: "mp4")!
                let player = AVPlayer(url: URL(fileURLWithPath: path))
                
                
                // AVPlayer用のLayerを生成
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame =  CGRect(x: 256 - 250, y: (513*i)-300, width: 950, height: 1000)
                generateV.layer.insertSublayer(playerLayer, at: 0)
                player.play()
                
            }else if i == 1{
                let titleLabel = UILabel()
                titleLabel.frame = CGRect(x: 20 , y: 20+(513*i), width: 600, height: 30)
                titleLabel.text = AppItemTable.getNameByItemId(itemId: 8210)// "ImuMoisture Complex"
                titleLabel.font = UIFont(name: "Reader-Bold", size: 22)
                titleLabel.textColor = UIColor.black
                
                let description = UILabel()
                description.frame = CGRect(x: 20 , y: 40+(513*i), width: 600, height: 30)
                description.text = AppItemTable.getNameByItemId(itemId: 8211)// "(Marjoram Extract, Dynamite Glycerin)"
                description.font = UIFont(name: "Reader-regular", size: 16)
                description.textColor = UIColor.black
                
                let titleDescription = UILabel()
                titleDescription.frame = CGRect(x: 150, y: 80+(513*i), width: 630, height: 100)
                //    titleDescription.centerX = self.mVContentLeft.centerX
                titleDescription.text = AppItemTable.getNameByItemId(itemId: 8212) // "It sustains a strong moisturizing effect, helps prevent oxidation of cells which adversely affects Langerhans Cells, and promotes the production of hyaluronic acid.  The result is a radiant and firm eye area."
                titleDescription.font = UIFont(name: "Reader-regular", size: 16)
                titleDescription.numberOfLines = 0
                titleDescription.textAlignment = NSTextAlignment.left
                titleDescription.textColor = UIColor.black
                
                let line:UIImage = UIImage(named:"utm_line.png")!
                let utmLine = UIImageView(image:line)
                utmLine.frame = CGRect(x: 135, y: 100+(513*i), width: 1, height: 60)
                utmLine.contentMode = .scaleToFill
                generateV.addSubview(utmLine)
                
                
                generateV.addSubview(titleLabel)
                generateV.addSubview(description)
                generateV.addSubview(titleDescription)
                
                let graph:UIImage = UIImage(named:"p2_graph.png")!
                let graphImage = UIImageView(image:graph)
                graphImage.frame = CGRect(x: 0, y: 200+(513*i), width: 450, height: 270)
                graphImage.centerX = generateV.centerX
                graphImage.contentMode = .scaleToFill
                generateV.addSubview(graphImage)
                
                
                let arrow:UIImage = UIImage(named:"p2_high_arrow.png")!
                let arrowImage = UIImageView(image:arrow)
                arrowImage.frame = CGRect(x: 250, y: 220+(513*i), width: 25, height: 30)
                arrowImage.contentMode = .scaleToFill
                generateV.addSubview(arrowImage)
                
                let high = UILabel()
                high.frame = CGRect(x: 245 , y: 250+(513*i), width: 40, height: 30)
                high.text = AppItemTable.getNameByItemId(itemId: 8213)// "high"
                high.font = UIFont(name: "Reader-regular", size: 16)
                high.textColor = UIColor.black
                generateV.addSubview(high)
                
                
                let graphDescription = UILabel()
                graphDescription.frame = CGRect(x: 300, y: 220+(513*i), width: 170, height: 50)
                //    titleDescription.centerX = self.mVContentLeft.centerX
                graphDescription.text = AppItemTable.getNameByItemId(itemId: 8214) // "Amount of hyaluronic acid produced"
                graphDescription.font = UIFont(name: "Reader-regular", size: 16)
                graphDescription.numberOfLines = 0
                graphDescription.textAlignment = NSTextAlignment.left
                graphDescription.textColor = UIColor.black
                generateV.addSubview(graphDescription)
                
                let control = UILabel()
                control.frame = CGRect(x: 380, y: 460+(513*i), width: 170, height: 50)
                //    titleDescription.centerX = self.mVContentLeft.centerX
                control.text = AppItemTable.getNameByItemId(itemId: 8215) // "control"
                control.font = UIFont(name: "Reader-regular", size: 16)
                control.numberOfLines = 0
                control.textAlignment = NSTextAlignment.left
                control.textColor = UIColor.black
                generateV.addSubview(control)
                
                let with = UILabel()
                with.frame = CGRect(x: 500, y: 465+(513*i), width: 150, height: 50)
                //    titleDescription.centerX = self.mVContentLeft.centerX
                with.text = AppItemTable.getNameByItemId(itemId: 8216) // "With MarjoramExtract"
                with.font = UIFont(name: "Reader-regular", size: 16)
                with.numberOfLines = 0
                with.textAlignment = NSTextAlignment.center
                with.textColor = UIColor.black
                generateV.addSubview(with)
            }
            
        }
        // TechnologiesのTopをスクロールビューに追加
        mScrollV.addSubview(generateV)
        mVCurrentSelect = mScrollV
    }
}

