//
//  WasoCleanserScentView.swift
//  Share Beauty App
//
//  Created by ryu.ishiduka on 2018/09/20.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class WasoCleanserScentView: UIView {
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setView() {
        let width: CGFloat = mScrollView.width
        let height: CGFloat = mScrollView.height
        
        for page in 0...2 {
            let pageView = UIView(frame: CGRect(x: 0, y: height * CGFloat(page), width: width, height: height))
            let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            let image: UIImage = UIImage(named: "waso_scent_0\(page + 1).png")!
            imageView.image = image
            
            pageView.addSubview(imageView)
            mContentView.addSubview(pageView)
        }
    }
}
