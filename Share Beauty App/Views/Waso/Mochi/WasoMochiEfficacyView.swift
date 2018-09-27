//
//  WasoMochiEfficacyView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoMochiEfficacyView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var mViewPageOne: UIView!
    @IBOutlet weak var mViewPageTwo: UIView!
    
    @IBOutlet weak var mPageOneContentV: UIView!
    @IBOutlet weak var mPageOneCopyLabel: UILabel!
    
    @IBOutlet weak var mPageTwoContentV: UIView!
    @IBOutlet weak var mPageTwoTitle: UILabel!
    @IBOutlet weak var mPageTwoSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
//        mViewPageTwo.frame = CGRect(x: 0, y: mScrollView.height, width: mScrollView.width, height: mScrollView.height)

        self.setPageOne()
        self.setPageTwo()
    }
    
    func setPageOne() {
        //mPageOneCopyLabel.text = AppItemTable.getNameByItemId(itemId: 0000)
        for index in 0...2 {
            let circleImageV: UIImageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 180, height: 180))
            
            if index == 1 {
                circleImageV.centerX = mPageOneContentV.width / 2
            } else if index == 2 {
                circleImageV.origin.x = mPageOneContentV.width - circleImageV.width - 15
            }
            
            let image: UIImage = UIImage(named: "waso_87.png")!
            circleImageV.image = image
            circleImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let circleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: circleImageV.bottom + 15, width: circleImageV.width + 30, height: 0))
            circleLabel.text = "My skin became silky-smooth\(index)."
            circleLabel.font = UIFont(name: "Reader-Medium", size: 17)
            circleLabel.textAlignment = .center
            circleLabel.numberOfLines = 0
            circleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleLabel.sizeToFit()
            circleLabel.centerX = circleImageV.centerX
            
            mPageOneContentV.addSubview(circleImageV)
            mPageOneContentV.addSubview(circleLabel)
        }
    }
    
    func setPageTwo() {
        //mPageTwoTitle.text = AppItemTable.getNameByItemId(itemId: 0000)
        //mPageTwoSubTitle.text = AppItemTable.getNameByItemId(itemId: 0000)
        
        let graphImageV: UIImageView = UIImageView(frame: CGRect(x: 50, y: 10, width: mPageTwoContentV.width - 100, height: mPageTwoContentV.height - 60))
        graphImageV.backgroundColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.5)
        
        //let image: UIImage = UIImage(named: "waso_87.png")!
        //graphImageV.image = image
        graphImageV.contentMode = UIViewContentMode.scaleAspectFit
        mPageTwoContentV.addSubview(graphImageV)
        
        for index in 0...1 {
            let markView: UIView = UIView(frame: CGRect(x: 80, y: 20 * index + 15, width: 10, height: 10))
            markView.backgroundColor = index == 0 ? UIColor.gray : UIColor(hex: "AC223E", alpha: 1)
            
            let graphLabel: UILabel = UILabel(frame: CGRect(x: markView.right + 10, y: markView.top - 3, width: 0, height: 0))
            graphLabel.text = "Moisturizer\(index)."
            graphLabel.font = UIFont(name: "Reader", size: 15)
            graphLabel.numberOfLines = 0
            graphLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            graphLabel.sizeToFit()
            
            graphLabel.layer.borderWidth = 1
            
            mPageTwoContentV.addSubview(markView)
            mPageTwoContentV.addSubview(graphLabel)
        }
        
        var axisX: CGFloat = 0
        for index in 0...2 {
            if index == 0 {
                axisX = 65
            }
            axisX += 40
            let graphAxis: UILabel = UILabel(frame: CGRect(x: axisX, y: mPageTwoContentV.height - 40, width: 120, height: 0))
            graphAxis.text = "Before application\(index)."
            graphAxis.font = UIFont(name: "Reader", size: 15)
            graphAxis.textAlignment = .center
            graphAxis.numberOfLines = 0
            graphAxis.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            graphAxis.layer.borderWidth = 1
            
            mPageTwoContentV.addSubview(graphAxis)
            axisX += graphAxis.width
            graphAxis.sizeToFit()
        }
    }
    
}
