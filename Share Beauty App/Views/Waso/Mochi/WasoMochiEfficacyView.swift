//
//  WasoMochiEfficacyView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/27.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import APNGKit

class WasoMochiEfficacyView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var mViewPageOne: UIView!
    @IBOutlet weak var mViewPageTwo: UIView!
    
    @IBOutlet weak var mPageOneCopyLabel: UILabel!
    @IBOutlet weak var mApngImageV: APNGImageView!
    
    @IBOutlet weak var mPageTwoContentV: UIView!
    @IBOutlet weak var mPageTwoTitle: UILabel!
    @IBOutlet weak var mPageTwoSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setPageOne()
        self.setPageTwo()
        mApngImageV.image = APNGImage(named: "mochi_effi_circlegraph.png")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        mApngImageV.startAnimating()
    }
    
    func setPageOne() {
        mPageOneCopyLabel.text = AppItemTable.getNameByItemId(itemId: 8056)

        for index in 0...2 {
            let circleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 350, width: 200, height: 0))
            circleLabel.text = AppItemTable.getNameByItemId(itemId: 8053 + index)
            circleLabel.font = UIFont(name: "Reader-Medium", size: 17)
            circleLabel.textAlignment = .center
            circleLabel.numberOfLines = 0
            circleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            circleLabel.sizeToFit()
            circleLabel.centerX = 12 + 250 * CGFloat(index + 1)
            
            mViewPageOne.addSubview(circleLabel)
        }
    }
    
    func setPageTwo() {
        //mPageTwoTitle.text = AppItemTable.getNameByItemId(itemId: 0000)
        mPageTwoSubTitle.text = AppItemTable.getNameByItemId(itemId: 8063)
        
        let graphImageV: UIImageView = UIImageView()
        graphImageV.frame = CGRect(x: 50, y: 10, width: mPageTwoContentV.width - 100, height: mPageTwoContentV.height - 50)
        let image: UIImage = UIImage(named: "mochi_effi_graph.png")!
        graphImageV.image = image
        graphImageV.contentMode = UIViewContentMode.scaleAspectFit
        mPageTwoContentV.addSubview(graphImageV)
        
        for index in 0...1 {
            let markView: UIView = UIView()
            markView.frame = CGRect(x: 80, y: 20 * index + 15, width: 12, height: 12)
            markView.backgroundColor = index == 0 ? UIColor.gray : UIColor(hex: "C20923", alpha: 1)
            
            let graphLabel: UILabel = UILabel()
            graphLabel.frame = CGRect(x: markView.right + 10, y: 0, width: 0, height: 0)
            graphLabel.text = AppItemTable.getNameByItemId(itemId: 8058 + index)
            graphLabel.font = UIFont(name: "Reader", size: 15)
            graphLabel.sizeToFit()
            graphLabel.centerY = markView.centerY
            
            mPageTwoContentV.addSubview(markView)
            mPageTwoContentV.addSubview(graphLabel)
        }
        
        let leftMargin: CGFloat = 150
        for index in 0...2 {
            let graphAxis: UILabel = UILabel()
            graphAxis.frame = CGRect(x: 0, y: mPageTwoContentV.height - 35, width: 110, height: 0)
            graphAxis.text = AppItemTable.getNameByItemId(itemId: 8060 + index)
            graphAxis.font = UIFont(name: "Reader", size: 14)
            graphAxis.textAlignment = .center
            graphAxis.numberOfLines = 0
            graphAxis.lineBreakMode = NSLineBreakMode.byWordWrapping
            graphAxis.sizeToFit()
            graphAxis.centerX = leftMargin + 160 * CGFloat(index)
            
            mPageTwoContentV.addSubview(graphAxis)
        }
    }
    
}
