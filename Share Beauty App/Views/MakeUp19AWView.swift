//
//  MakeUp19AWView.swift
//  Share Beauty App
//
//  Created by 大倉 瑠維 on 2019/05/09.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

class MakeUp19AWView: UIView, UIScrollViewDelegate {

    @IBOutlet weak var mScrollV: UIScrollView!
    
    func setMakeUp19AW(countryId: Int) {
        mScrollV.isPagingEnabled = true
        mScrollV.delegate = self
        let mVContent = UIView()
        mVContent.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        var descriptItemIds: [Int] = []
        var descriptTexts: [String] = []

        // image
        for i in 0..<3 {
            let image = UIImage(named: "makeup_0\(i+1)_19aw.png")!
            let faceImageV = UIImageView(image:image)
            faceImageV.contentMode = .scaleAspectFit
            faceImageV.clipsToBounds = true
            faceImageV.backgroundColor = UIColor.clear
            faceImageV.frame = CGRect(x: 40, y: 20+(Int(self.mScrollV.frame.height))*i, width: 500, height: 500)
            self.mScrollV.addSubview(faceImageV)
        }
        
        //title
        for i in 0..<3 {
            let title = UILabel()
            title.textColor = UIColor.black
            title.font = UIFont(name: "Reader-Bold", size: 18)
            if i == 0 {
                title.text = AppItemTable.getNameByItemId(itemId: 8472) // "ModernMatte Powder Lipstick"
                title.frame = CGRect(x: Int(self.size.width/2 + 40), y: 180+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
            } else if i == 1 {
                title.text = AppItemTable.getNameByItemId(itemId: 8482) // "ModernMatte Powder Lipstick"
                title.frame = CGRect(x: Int(self.size.width/2 + 40), y: 220+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
            } else if i == 2 {
                title.text = AppItemTable.getNameByItemId(itemId: 8490) // "ModernMatte Powder Lipstick"
                title.frame = CGRect(x: Int(self.size.width/2 + 40), y: 120+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
            }
            self.mScrollV.addSubview(title)
        }
        
        //subtitle
        for i in 0..<3 {
            let subTitle = UILabel()
            subTitle.textColor = UIColor.black
            subTitle.font = UIFont(name: "Reader-Bold", size: 24)
            if i == 0 {
                subTitle.text = AppItemTable.getNameByItemId(itemId: 8473) // "502 Whisper"
                subTitle.frame = CGRect(x: Int(self.size.width/2 + 40), y: 210+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
            } else if i == 1 {
                subTitle.text = AppItemTable.getNameByItemId(itemId: 8483) // "509 Flame"
                subTitle.frame = CGRect(x: Int(self.size.width/2 + 40), y: 250+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
            } else if i == 2 {
                subTitle.text = AppItemTable.getNameByItemId(itemId: 8491) // "518 Selfie"
                subTitle.frame = CGRect(x: Int(self.size.width/2 + 40), y: 150+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
            }
            self.mScrollV.addSubview(subTitle)
            
        }
        
        //description
        for i in 0..<3 {
            if i == 0 {
                descriptItemIds = [8474,8475,8476,8477,8478,8479,8480,8481]
                descriptTexts.removeAll()
                for j in 0..<8 {
                    let image = UIImage(named: "one_line.png")!
                    let lineV = UIImageView(image:image)
                    lineV.contentMode = .scaleAspectFit
                    lineV.clipsToBounds = true
                    lineV.backgroundColor = UIColor.clear
                    lineV.frame = CGRect(x: Int(self.size.width/2 + 40)-10, y: Int(self.size.height)/2-50+(30*j), width: 300, height: 20)
                    
                    if let text = AppItemTable.getNameByItemId(itemId: descriptItemIds[j]) {
                        descriptTexts.append(text)
                    } else {
                        descriptTexts.append("")
                    }
                    let descriptLabel: UILabel = UILabel()
                    descriptLabel.numberOfLines = 0
                    descriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                    descriptLabel.text = descriptTexts[j]
                    if j % 2 == 0 {
                        descriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                        descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: Int(self.size.height)/2-30+(30*j), width: 500, height: 20)
                        self.mScrollV.addSubview(lineV)
                    } else {
                        descriptLabel.font = UIFont(name: "Reader-Bold", size: 18)
                        descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: Int(self.size.height)/2-30+(30*(j-1))+20, width: 500, height: 20)
                    }
                    self.mScrollV.addSubview(descriptLabel)
                }
            } else if i == 1 {
                descriptItemIds = [8484,8485,8486,8487,8488,8489]
                descriptTexts.removeAll()
                for j in 0..<6 {
                    let image = UIImage(named: "one_line.png")!
                    let lineV = UIImageView(image:image)
                    lineV.contentMode = .scaleAspectFit
                    lineV.clipsToBounds = true
                    lineV.backgroundColor = UIColor.clear
                    lineV.frame = CGRect(x: Int(self.size.width/2 + 40)-10, y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-10+(30*j), width: 300, height: 20)
                    
                    if let text = AppItemTable.getNameByItemId(itemId: descriptItemIds[j]) {
                        descriptTexts.append(text)
                    } else {
                        descriptTexts.append("")
                    }
                    let descriptLabel: UILabel = UILabel()
                    descriptLabel.numberOfLines = 0
                    descriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                    descriptLabel.text = descriptTexts[j]
                    if j % 2 == 0 {
                        descriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                        descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+10+(30*j), width: 500, height: 20)
                        self.mScrollV.addSubview(lineV)
                    } else {
                        descriptLabel.font = UIFont(name: "Reader-Bold", size: 18)
                        descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+10+(30*(j-1))+20, width: 500, height: 20)
                    }
                    self.mScrollV.addSubview(descriptLabel)
                }
            } else if i == 2 {
                descriptItemIds = [8492,8493,8494,8495,8496,8497,8498,8499,8500,8501]
                descriptTexts.removeAll()
                for j in 0..<10 {
                    let image = UIImage(named: "one_line.png")!
                    let lineV = UIImageView(image:image)
                    lineV.contentMode = .scaleAspectFit
                    lineV.clipsToBounds = true
                    lineV.backgroundColor = UIColor.clear
                    lineV.frame = CGRect(x: Int(self.size.width/2 + 40)-10, y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-110+(30*j), width: 300, height: 20)
                    
                    if let text = AppItemTable.getNameByItemId(itemId: descriptItemIds[j]) {
                        descriptTexts.append(text)
                    } else {
                        descriptTexts.append("")
                    }
                    let descriptLabel: UILabel = UILabel()
                    descriptLabel.numberOfLines = 0
                    descriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                    descriptLabel.text = descriptTexts[j]
                    if j % 2 == 0 {
                        descriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                        descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-90+(30*j), width: 500, height: 20)
                        self.mScrollV.addSubview(lineV)
                    } else {
                        descriptLabel.font = UIFont(name: "Reader-Bold", size: 18)
                        descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-90+(30*(j-1))+20, width: 500, height: 20)
                    }
                    self.mScrollV.addSubview(descriptLabel)
                }
                
            }
        }

        if !([5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26,27].contains(countryId)) {
            self.mScrollV.contentSize = CGSize(width: self.size.width, height: self.size.height*5)
            // image
            for i in 3..<5 {
                let image = UIImage(named: "makeup_0\(i+1)_19aw.png")!
                let faceImageV = UIImageView(image:image)
                faceImageV.contentMode = .scaleAspectFit
                faceImageV.clipsToBounds = true
                faceImageV.backgroundColor = UIColor.clear
                faceImageV.frame = CGRect(x: 40, y: 20+(Int(self.mScrollV.frame.height))*i, width: 500, height: 500)
                self.mScrollV.addSubview(faceImageV)
            }
            
            //title
            for i in 3..<5 {
                let title = UILabel()
                title.textColor = UIColor.black
                title.font = UIFont(name: "Reader-Bold", size: 18)
                if i == 3 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8502) // "ModernMatte Powder Lipstick"
                    title.frame = CGRect(x: Int(self.size.width/2 + 40), y: 220+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                } else if i == 4 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8510) // "ModernMatte Powder Lipstick"
                    title.frame = CGRect(x: Int(self.size.width/2 + 40), y: 180+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                }
                self.mScrollV.addSubview(title)
            }
            
