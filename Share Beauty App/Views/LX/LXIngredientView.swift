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
    func didTapshowGeneTech()
} 
class LXIngredientView: UIView, UIScrollViewDelegate { 
    private var apngImageV: APNGImageView!
    @IBOutlet var skinGeneceTextLabel: UITextView!
    weak var delegate: LXIngredientViewDelegate?  
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    
    @IBOutlet weak var mScrollV: UIScrollView!
    @IBOutlet weak var mConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var mPlayImgV: UIImageView!
    @IBOutlet weak var mEffectImgV: UIImageView!
    @IBOutlet weak var mContentV: UIView!

    var mGraphBtn: UIButton!
    var mMovieBtn: UIButton!
    func setAction(productId: Int){
        if productId == 621 {
            self.mScrollV.size = self.size
            self.mConstraintHeight.constant = self.size.height
            self.mContentV.center = CGPoint(x: self.size.width*0.5 ,y: self.size.height*0.5)
            self.mScrollV.minimumZoomScale = 1.0
            self.mScrollV.maximumZoomScale = 6.0
            self.mScrollV.delegate = self
            self.mScrollV.contentSize = self.mContentV.size
            
            let geneV: LXLegendaryEnmeiComplexView = UINib(nibName: "LXLegendaryEnmeiComplexView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXLegendaryEnmeiComplexView
            geneV.setUI()
            geneV.frame  = CGRect(x: 0, y: 0, width: 960, height: self.size.height)
//            let geneBtn = geneV.viewWithTag(5) as! UIButton
//            geneBtn.addTarget(self, action: #selector(showGeneTech), for: .touchUpInside)
            self.mContentV.addSubview(geneV)
            
            
            self.mScrollV.contentSize = CGSize(width: 960 , height: self.size.height)
            self.mScrollV.addSubview(self.mContentV)
            mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
            mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
            self.addSubview(mXbutton)
        } else {
        
        self.mScrollV.size = self.size
        self.mConstraintHeight.constant = self.size.height
        self.mContentV.center = CGPoint(x: self.size.width*0.5 ,y: self.size.height*0.5)
        self.mScrollV.minimumZoomScale = 1.0
        self.mScrollV.maximumZoomScale = 6.0
        self.mScrollV.delegate = self
        self.mScrollV.contentSize = self.mContentV.size
        print(self.mContentV.size)
        print(self.size.height)
        self.mPlayImgV.image = FileTable.getLXFileImage("skingenece_playImg.png")
        self.mEffectImgV.image = FileTable.getLXFileImage("skingenece_graphimg.png")
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        mMovieBtn = self.viewWithTag(30) as! UIButton!
        mMovieBtn.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        mGraphBtn = self.viewWithTag(31) as! UIButton!
        mGraphBtn.addTarget(self, action: #selector(showSkinGraph), for: .touchUpInside)

        let image = FileTable.getLXFileAImage("enmei.png")
        image?.repeatCount = 10
        apngImageV = self.viewWithTag(50) as! APNGImageView!
        apngImageV.image = image
        apngImageV.startAnimating()
        let lxArr = LanguageConfigure.lxcsv
        
        for i in 0..<4 {
            let label = self.viewWithTag(10 + i) as! UILabel
            let csvId = 17 + i
            label.text = lxArr[String(csvId)]
        }
      }
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
    
    @IBAction func showSkinGraph(_ sender: Any) {
        self.removeFromSuperview()
        delegate?.didTapshowSkinGraph()
    }
    
    @IBAction func showGeneTech(_ sender: Any) {
        self.removeFromSuperview()
        delegate?.didTapshowGeneTech()
    }
    
    @IBAction func showMovie(_ sender: Any) {
        let vc = UIViewController.GetViewControllerFromStoryboard("LuxuryIngredientViewController", targetClass: LuxuryIngredientViewController.self) as! LuxuryIngredientViewController
        self.removeFromSuperview()
        delegate?.movieAct()
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.mContentV
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            self.mScrollV.isPagingEnabled = true
        } else {
            self.mScrollV.isPagingEnabled = false        
        }
    }
    
}
