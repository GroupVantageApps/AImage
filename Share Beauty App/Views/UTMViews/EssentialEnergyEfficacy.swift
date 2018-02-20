//
//  EssentialEnergyEfficacy.swift
//  Share Beauty App
//
//  Created by yushi.kaneshi on 2017/11/28.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import APNGKit

class EssentialEnagyEfficacy: UIView, UIScrollViewDelegate, APNGImageViewDelegate {
    
    var scrollView:UIScrollView = UIScrollView()
    var utm01:UIImageView = UIImageView()
    var utm02:UIImageView = UIImageView()
    var utm03:UIImageView = UIImageView()
    var utmCloseButton:UIButton = UIButton()
    private var aimage00:APNGImageView
    private var aimage01:APNGImageView
    private var aimage02:APNGImageView
    private var aimage03:APNGImageView!
    var isAnimateAimage00 = false
    var isAnimateAimage01 = false
    var isAnimateAimage02 = false
    var isAnimateAimage03 = false
    
    var isEssentialEnergyMoisturizingCream = Bool()
    var isEssentialEnergyMoisturizingGelCream = Bool()
    var isEssentialEnergyDayCX = Bool()
    var isEssentialEnergyDayCream = Bool()
    
    required init(coder aDecoder: NSCoder) {
        aimage00 = APNGImageView(image: FileTable.getAImage(0))
        aimage01 = APNGImageView(image: FileTable.getAImage(0))
        aimage02 = APNGImageView(image: FileTable.getAImage(0))
        aimage03 = APNGImageView(image: FileTable.getAImage(0))
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        aimage00 = APNGImageView(image: FileTable.getAImage(0))
        aimage01 = APNGImageView(image: FileTable.getAImage(0))
        aimage02 = APNGImageView(image: FileTable.getAImage(0))
        aimage03 = APNGImageView(image: FileTable.getAImage(0))
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, size:CGSize) {
        self.init(frame: frame)
    }
    
    func showEfficacyDetail(){
        let boundsWidth = self.bounds.size.width
        let boundsHeight = self.bounds.size.height
        let beforeUseText = AppItemTable.getNameByItemId(itemId: 7953)
        let afterUseText = AppItemTable.getNameByItemId(itemId: 7955)
        let x = CGFloat(80)
        scrollView.frame = CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight)
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
        aimage00 = APNGImageView(image: FileTable.getAImage(0))
        aimage01 = APNGImageView(image: FileTable.getAImage(0))
        aimage02 = APNGImageView(image: FileTable.getAImage(0))
        aimage03 = APNGImageView(image: FileTable.getAImage(0))
        if (isEssentialEnergyMoisturizingCream) {
            showUtmImageByID(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: 513), ID: 6354)
            self.backgroundColor = UIColor.clear
            let backgroundView = UIView(frame: CGRect(x: 50, y: 10, width: boundsWidth - 100, height: scrollView.frame.height - 20))
            backgroundView.backgroundColor = UIColor.white
            scrollView.addSubview(backgroundView)
            let str = AppItemTable.getNameByItemId(itemId: 7951)
            if let labelString = str {
                showUtmLabelText(text: labelString,
                                 frame: CGRect(x: x, y: 29, width: 800, height: 25),
                                 fontSize: 18,
                                 tracking: 0,
                                 lineHeight: 0,
                                 isRed: false, isBold: true)
            }
            //After Left Image   410 × 560 >正寸467 × 558>233 × 279
            showUtmImage(frame: CGRect(x: 80, y: 70, width: 410, height: 330), name: "MoisturizingCream02_after")
            //Before Left Image
            utm01 = UIImageView(frame: CGRect(x: 80, y: 70, width: 410, height: 330))
            let utm01Image = UIImage(named: "MoisturizingCream02_before")
            utm01.image = utm01Image
            utm01.contentMode = UIViewContentMode.scaleAspectFit
            scrollView.addSubview(utm01)
            
