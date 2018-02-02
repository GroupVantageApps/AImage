//
//  LuxuryFiveSecretsTopViewController.swift
//  Share Beauty App
//
//  Created by Naoki.Kuratomi on 2018/02/01.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class LuxuryFiveSecretsTopViewController: LXBaseViewController, LXNavigationViewDelegte, LXHeaderViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak var mBGImgV: UIImageView!
    @IBOutlet var mHeaderView: LXHeaderView!
    @IBOutlet var mNavigationView: LXNavigationView!
    
    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL, Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL]
    
    let btnTitleText = ["THE ENMEI\nHERB","BURNET\nEXTRACT","JAPANESE\nBOTANICALS","RICH TEXTURE\nDELICATE\nFRAGRANCE","ELEGANT\nDESIGN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mScrollV.delegate = self
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppFoundationInfos.map {$0.title})
        } else {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        }
        
        self.mBGImgV.image = UIImage(named: "ns_page_03_back.png")
        
        mHeaderView.backgroundColor = UIColor.black
        mNavigationView.backgroundColor = UIColor.black
        
        setBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
    
    func setBtn(){
        for i in 0...4{
            let button = UIButton()
            button.setImage(UIImage(named: "nsbutton_\(i).png"), for: .normal)
            //button.backgroundColor = UIColor.white
            button.frame = CGRect(x: 0 + (Int((self.mVContent.frame.width-4)/5))*i+i, y: 180, width: Int((self.mVContent.frame.width-4)/5), height: 510)
            button.tag = 80+i
            button.addTarget(self, action: #selector(self.detailSecret(_:)), for: .touchUpInside)
            self.mVContent.addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.text = self.btnTitleText[i]
            print("text:*\(titleLabel.text)")
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont(name: "ACaslonPro-Regular", size: 18)
            titleLabel.textColor = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0)
            titleLabel.frame = CGRect(x: 0 + (Int((self.mVContent.frame.width-4)/5))*i+i, y: 440, width: Int((self.mVContent.frame.width-4)/5), height: 85)
            self.mVContent.addSubview(titleLabel)
        }
        
    }
    
    @objc private func detailSecret(_ sender: AnyObject){
        print("tag:*\(sender.tag)")
        let scrollContentV = UIScrollView()
        scrollContentV.delegate = self
        //scrollContentV.backgroundColor = UIColor.gray
        scrollContentV.tag = 88
        scrollContentV.frame.size = CGSize(width: self.mVContent.frame.width-100, height:self.view.frame.height-80)
        scrollContentV.center = self.mVContent.center
        scrollContentV.origin.y += 50
        scrollContentV.contentSize = CGSize(width: (scrollContentV.frame.width)*5, height: scrollContentV.frame.height)
        scrollContentV.isPagingEnabled = true
        scrollContentV.bounces = false
        let scrollWidth = scrollContentV.frame.width
        
        
        for i in 0...4{

            let page = UIImageView(image: UIImage(named:"ns_page_\(i).png"))
            page.frame = CGRect(x: CGFloat(i) * scrollWidth, y: 0, width: scrollWidth, height: scrollContentV.frame.height)
            page.contentMode = .scaleAspectFit
            scrollContentV.addSubview(page)
            
            let closeBtn = UIButton()
            closeBtn.setImage(UIImage(named: "close_button.png"), for: .normal)
            closeBtn.frame = CGRect(x: scrollWidth-40+(CGFloat(i)*scrollWidth), y: 10, width: 40, height: 40)
            closeBtn.addTarget(self, action: #selector(self.closeScrollV(_:)), for: .touchUpInside)
            scrollContentV.addSubview(closeBtn)
            
            let toDetailBtn = UIButton()
            toDetailBtn.backgroundColor = UIColor.black
            toDetailBtn.layer.borderColor = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0 ).cgColor
            toDetailBtn.layer.borderWidth = 1
            toDetailBtn.setTitle("button text", for: .normal)
            //toDetailBtn.titleLabel?.tintColor = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0)
            toDetailBtn.setTitleColor(UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0), for: .normal)
            toDetailBtn.titleLabel?.font = UIFont(name: "ACaslonPro-Semibold", size: 22)
            toDetailBtn.frame = CGRect(x: (scrollWidth/2-toDetailBtn.frame.width)+(CGFloat(i)*scrollWidth), y: 580, width: 180, height: 30)
            toDetailBtn.tag = 80 + i
            toDetailBtn.addTarget(self, action: #selector(self.toDetail(_:)), for: .touchUpInside)
            scrollContentV.addSubview(toDetailBtn)
        
            let titleText = UILabel()
            titleText.text = "title text"
            titleText.textColor  = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0 )
            titleText.font = UIFont(name: "ACaslonPro-Regular", size: 28)
            titleText.frame = CGRect(x: (scrollWidth/2-titleText.frame.width)+(CGFloat(i)*scrollWidth), y: 400, width: 180, height: 40)
            scrollContentV.addSubview(titleText)
            
            let descriptionText = UILabel()
            descriptionText.text = "discription text"
            descriptionText.textColor  = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0 )
            descriptionText.font = UIFont(name: "ACaslonPro-Semibold", size: 22)
            descriptionText.frame = CGRect(x: (scrollWidth/2-descriptionText.frame.width+30)+(CGFloat(i)*scrollWidth), y: 500, width: 180, height: 40)
            scrollContentV.addSubview(descriptionText)
            
            
        }
        
        scrollContentV.contentOffset = CGPoint(x: scrollContentV.contentSize.width / 5 * CGFloat(sender.tag-80), y: 0)
        self.view.addSubview(scrollContentV)
        
    }
    
    @objc private func closeScrollV(_ sender: AnyObject){
        if let contentV = self.view.viewWithTag(88){
            contentV.removeFromSuperview()
        }
    }
    
    @objc private func toDetail(_ sender: AnyObject){
        print("tag:*\(sender.tag)")
    }
    
    


}
