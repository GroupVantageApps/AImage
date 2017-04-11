//
//  LXIngredientView.swift
//  Share Beauty App
//
//  Created by YUN GEONHEE on 2017/02/20.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import APNGKit

protocol LXIngredientViewDelegate: NSObjectProtocol {
    func didTapshowSkinGraph()
    func movieAct()
} 
class LXIngredientView: UIView { 
    private var apngImageV: APNGImageView!
    @IBOutlet var skinGeneceTextLabel: UITextView!
    weak var delegate: LXIngredientViewDelegate?  
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    
    var mGraphBtn: UIButton!
    var mMovieBtn: UIButton!
    func setAction(){

        mXbutton.setImage(UIImage(named: "btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        mGraphBtn = self.viewWithTag(30) as! UIButton!
        mGraphBtn.addTarget(self, action: #selector(showSkinGraph), for: .touchUpInside)
        mMovieBtn = self.viewWithTag(31) as! UIButton!
        mMovieBtn.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        let image = APNGImage(named: "enmei")
        image?.repeatCount = 10
        apngImageV = self.viewWithTag(50) as! APNGImageView!
        apngImageV.image = image
        apngImageV.startAnimating()
    }
    
    @IBAction func close(_ sender: Any) {
         self.isHidden = true
    }
    
    @IBAction func showSkinGraph(_ sender: Any) {
        self.isHidden = true
        delegate?.didTapshowSkinGraph()
    }
    @IBAction func showMovie(_ sender: Any) {
        
        self.isHidden = true
        delegate?.movieAct()
    }
}
