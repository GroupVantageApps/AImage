//
//  HowToUse19AW.swift
//  Share Beauty App
//
//  Created by 大倉 瑠維 on 2019/05/09.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

class HowToUse19AW: UIView {

    @IBOutlet weak private var mVContent: UIView!

    func setMakeUpHowToUse19AW(productId: Int) {
        let generateV = UIView()
        generateV.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        var imageDescriptItemIds: [Int] = []
        var imageDescriptTexts: [String] = []
        
        if productId == 625 {
            imageDescriptItemIds = [8409, 8410, 8411]
        } else if productId == 626 {
            imageDescriptItemIds = [8412, 8413, 8414, 8415]
        } else if productId == 627 {
            imageDescriptItemIds = [8420, 8421, 8422]
        } else if productId == 628 {
            imageDescriptItemIds = [8423, 8424, 8425]
        } else if productId == 629 {
            imageDescriptItemIds = [8426, 8427, 8428]
        } else if productId == 630 {
            imageDescriptItemIds = [8429, 8430]
        } else if productId == 631 {
            imageDescriptItemIds = [8431, 8432]
        } else if productId == 632 {
            imageDescriptItemIds = [8433, 8434, 8435, 8436]
        } else {
            print("productId is not correct")
            exit(1)
        }
        
        for i in 0..<imageDescriptItemIds.count {
            if let text = AppItemTable.getNameByItemId(itemId: imageDescriptItemIds[i]) {
                imageDescriptTexts.append(text)
            } else {
                imageDescriptTexts.append("")
            }
            
            if productId != 632 {
                let productid: String = productId.description
                let image = UIImage(named: "\(productid)howto_\(i+1)")
                let faceImageV = UIImageView(image:image)
                faceImageV.contentMode = .scaleAspectFit
                faceImageV.clipsToBounds = true
                faceImageV.backgroundColor = UIColor.clear
                
                let imageDescriptLabel: UILabel = UILabel()
                imageDescriptLabel.numberOfLines = 0
                imageDescriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                imageDescriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                imageDescriptLabel.text = imageDescriptTexts[i]
                imageDescriptLabel.centerX = 318
                
                if productId == 625 {
                    if i == 0 {
                        faceImageV.frame = CGRect(x: 26+(256*i), y: 30, width: 220, height: 220)
                        imageDescriptLabel.frame = CGRect(x: 26+(256*i), y: 280, width: 210, height: 210)
                    } else if i == 1 {
                        faceImageV.frame = CGRect(x: 26+(256*i), y: 30, width: 220, height: 220)
                        imageDescriptLabel.frame = CGRect(x: 26+(256*i), y: 280, width: 210, height: 210)
                    } else if i == 2 {
                        faceImageV.frame = CGRect(x: 26+(256*i), y: 30, width: 440, height: 220)
                        imageDescriptLabel.frame = CGRect(x: 26+(256*i), y: 280, width: 440, height: 210)
                    }
                } else if productId == 626 {
                    faceImageV.frame = CGRect(x: 26+(256*i), y: 30, width: 220, height: 220)
                    imageDescriptLabel.frame = CGRect(x: 26+(256*i), y: 280, width: 210, height: 210)
                } else if productId == 627 {
                    faceImageV.frame = CGRect(x: 26+(340*i), y: 30, width: 320, height: 210)
                    imageDescriptLabel.frame = CGRect(x: 26+(340*i), y: 280, width: 300, height: 210)
                } else if productId == 628 {
                    faceImageV.frame = CGRect(x: 26+(340*i), y: 30, width: 320, height: 210)
                    imageDescriptLabel.frame = CGRect(x: 26+(340*i), y: 280, width: 300, height: 210)
                } else if productId == 629 {
                    faceImageV.frame = CGRect(x: 26+(340*i), y: 30, width: 320, height: 210)
                    imageDescriptLabel.frame = CGRect(x: 26+(340*i), y: 280, width: 300, height: 210)
                } else if productId == 630 {
                    faceImageV.frame = CGRect(x: 100+(400*i), y: 50, width: 380, height: 210)
                    imageDescriptLabel.frame = CGRect(x: 150+(400*i), y: 300, width: 300, height: 210)
                } else if productId == 631 {
                    faceImageV.frame = CGRect(x: 100+(400*i), y: 50, width: 380, height: 210)
                    imageDescriptLabel.frame = CGRect(x: 150+(400*i), y: 300, width: 300, height: 210)
                } else if productId == 632 {
                    if i == 0 {
                        imageDescriptLabel.frame = CGRect(x: 26, y: 26+(50*i), width: 400, height: 50)
                    } else if i == 1 {
                        imageDescriptLabel.frame = CGRect(x: 26, y: 26+(50*i), width: 400, height: 50)
                    } else if i == 2 {
                        faceImageV.frame = CGRect(x: 100+(400*(i-2)), y: 50, width: 380, height: 210)
                        imageDescriptLabel.frame = CGRect(x: 150+(400*i), y: 300, width: 300, height: 210)
                    } else if i == 3 {
                        faceImageV.frame = CGRect(x: 100+(400*(i-2)), y: 50, width: 380, height: 210)
                        imageDescriptLabel.frame = CGRect(x: 150+(400*i), y: 300, width: 300, height: 210)
                    }
                }
                imageDescriptLabel.sizeToFit()
                generateV.addSubview(faceImageV)
                generateV.addSubview(imageDescriptLabel)
            } else if productId == 632 {
                let imageDescriptLabel: UILabel = UILabel()
                imageDescriptLabel.numberOfLines = 0
                imageDescriptLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                imageDescriptLabel.font = UIFont(name: "Reader-regular", size: 18)
                imageDescriptLabel.text = imageDescriptTexts[i]
                imageDescriptLabel.centerX = 318
                
                if i == 0 {
                    imageDescriptLabel.frame = CGRect(x: 40, y: 10+(30*i), width: 760, height: 30)
                } else if i == 1 {
                    imageDescriptLabel.frame = CGRect(x: 40, y: 10+(50*i), width: 600, height: 50)
                } else if i == 2 {
                    let productid: String = productId.description
                    let image = UIImage(named: "\(productid)howto_\((i-2)+1)")
                    let faceImageV = UIImageView(image:image)
                    faceImageV.contentMode = .scaleAspectFit
                    faceImageV.clipsToBounds = true
                    faceImageV.backgroundColor = UIColor.clear
                    
                    faceImageV.frame = CGRect(x: 100+(400*(i-2)), y: 100, width: 380, height: 210)
                    imageDescriptLabel.frame = CGRect(x: 110+(400*(i-2)), y: 350, width: 330, height: 210)
                    
                    generateV.addSubview(faceImageV)
                } else if i == 3 {
                    let productid: String = productId.description
                    let image = UIImage(named: "\(productid)howto_\((i-2)+1)")
                    let faceImageV = UIImageView(image:image)
                    faceImageV.contentMode = .scaleAspectFit
                    faceImageV.clipsToBounds = true
                    faceImageV.backgroundColor = UIColor.clear
                    
                    faceImageV.frame = CGRect(x: 100+(400*(i-2)), y: 100, width: 380, height: 210)
                    imageDescriptLabel.frame = CGRect(x: 110+(400*(i-2)), y: 350, width: 330, height: 210)
                    
                    generateV.addSubview(faceImageV)
                }
                imageDescriptLabel.sizeToFit()
                generateV.addSubview(imageDescriptLabel)
                
            }
        }
        mVContent.addSubview(generateV)
    }

}
