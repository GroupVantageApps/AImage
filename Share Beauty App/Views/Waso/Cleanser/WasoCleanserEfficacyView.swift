//
//  WasoCleanserEfficacyView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/20.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoCleanserEfficacyView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var mViewPageOne: UIView!
    @IBOutlet weak var mViewPageTwo: UIView!
    @IBOutlet weak var mViewPageThree: UIView!
    @IBOutlet weak var mViewPageFour: UIView!
    
    @IBOutlet weak var mPageOneContentV: UIView!
    @IBOutlet weak var mPageOneCopyLabel: UILabel!
    
    @IBOutlet weak var mPageTwoContentV: UIView!
    @IBOutlet weak var mPageTwoTitle: UILabel!
    @IBOutlet weak var mPageTwoSubTitle: UILabel!
    
    @IBOutlet weak var mPageThreeContentV: UIView!
    @IBOutlet weak var mPageThreeTitle: UILabel!
    @IBOutlet weak var mPageThreeSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
        mViewPageTwo.frame = CGRect(x: 0, y: mScrollView.height, width: mScrollView.width, height: mScrollView.height)
        mViewPageThree.frame = CGRect(x: 0, y: mScrollView.height * 2, width: mScrollView.width, height: mScrollView.height)
        mViewPageFour.frame = CGRect(x: 0, y: mScrollView.height * 3, width: mScrollView.width, height: mScrollView.height)
        
        self.setPageOne()
        self.setPageTwo()
        self.setPageThree()
        self.setPageFour()
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
    
    func setPageThree() {
        //mPageThreeTitle.text = AppItemTable.getNameByItemId(itemId: 0000)
        //mPageThreeSubTitle.text = AppItemTable.getNameByItemId(itemId: 0000)
        
        let margin: CGFloat = 60
        var thermoX: CGFloat = 0
        let thermoWidth: CGFloat = 200
        let thermoHeight: CGFloat = 270
        
        for index in 0...1 {
            let thermographImageV: UIImageView = UIImageView(frame: CGRect(x: thermoX + margin, y: 30, width: thermoWidth, height: thermoHeight))
            thermographImageV.backgroundColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.5)
            
            //let image: UIImage = UIImage(named: "waso_87.png")!
            //thermographImageV.image = image
            thermographImageV.contentMode = UIViewContentMode.scaleAspectFit
            
            let thermoLabel: UILabel = UILabel(frame: CGRect(x: 0, y: thermographImageV.bottom + 10, width: thermoWidth, height: 0))
            thermoLabel.text = "3 min. after removing the mask\(index)."
            thermoLabel.font = UIFont(name: "Reader-Medium", size: 16)
            thermoLabel.textAlignment = .center
            thermoLabel.numberOfLines = 0
            thermoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            thermoX = thermographImageV.right
            thermoLabel.sizeToFit()
            thermoLabel.centerX = thermographImageV.centerX
            
            mPageThreeContentV.addSubview(thermographImageV)
            mPageThreeContentV.addSubview(thermoLabel)
        }
        
        let graphParamImageV: UIImageView = UIImageView(frame: CGRect(x: thermoX + 30, y: 30, width: 20, height: thermoHeight))
        graphParamImageV.backgroundColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.5)
        //let image: UIImage = UIImage(named: "waso_87.png")!
        //graphParamImageV.image = image
        graphParamImageV.contentMode = UIViewContentMode.scaleAspectFit
        mPageThreeContentV.addSubview(graphParamImageV)
        
        for index in 0...2 {
            let frame: CGRect = CGRect(x: graphParamImageV.left - 5, y: 0, width: 0, height: 0)
            let paramLabel: UILabel = UILabel(frame: frame)
            
            if index == 0 {
                paramLabel.origin.y = 10
            } else if index == 1 {
                paramLabel.origin.x = graphParamImageV.right + 10
                paramLabel.centerY = graphParamImageV.centerY
            } else {
                paramLabel.origin.y = graphParamImageV.bottom + 10
            }
            paramLabel.text = "param\(index)."
            paramLabel.font = UIFont(name: "Reader", size: 15)
            
            paramLabel.sizeToFit()
            mPageThreeContentV.addSubview(paramLabel)
        }
        
        let directImageV: UIImageView = UIImageView(frame: CGRect(x: thermoWidth + margin, y:0, width: margin, height: 80))
        directImageV.backgroundColor = UIColor(red: 0, green: 0, blue: 100, alpha: 0.5)
        directImageV.centerY = graphParamImageV.centerY
        //let image: UIImage = UIImage(named: "waso_87.png")!
        //directImageV.image = image
        directImageV.contentMode = UIViewContentMode.scaleAspectFit
        mPageThreeContentV.addSubview(directImageV)
    }
    
    func setPageFour() {
        let circleW = mViewPageFour.width / 4
        let margin = (circleW - 160) / 2
        
        for index in 0...3 {
            let circleImageV: UIImageView = UIImageView(frame: CGRect(x: circleW * CGFloat(index) + margin, y: 130, width: 160, height: 160))
            
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
           
            mViewPageFour.addSubview(circleImageV)
            mViewPageFour.addSubview(circleLabel)
        }
    }
}