            //Right Image
            let utm02After = UIImageView(frame: CGRect(x: 541, y: 70, width: 410, height: 330))
            let utm02AfterImage = UIImage(named: "MoisturizingCream01_after")
            utm02After.image = utm02AfterImage
            utm02After.contentMode = UIViewContentMode.scaleAspectFit
            scrollView.addSubview(utm02After)
            //Before Right Image
            utm02 = UIImageView(frame: CGRect(x: 541, y: 70, width: 410, height: 330))
            let utm02Image = UIImage(named: "MoisturizingCream01_before")
            utm02.image = utm02Image
            utm02.contentMode = UIViewContentMode.scaleAspectFit
            scrollView.addSubview(utm02)
            
            setLabelBlack(frame: CGRect(x: 80, y: 400, width: 120, height: 40), text: beforeUseText, size: 12)
            setLabelBlack(frame: CGRect(x: 426, y: 400, width: 80, height: 40), text: afterUseText, size: 12)
            setLabelBlack(frame: CGRect(x: 541, y: 400, width: 120, height: 40), text: beforeUseText, size: 12)
            setLabelBlack(frame: CGRect(x: 877, y: 400, width: 80, height: 40), text: afterUseText, size: 12)
            var sliderLeft = UISlider(frame: CGRect(x: 80, y: 440, width: 410, height: 45))
            sliderLeft = sliderSetting(slider: sliderLeft, thambImage: UIImage(named: "efficacy_slider_circle_MoisturizingCream"))
            sliderLeft.tag = 1
            sliderLeft.addTarget(self, action: #selector(self.sliderAction(slider:)), for: UIControlEvents.valueChanged)
            scrollView.addSubview(sliderLeft)
            var sliderRight = UISlider(frame: CGRect(x: 537, y: 440, width: 410, height: 45))
            sliderRight = sliderSetting(slider: sliderRight, thambImage: UIImage(named: "efficacy_slider_circle_MoisturizingCream"))
            sliderRight.tag = 2
            sliderRight.addTarget(self, action: #selector(self.sliderAction(slider:)), for: UIControlEvents.valueChanged)
            scrollView.addSubview(sliderRight)
            
            aimage01 = APNGImageView(image: FileTable.getAImage(6364))
            aimage01.frame = CGRect(x: 0, y: 513, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage01)
            aimage02 = APNGImageView(image: FileTable.getAImage(6365))
            aimage02.frame = CGRect(x: 0, y: 513*2, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage02)
            aimage03 = APNGImageView(image: FileTable.getAImage(6366))
            aimage03.frame = CGRect(x: 0, y: 513*3, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage03)
            
            for i in 1...3 {
                setLabel(frame: CGRect(x: 100, y: 513*i+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
                setLabel(frame: CGRect(x: 120, y: 513*i+370, width: 150, height: 30), text: AppItemTable.getNameByItemId(itemId: 7954), size: 15)
                setLabel(frame: CGRect(x: 750, y: 513*i+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
                setLabel(frame: CGRect(x: 750, y: 513*i+370, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7955), size: 15)
                setLabel(frame: CGRect(x: Int(boundsWidth/2 - 135), y: 513*i+230, width: 280, height: 150), text: AppItemTable.getNameByItemId(itemId: 7959), size: 13)
            }
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 180), y: 513+140, width: 350, height: 120), text: AppItemTable.getNameByItemId(itemId: 7956), size: 40)
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 180), y: 513*2+140, width: 350, height: 120), text: AppItemTable.getNameByItemId(itemId: 7957), size: 40)
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 180), y: 513*3+140, width: 350, height: 120), text: AppItemTable.getNameByItemId(itemId: 7958), size: 40)
            
            scrollView.contentSize = CGSize(width: boundsWidth, height: 513*4)
        } else if (isEssentialEnergyDayCX) {
            aimage00 = APNGImageView(image: FileTable.getAImage(6371))
            aimage00.frame = CGRect(x: 0, y: 0, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage00)
            for i in 0...2 {
                setLabel(frame: CGRect(x: 220, y: 513*i+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
                setLabel(frame: CGRect(x: 220, y: 513*i+370, width: 200, height: 30), text: AppItemTable.getNameByItemId(itemId: 7955), size: 15)
                setLabel(frame: CGRect(x: 600, y: 513*i+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
                setLabel(frame: CGRect(x: 600, y: 513*i+370, width: 200, height: 30), text: AppItemTable.getNameByItemId(itemId: 7955), size: 15)
                setLabel(frame: CGRect(x: Int(boundsWidth/2 - 135), y: 513*i+400, width: 280, height: 150), text: AppItemTable.getNameByItemId(itemId: 7966), size: 13)
            }
            setLabel(frame: CGRect(x: 140, y: 35, width: 350, height: 120), text: AppItemTable.getNameByItemId(itemId: 7956), size: 15)
            setLabel(frame: CGRect(x: 530, y: 35, width: 350, height: 120), text: AppItemTable.getNameByItemId(itemId: 7956), size: 15)
            scrollView.contentSize = CGSize(width: boundsWidth, height: 513*3)
        } else if (isEssentialEnergyMoisturizingGelCream) {
            aimage00 = APNGImageView(image: FileTable.getAImage(6367))
            aimage00.frame = CGRect(x: 0, y: 0, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage00)
            aimage01 = APNGImageView(image: FileTable.getAImage(6368))
            aimage01.frame = CGRect(x: 0, y: 513, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage01)
            aimage02 = APNGImageView(image: FileTable.getAImage(6369))
            aimage02.frame = CGRect(x: 0, y: 513*2, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage02)
            for i in 0...2 {
                setLabel(frame: CGRect(x: 120, y: 513*i+320, width: 150, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
                setLabel(frame: CGRect(x: 120, y: 513*i+370, width: 150, height: 30), text: AppItemTable.getNameByItemId(itemId: 7954), size: 15)
                setLabel(frame: CGRect(x: 750, y: 513*i+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
                setLabel(frame: CGRect(x: 750, y: 513*i+370, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7955), size: 15)
                setLabel(frame: CGRect(x: Int(boundsWidth/2 - 135), y: 513*i+270, width: 280, height: 150), text: AppItemTable.getNameByItemId(itemId: 7962), size: 13)//513*i+230
            }
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 180), y: 140, width: 350, height: 160), text: AppItemTable.getNameByItemId(itemId: 7960), size: 40)  //VTあふれ
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 180), y: 513+140, width: 350, height: 120), text: AppItemTable.getNameByItemId(itemId: 7957), size: 40)
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 180), y: 513*2+140, width: 350, height: 120), text: AppItemTable.getNameByItemId(itemId: 7961), size: 40)
            scrollView.contentSize = CGSize(width: boundsWidth, height: 513*3)
        } else if (isEssentialEnergyDayCream) {
            showUtmImageByID(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: 513), ID: 6354)
            scrollView.backgroundColor = UIColor.clear
            self.backgroundColor = UIColor.clear
            let backgroundView = UIView(frame: CGRect(x: 50, y: 10, width: boundsWidth - 100, height: scrollView.frame.height - 20))
            backgroundView.backgroundColor = UIColor.white
            scrollView.addSubview(backgroundView)
            let x = CGFloat(80)
            let str = AppItemTable.getNameByItemId(itemId: 7963)
            if let labelStr = str {
                showUtmLabelText(text: labelStr,
                                 frame: CGRect(x: x, y: 29, width: 800, height: 25),
                                 fontSize: 18,
                                 tracking: 0,
                                 lineHeight: 0, isRed: false, isBold: true)
            }
            showUtmImage(frame: CGRect(x: 80, y: 70, width: 410, height: 330), name: "DayCream02_after")
            
            utm01 = UIImageView(frame: CGRect(x: 80, y: 70, width: 410, height: 330))
            let utm01Image = UIImage(named: "DayCream02_before")
            utm01.image = utm01Image
            utm01.contentMode = UIViewContentMode.scaleAspectFit
            scrollView.addSubview(utm01)
            
            let utm02After = UIImageView(frame: CGRect(x: 541, y: 70, width: 410, height: 330))
            let utm02AfterImage = UIImage(named: "DayCream01_after")
            utm02After.image = utm02AfterImage
            utm02After.contentMode = UIViewContentMode.scaleAspectFit
            scrollView.addSubview(utm02After)
            //Before Right Image
            utm02 = UIImageView(frame: CGRect(x: 541, y: 70, width: 410, height: 330))
            let utm02Image = UIImage(named: "DayCream01_before")
            utm02.image = utm02Image
            utm02.contentMode = UIViewContentMode.scaleAspectFit
            scrollView.addSubview(utm02)
            
            setLabelBlack(frame: CGRect(x: 80, y: 400, width: 120, height: 40), text: beforeUseText, size: 12)
            setLabelBlack(frame: CGRect(x: 426, y: 400, width: 80, height: 40), text: afterUseText, size: 12)
            setLabelBlack(frame: CGRect(x: 541, y: 400, width: 120, height: 40), text: beforeUseText, size: 12)
            setLabelBlack(frame: CGRect(x: 877, y: 400, width: 80, height: 40), text: afterUseText, size: 12)
            var sliderLeft = UISlider(frame: CGRect(x: 80, y: 440, width: 410, height: 45))
            sliderLeft = sliderSetting(slider: sliderLeft, thambImage: UIImage(named: "efficacy_slider_circle_Emulsion"))
            sliderLeft.tag = 1
            sliderLeft.addTarget(self, action: #selector(self.sliderAction(slider:)), for: UIControlEvents.valueChanged)
            scrollView.addSubview(sliderLeft)
            var sliderRight = UISlider(frame: CGRect(x: 537, y: 440, width: 410, height: 45))
            sliderRight = sliderSetting(slider: sliderRight, thambImage: UIImage(named: "efficacy_slider_circle_Emulsion"))
            sliderRight.tag = 2
            sliderRight.addTarget(self, action: #selector(self.sliderAction(slider:)), for: UIControlEvents.valueChanged)
            scrollView.addSubview(sliderRight)
            
            aimage01 = APNGImageView(image: FileTable.getAImage(6370))
            aimage01.frame = CGRect(x: 0, y: 513, width: boundsWidth, height: 513)
            scrollView.addSubview(aimage01)
            
            setLabel(frame: CGRect(x: 75, y: 513+50, width: 210, height: 50), text: AppItemTable.getNameByItemId(itemId: 7956), size: 18)
            setLabel(frame: CGRect(x: 75+335, y: 513+50, width: 210, height: 50), text: AppItemTable.getNameByItemId(itemId: 7956), size: 18)
            setLabel(frame: CGRect(x: 75+670, y: 513+50, width: 210, height: 50), text: AppItemTable.getNameByItemId(itemId: 7956), size: 18)
            
            setLabel(frame: CGRect(x: 90, y: 513+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
            setLabel(frame: CGRect(x: 90, y: 513+370, width: 200, height: 30), text: AppItemTable.getNameByItemId(itemId: 7955), size: 15)
            setLabel(frame: CGRect(x: 420, y: 513+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
            setLabel(frame: CGRect(x: 420, y: 513+370, width: 200, height: 30), text: AppItemTable.getNameByItemId(itemId: 7955), size: 15)
            setLabel(frame: CGRect(x: 740, y: 513+320, width: 200, height: 50), text: AppItemTable.getNameByItemId(itemId: 7952), size: 36)
            setLabel(frame: CGRect(x: 740, y: 513+370, width: 200, height: 30), text: AppItemTable.getNameByItemId(itemId: 7955), size: 15)
            
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 135), y: 513+390, width: 280, height: 150), text: AppItemTable.getNameByItemId(itemId: 7965), size: 13)
            setLabel(frame: CGRect(x: Int(boundsWidth/2 - 135), y: 513*2+390, width: 280, height: 150), text: AppItemTable.getNameByItemId(itemId: 7966), size: 13)
            
            scrollView.contentSize = CGSize(width: boundsWidth, height: 513*2)
        }
        
        aimage00.startAnimating()
        isAnimateAimage00 = true
    }
    func showUtmImage(frame:CGRect, name:String) {
        let imageView = UIImageView(frame: frame)
        let image = UIImage(named: name)
        imageView.image = image
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        scrollView.addSubview(imageView)
    }
    func showUtmImageByID(frame:CGRect, ID:Int) {
        let imageView = UIImageView(frame: frame)
        let image = FileTable.getImage(ID)
        if let loadImage = image {
            imageView.image = loadImage
        }
        imageView.contentMode = UIViewContentMode.scaleToFill
        scrollView.addSubview(imageView)
    }
    func showUtmLabelText(text:String, frame:CGRect, fontSize:CGFloat, tracking:CGFloat, lineHeight:CGFloat, isRed:Bool, isBold:Bool) {
        let attrStr = NSMutableAttributedString(string: text)
        if (isBold) {
            attrStr.setFont(UIUtil.getReaderBold(fontSize))
        }
        if (isRed) {
            attrStr.setTextColor(UIUtil.redColor())
        } else {
            attrStr.setTextColor(UIUtil.grayColor())
        }
        if (tracking > 0) {
            attrStr.setTracking(Float(tracking))
        }
        if (lineHeight > 0) {
            attrStr.setLineHeight(lineHeight)
        }
        let lbl = UILabel(frame: frame)
        lbl.backgroundColor = UIColor.clear
        lbl.attributedText = attrStr
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        scrollView.addSubview(lbl)
    }
    func sliderAction(slider:UISlider) {
        let tag = slider.tag
        switch tag {
        case 1:
            self.utm01.alpha = CGFloat(1 - slider.value)
            break;
        case 2:
            self.utm02.alpha = CGFloat(1 - slider.value)
            break;
        case 3:
            self.utm03.alpha = CGFloat(1 - slider.value)
            break;
        case 4:
            self.utm03.alpha = CGFloat(1 - slider.value)
            break;
        default:
            break;
        }
    }
    func sliderSetting(slider:UISlider, thambImage:UIImage?) -> UISlider {
        slider.setThumbImage(thambImage, for: .normal)
        slider.setMinimumTrackImage(UIImage(named: "efficacy_slider_full"), for: .normal)
        slider.setMaximumTrackImage(UIImage(named: "efficacy_slider_empty"), for: .normal)
        return slider
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        if (!isAnimateAimage01 && contentOffset.y >= 513 && contentOffset.y <= 513*2) {
            aimage01.startAnimating()
            isAnimateAimage01 = true
        }
        if (!isAnimateAimage02 && contentOffset.y >= 513*2 && contentOffset.y <= 513*3) {
            aimage02.startAnimating()
            isAnimateAimage02 = true
        }
        if (!isAnimateAimage03 && contentOffset.y >= 513*3) {
            aimage03.startAnimating()
            isAnimateAimage03 = true
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentOffset = scrollView.contentOffset
        if (!decelerate) {
            if (contentOffset.y <= 513/2) {
                scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 0), animated: true)
            }
            if (contentOffset.y > 513/2 && contentOffset.y <= 513+513/2) {
                scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513), animated: true)
            }
            if (contentOffset.y > 513+513/2 && contentOffset.y <= 513*2+513/2) {
                scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513*2), animated: true)
            }
            if (contentOffset.y > 513*2+513/2) {
                scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513*3), animated: true)
            }
        }
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        if (contentOffset.y <= 513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 0), animated: true)
        }
        if (contentOffset.y > 513/2 && contentOffset.y <= 513+513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513), animated: true)
        }
        if (contentOffset.y > 513+513/2 && contentOffset.y <= 513*2+513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513*2), animated: true)
        }
        if (contentOffset.y > 513*2+513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513*3), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        if (contentOffset.y <= 513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 0), animated: true)
        }
        if (contentOffset.y > 513/2 && contentOffset.y <= 513+513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513), animated: true)
        }
        if (contentOffset.y > 513+513/2 && contentOffset.y <= 513*2+513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513*2), animated: true)
        }
        if (contentOffset.y > 513*2+513/2) {
            scrollView.setContentOffset(CGPoint(x: contentOffset.x, y: 513*3), animated: true)
        }
    }
    func setLabel(frame:CGRect, text:String?, size:Int) {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = UIFont(name:"Reader-Bold" ,size: CGFloat(size))
         //label.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .center
        scrollView.addSubview(label)
    }
    func setLabelBlack(frame:CGRect, text:String?, size:Int) {
        let label = UILabel(frame: frame)
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .left
        scrollView.addSubview(label)
    }
}