            //subtitle
            for i in 3..<5 {
                let subTitle = UILabel()
                subTitle.textColor = UIColor.black
                subTitle.font = UIFont(name: "Reader-Bold", size: 24)
                if i == 3 {
                    subTitle.text = AppItemTable.getNameByItemId(itemId: 8503) // "Elemental Rose"
                    subTitle.frame = CGRect(x: Int(self.size.width/2 + 40), y: 250+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                } else if i == 4 {
                    subTitle.text = AppItemTable.getNameByItemId(itemId: 8511) // "Lipstick Red Force"
                    subTitle.frame = CGRect(x: Int(self.size.width/2 + 40), y: 210+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                }
                self.mScrollV.addSubview(subTitle)
                
            }
            
            //description
            for i in 3..<5 {
                if i == 3 {
                    descriptItemIds = [8504,8505,8506,8507,8508,8509]
                    descriptTexts.removeAll()
                    for j in 0..<6 {
                        let image = UIImage(named: "one_line.png")!
                        let lineV = UIImageView(image:image)
                        lineV.contentMode = .scaleAspectFit
                        lineV.clipsToBounds = true
                        lineV.backgroundColor = UIColor.clear
                        lineV.frame = CGRect(x: Int(self.size.width/2 + 40)-10, y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-10+(30*j), width: 300, height: 20)
                        
                        if let text = AppItemTable.getNameByItemId(itemId: descriptItemIds[j]) {
                            descriptTexts.append(text)
                        } else {
                            descriptTexts.append("")
                        }
                        let descriptLabel: UILabel = UILabel()
                        descriptLabel.numberOfLines = 0
                        descriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                        descriptLabel.text = descriptTexts[j]
                        if j % 2 == 0 {
                            descriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+10+(30*j), width: 500, height: 20)
                            self.mScrollV.addSubview(lineV)
                        } else {
                            descriptLabel.font = UIFont(name: "Reader-Bold", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+10+(30*(j-1))+20, width: 500, height: 20)
                        }
                        self.mScrollV.addSubview(descriptLabel)
                    }
                } else if i == 4 {
                    descriptItemIds = [8512,8513,8514,8515,8516,8518,8517,8519]
                    descriptTexts.removeAll()
                    for j in 0..<8 {
                        let image = UIImage(named: "one_line.png")!
                        let lineV = UIImageView(image:image)
                        lineV.contentMode = .scaleAspectFit
                        lineV.clipsToBounds = true
                        lineV.backgroundColor = UIColor.clear
                        lineV.frame = CGRect(x: Int(self.size.width/2 + 40)-10, y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-50+(30*j), width: 300, height: 20)
                        
                        if let text = AppItemTable.getNameByItemId(itemId: descriptItemIds[j]) {
                            descriptTexts.append(text)
                        } else {
                            descriptTexts.append("")
                        }
                        let descriptLabel: UILabel = UILabel()
                        descriptLabel.numberOfLines = 0
                        descriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                        descriptLabel.text = descriptTexts[j]
                        if j % 2 == 0 {
                            descriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-30+(30*j), width: 500, height: 20)
                            self.mScrollV.addSubview(lineV)
                        } else {
                            descriptLabel.font = UIFont(name: "Reader-Bold", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-30+(30*(j-1))+20, width: 500, height: 20)
                        }
                        self.mScrollV.addSubview(descriptLabel)
                    }
                }
            }
        } else if countryId == 14 {
            self.mScrollV.contentSize = CGSize(width: self.size.width, height: self.size.height*5)
            // image
            for i in 3..<5 {
                let image = UIImage(named: "makeup_0\(i+3)_19aw.png")!
                let faceImageV = UIImageView(image:image)
                faceImageV.contentMode = .scaleAspectFit
                faceImageV.clipsToBounds = true
                faceImageV.backgroundColor = UIColor.clear
                faceImageV.frame = CGRect(x: 40, y: 20+(Int(self.mScrollV.frame.height))*i, width: 500, height: 500)
                self.mScrollV.addSubview(faceImageV)
            }
            
            //title
            for i in 3..<5 {
                let title = UILabel()
                title.textColor = UIColor.black
                title.font = UIFont(name: "Reader-Bold", size: 18)
                if i == 3 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8521) // "ModernMatte Powder Lipstick"
                    title.frame = CGRect(x: Int(self.size.width/2 + 40), y: 270+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                } else if i == 4 {
                    title.text = AppItemTable.getNameByItemId(itemId: 8526) // "ModernMatte Powder Lipstick"
                    title.frame = CGRect(x: Int(self.size.width/2 + 40), y: 220+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                }
                self.mScrollV.addSubview(title)
            }
            
            //subtitle
            for i in 3..<5 {
                let subTitle = UILabel()
                subTitle.textColor = UIColor.black
                subTitle.font = UIFont(name: "Reader-Bold", size: 24)
                if i == 3 {
                    subTitle.text = AppItemTable.getNameByItemId(itemId: 8520) // "517 Rose Hip"
                    subTitle.frame = CGRect(x: Int(self.size.width/2 + 40), y: 300+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                } else if i == 4 {
                    subTitle.text = AppItemTable.getNameByItemId(itemId: 8527) // "515 Mellow Drama"
                    subTitle.frame = CGRect(x: Int(self.size.width/2 + 40), y: 250+(Int(self.mScrollV.frame.height))*i, width: 700, height: 40)
                }
                self.mScrollV.addSubview(subTitle)
                
            }
            
            //description
            for i in 3..<5 {
                if i == 3 {
                    descriptItemIds = [8522,8523,8524,8525]
                    descriptTexts.removeAll()
                    for j in 0..<4 {
                        let image = UIImage(named: "one_line.png")!
                        let lineV = UIImageView(image:image)
                        lineV.contentMode = .scaleAspectFit
                        lineV.clipsToBounds = true
                        lineV.backgroundColor = UIColor.clear
                        lineV.frame = CGRect(x: Int(self.size.width/2 + 40)-10, y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+50+(30*j), width: 300, height: 20)
                        
                        if let text = AppItemTable.getNameByItemId(itemId: descriptItemIds[j]) {
                            descriptTexts.append(text)
                        } else {
                            descriptTexts.append("")
                        }
                        let descriptLabel: UILabel = UILabel()
                        descriptLabel.numberOfLines = 0
                        descriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                        descriptLabel.text = descriptTexts[j]
                        if j % 2 == 0 {
                            descriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+70+(30*j), width: 500, height: 20)
                            self.mScrollV.addSubview(lineV)
                        } else {
                            descriptLabel.font = UIFont(name: "Reader-Bold", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+70+(30*(j-1))+20, width: 500, height: 20)
                        }
                        self.mScrollV.addSubview(descriptLabel)
                    }
                } else if i == 4 {
                    descriptItemIds = [8528,8529,8530,8531,8532,8533]
                    descriptTexts.removeAll()
                    for j in 0..<6 {
                        let image = UIImage(named: "one_line.png")!
                        let lineV = UIImageView(image:image)
                        lineV.contentMode = .scaleAspectFit
                        lineV.clipsToBounds = true
                        lineV.backgroundColor = UIColor.clear
                        lineV.frame = CGRect(x: Int(self.size.width/2 + 40)-10, y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2-10+(30*j), width: 300, height: 20)
                        
                        if let text = AppItemTable.getNameByItemId(itemId: descriptItemIds[j]) {
                            descriptTexts.append(text)
                        } else {
                            descriptTexts.append("")
                        }
                        let descriptLabel: UILabel = UILabel()
                        descriptLabel.numberOfLines = 0
                        descriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                        descriptLabel.text = descriptTexts[j]
                        if j % 2 == 0 {
                            descriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+10+(30*j), width: 500, height: 20)
                            self.mScrollV.addSubview(lineV)
                        } else {
                            descriptLabel.font = UIFont(name: "Reader-Bold", size: 18)
                            descriptLabel.frame = CGRect(x: Int(self.size.width/2 + 40), y: (Int(self.mScrollV.frame.height))*i+Int(self.size.height)/2+10+(30*(j-1))+20, width: 500, height: 20)
                        }
                        self.mScrollV.addSubview(descriptLabel)
                    }
                }
            }

        } else {
            self.mScrollV.contentSize = CGSize(width: self.size.width, height: self.size.height*3)
        }
    }
}
