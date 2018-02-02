//
//  LuxuryFiveSecretsTopViewController.swift
//  Share Beauty App
//
//  Created by Naoki.Kuratomi on 2018/02/01.
//  Copyright © 2018年 AQUA Co., Ltd. All rights reserved.
//

import UIKit
import AVKit

class LuxuryFiveSecretsTopViewController: LXBaseViewController, LXNavigationViewDelegte, LXHeaderViewDelegate, UIScrollViewDelegate , LXIngredientViewDelegate, IngredientSkinGraphViewDelegate{

    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak var mBGImgV: UIImageView!
    @IBOutlet var mHeaderView: LXHeaderView!
    @IBOutlet var mNavigationView: LXNavigationView!
    let scrollContentV = UIScrollView()
    let pageControll = UIPageControl()
    let gold = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0 )
    //weak var delegate: LXIngredientViewDelegate?
    var bgAudioPlayer: AVAudioPlayer!

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("LuxuryFiveSecretsTopViewController.viewWillAppear")
        if (bgAudioPlayer != nil){ bgAudioPlayer.play() }
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
            button.frame = CGRect(x: 0 + (Int((self.mVContent.frame.width-4)/5))*i+i, y: 180, width: Int((self.mVContent.frame.width-4)/5), height: 510)
            button.tag = 80+i
            button.addTarget(self, action: #selector(self.onTapSecret(_:)), for: .touchUpInside)
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
            
            let movieBtn = UIButton()
            movieBtn.frame = CGRect(x: self.mVContent.frame.width-70, y: 105, width: 40, height: 40)
            movieBtn.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
            movieBtn.addTarget(self, action: #selector(self.playMovie(_:)), for: .touchUpInside)
            self.mVContent.addSubview(movieBtn)
        }
        
    }
    
    @objc private func onTapSecret(_ sender: AnyObject){
        print("tag:*\(sender.tag)")
        self.scrollContentV.delegate = self
        self.scrollContentV.tag = 88
        self.scrollContentV.frame.size = CGSize(width: self.mVContent.frame.width-60, height:self.view.frame.height-80)
        self.scrollContentV.center = self.mVContent.center
        self.scrollContentV.origin.y += 50
        self.scrollContentV.contentSize = CGSize(width: (self.scrollContentV.frame.width)*5, height: self.scrollContentV.frame.height)
        self.scrollContentV.isPagingEnabled = true
        self.scrollContentV.bounces = false
        let scrollViewWidth = self.scrollContentV.frame.width
        
        for i in 0...4{

            let page = UIImageView(image: UIImage(named:"ns_page_\(i).png"))
            page.frame = CGRect(x: CGFloat(i) * scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollContentV.frame.height)
            page.contentMode = .scaleAspectFit
            
            let closeBtn = UIButton()
            closeBtn.setImage(UIImage(named: "close_button.png"), for: .normal)
            closeBtn.frame = CGRect(x: scrollViewWidth-45+(CGFloat(i)*scrollViewWidth), y: 10, width: 40, height: 40)
            closeBtn.addTarget(self, action: #selector(self.onTapCloseScroll(_:)), for: .touchUpInside)
            
            let titleText = UILabel()
            titleText.textColor  = gold
            titleText.font = UIFont(name: "ACaslonPro-Regular", size: 28)
            
            let descriptionText = UILabel()
            descriptionText.textColor  = gold
            descriptionText.font = UIFont(name: "ACaslonPro-Semibold", size: 22)

            let toDetailBtn = UIButton()
            toDetailBtn.backgroundColor = UIColor.black
            toDetailBtn.layer.borderColor = gold.cgColor
            toDetailBtn.layer.borderWidth = 1
            toDetailBtn.titleLabel?.font = UIFont(name: "ACaslonPro-Semibold", size: 22)
            toDetailBtn.tag = 80 + i
            toDetailBtn.addTarget(self, action: #selector(self.onTapDetailBtn(_:)), for: .touchUpInside)

            self.scrollContentV.addSubview(page)
            self.scrollContentV.addSubview(closeBtn)
            self.scrollContentV.addSubview(titleText)
            self.scrollContentV.addSubview(descriptionText)
            self.scrollContentV.addSubview(toDetailBtn)
            
            if i == 0{
                titleText.text = "延 title"
                titleText.frame = CGRect(x: (scrollViewWidth/2-titleText.frame.width)+(CGFloat(i)*scrollViewWidth), y: 400, width: 180, height: 40)
                
                descriptionText.text = "延 discription"
                descriptionText.frame = CGRect(x: (scrollViewWidth/2-descriptionText.frame.width+30)+(CGFloat(i)*scrollViewWidth), y: 500, width: 180, height: 40)
                
                toDetailBtn.setTitle("延 button", for: .normal)
                toDetailBtn.setTitleColor(UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0), for: .normal)
                toDetailBtn.frame = CGRect(x: (scrollViewWidth/2-toDetailBtn.frame.width)+(CGFloat(i)*scrollViewWidth), y: 580, width: 180, height: 30)

                
            }else if i == 1{
                titleText.text = "吾 title"
                titleText.frame = CGRect(x: (scrollViewWidth/2-titleText.frame.width)+(CGFloat(i)*scrollViewWidth), y: 400, width: 180, height: 40)
                
                descriptionText.text = "吾 discription"
                descriptionText.frame = CGRect(x: (scrollViewWidth/2-descriptionText.frame.width+30)+(CGFloat(i)*scrollViewWidth), y: 500, width: 180, height: 40)
                
                toDetailBtn.setTitle("吾 button", for: .normal)
                toDetailBtn.setTitleColor(UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0), for: .normal)
                toDetailBtn.frame = CGRect(x: (scrollViewWidth/2-toDetailBtn.frame.width)+(CGFloat(i)*scrollViewWidth), y: 580, width: 180, height: 30)
                
            }else if i == 2{
                titleText.text = "和 title"
                titleText.frame = CGRect(x: (scrollViewWidth/2-titleText.frame.width)+(CGFloat(i)*scrollViewWidth), y: 90, width: 180, height: 40)
                
                descriptionText.text = "和 discription"
                descriptionText.frame = CGRect(x: (scrollViewWidth/2-descriptionText.frame.width+30)+(CGFloat(i)*scrollViewWidth), y: 115, width: 180, height: 40)
                
                //let japaneseDetailBtn = UIButton()
                for j in 0...2{

                    let efficacyTitle = UILabel()
                    efficacyTitle.text = "和 efficacy title\(j)"
                    efficacyTitle.frame = CGRect(x: (65+(scrollViewWidth/3*CGFloat(j)))+(CGFloat(i)*scrollViewWidth), y: 300, width: 180, height: 40)
                    efficacyTitle.textColor  = gold
                    efficacyTitle.font = UIFont(name: "ACaslonPro-Regular", size: 22)
                    
                    let efficacyDescription = UILabel()
                    efficacyDescription.text = "和 efficacy discription\(j)"
                    efficacyDescription.frame = CGRect(x: (65+(scrollViewWidth/3*CGFloat(j)))+(CGFloat(i)*scrollViewWidth), y: 400, width: 180, height: 40)
                    efficacyDescription.textColor  = gold
                    efficacyDescription.font = UIFont(name: "ACaslonPro-Semibold", size: 18)
                    
                    let efficacyBtn = UIButton()
                    efficacyBtn.backgroundColor = UIColor.black
                    efficacyBtn.layer.borderColor = gold.cgColor
                    efficacyBtn.layer.borderWidth = 1
                    efficacyBtn.titleLabel?.font = UIFont(name: "ACaslonPro-Semibold", size: 22)
                    efficacyBtn.tag = 100 + j
                    efficacyBtn.addTarget(self, action: #selector(self.onTapDetailBtn(_:)), for: .touchUpInside)
                    efficacyBtn.setTitle("和 button text\(j)", for: .normal)
                    efficacyBtn.setTitleColor(UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0), for: .normal)
                    efficacyBtn.frame = CGRect(x: (65+(scrollViewWidth/3*CGFloat(j)))+(CGFloat(i)*scrollViewWidth), y: 580, width: 180, height: 30)
                    
                    self.scrollContentV.addSubview(efficacyTitle)
                    self.scrollContentV.addSubview(efficacyDescription)
                    self.scrollContentV.addSubview(efficacyBtn)
                }
                
            }else if i == 3{
                titleText.text = "香 title"
                titleText.frame = CGRect(x: (scrollViewWidth/2-titleText.frame.width)+(CGFloat(i)*scrollViewWidth), y: 400, width: 180, height: 40)
                
                descriptionText.text = "香 discription"
                descriptionText.frame = CGRect(x: (scrollViewWidth/2-descriptionText.frame.width+30)+(CGFloat(i)*scrollViewWidth), y: 500, width: 180, height: 40)
                
                toDetailBtn.setTitle("香 button", for: .normal)
                toDetailBtn.setTitleColor(UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0), for: .normal)
                toDetailBtn.frame = CGRect(x: (scrollViewWidth/2-toDetailBtn.frame.width)+(CGFloat(i)*scrollViewWidth), y: 580, width: 180, height: 30)
                
            }else if i == 4{
                titleText.text = "棘 title"
                titleText.frame = CGRect(x: (scrollViewWidth/2-titleText.frame.width)+(CGFloat(i)*scrollViewWidth), y: 400, width: 180, height: 40)
                
                descriptionText.text = "棘 discription"
                descriptionText.frame = CGRect(x: (scrollViewWidth/2-descriptionText.frame.width+30)+(CGFloat(i)*scrollViewWidth), y: 500, width: 180, height: 40)
                
            }
            
            
        }
        
        self.scrollContentV.contentOffset = CGPoint(x: self.scrollContentV.contentSize.width / 5 * CGFloat(sender.tag-80), y: 0)
        self.view.addSubview(self.scrollContentV)
        
    }
    
    @objc private func onTapCloseScroll(_ sender: AnyObject){
        if let contentV = self.view.viewWithTag(88){
            contentV.removeFromSuperview()
        }
    }
    
    @objc private func onTapDetailBtn(_ sender: AnyObject){
        print("tag:*\(sender.tag)")
        
        if sender.tag < 100{
            
            if sender.tag == 80{
                let popup: LXIngredientView = UINib(nibName: "LXIngredientView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXIngredientView
                popup.delegate = self
                popup.setAction()
                self.scrollContentV.addSubview(popup)
                
            }else if sender.tag == 81{
                let popup: LXProductTechnologyView = UINib(nibName: "LXProductTechnologyView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductTechnologyView
                popup.setUI(productId: 521)
                popup.center = CGPoint(x: self.scrollContentV.contentSize.width / 5 * 1 + popup.frame.width * 0.5 , y:self.scrollContentV.height * 0.5)
                popup.mPageControl.isHidden = true
                popup.mScrollV.contentSize = CGSize(width: popup.mScrollV.contentSize.width/2, height: popup.mScrollV.contentSize.height)
                self.scrollContentV.addSubview(popup)
                
            }else if sender.tag == 83{
                let popup: LXYutakaConceptContentThirdView = UINib(nibName: "LXYutakaConceptContentThirdView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentThirdView
                popup.setUI()
                popup.center = CGPoint(x: self.scrollContentV.contentSize.width / 5 * 3 + popup.frame.width * 0.5 , y:self.scrollContentV.height * 0.5)
                popup.tag = 90
                
                let closeBtn = UIButton()
                closeBtn.setImage(UIImage(named: "close_button.png"), for: .normal)
                closeBtn.frame = CGRect(x: popup.frame.width-40, y: 10, width: 40, height: 40)
                closeBtn.addTarget(self, action: #selector(self.onTapClosePopUp(_:)), for: .touchUpInside)
                popup.addSubview(closeBtn)
                
                self.scrollContentV.addSubview(popup)
                
            }
            
        }else{
//            let contentView = UIView()
//            contentView.backgroundColor = UIColor.blue
//            contentView.frame = CGRect(x: self.scrollContentV.contentSize.width / 5 * 2 + self.scrollContentV.frame.width/2, y: 0, width: 701, height: 701)
//            self.scrollContentV.addSubview(contentView)
            
            let japanBotanicalscrollV = UIScrollView()
            japanBotanicalscrollV.delegate = self
            japanBotanicalscrollV.backgroundColor = UIColor.gray
            japanBotanicalscrollV.tag = 89
            japanBotanicalscrollV.frame.size = CGSize(width: 701, height: 701)
            japanBotanicalscrollV.center = CGPoint(x: self.scrollContentV.contentSize.width / 5 * 2 + self.scrollContentV.frame.width * 0.5 , y:self.scrollContentV.height * 0.5)
            japanBotanicalscrollV.contentSize = CGSize(width: (japanBotanicalscrollV.frame.width)*3, height: japanBotanicalscrollV.frame.height)
            japanBotanicalscrollV.isPagingEnabled = true
            japanBotanicalscrollV.bounces = false

            let greenTeaView: LXGreenTeaView = UINib(nibName: "LXGreenTeaView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXGreenTeaView
            greenTeaView.setUI()
            greenTeaView.frame = CGRect(x: 0, y: 0, width: 701, height: greenTeaView.frame.height)
            japanBotanicalscrollV.addSubview(greenTeaView)
            
            let skingraph: LXAngelicaView = UINib(nibName: "LXAngelicaView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXAngelicaView
            skingraph.setUI()
            skingraph.frame = CGRect(x: 701, y: 0, width: 701, height: skingraph.frame.height)
            japanBotanicalscrollV.addSubview(skingraph)
            
            let cherryGraphView: LXCherryGraphView = UINib(nibName: "LXCherryGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXCherryGraphView
            cherryGraphView.setUI()
            cherryGraphView.frame = CGRect(x: 1402, y: 0, width: 701, height: cherryGraphView.frame.height)
            japanBotanicalscrollV.addSubview(cherryGraphView)
            

            let pageControll = UIPageControl()
            pageControll.pageIndicatorTintColor = UIColor.lightGray
            pageControll.currentPageIndicatorTintColor = gold
            pageControll.numberOfPages = 3
            pageControll.frame = CGRect(x: 701/2 - 100, y: Int(japanBotanicalscrollV.frame.height - 270), width: 200, height: 50)
//            contentView.addSubview(pageControll)
            scrollContentV.addSubview(pageControll)

            
//            for i in 0...2{
//                let pageControll = UIPageControl()
//                pageControll.pageIndicatorTintColor = UIColor.lightGray
//                pageControll.currentPageIndicatorTintColor = gold
//                pageControll.numberOfPages = 3
//                pageControll.currentPage = i
//                pageControll.frame = CGRect(x: 701/2 - 100 + 701 * i, y: Int(japanBotanicalscrollV.frame.height - 70), width: 200, height: 50)
//                japanBotanicalscrollV.addSubview(pageControll)
//            }
            
            if sender.tag == 100{
                japanBotanicalscrollV.contentOffset = CGPoint(x: 0, y: 0)
            }else if sender.tag == 101{
                japanBotanicalscrollV.contentOffset = CGPoint(x: 701, y: 0)
            }else if sender.tag == 102{
                japanBotanicalscrollV.contentOffset = CGPoint(x: 1402, y: 0)
            }
            
            self.scrollContentV.addSubview(japanBotanicalscrollV)
//            contentView.addSubview(japanBotanicalscrollV)
//            self.scrollContentV.addSubview(contentView)

        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControll.currentPage = Int(pageNumber)
    }
    
    @objc private func onTapClosePopUp(_ sender: AnyObject){
        if let popup = self.scrollContentV.viewWithTag(90){
            popup.removeFromSuperview()
        }
    }
    
    @objc private func playMovie(_ sender: AnyObject){
        print("moviestart")
    }
    
    
    //*LXIngredientViewDelegate
    func movieAct() {
        print("bgAudioPlayer:*\(bgAudioPlayer)")
        bgAudioPlayer.pause()
        
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/lx_ingredient.mp4"))
        let videoURL = NSURL(fileURLWithPath: path)
        let avPlayer: AVPlayer = AVPlayer(url: videoURL as URL)
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        NotificationCenter.default.addObserver(self, selector:#selector(self.endMovie),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayerVc.player?.currentItem)
        self.present(avPlayerVc, animated: true, completion: {
        })
        avPlayer.play()
    }
    
    func endMovie(type: Int) {
        bgAudioPlayer.play()
    }
    
    func didTapshowSkinGraph() {
        let skingraph: IngredientSkinGraphView = UINib(nibName: "IngredientSkinGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! IngredientSkinGraphView
        skingraph.setUI()
        skingraph.delegate = self
        skingraph.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.scrollContentV.addSubview(skingraph)
    }
    
    func ingredientMoviePlay(index: Int) {
        bgAudioPlayer.pause()
        
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/3e%d.mp4",index))
        let videoURL = NSURL(fileURLWithPath: path)
        let avPlayer: AVPlayer = AVPlayer(url: videoURL as URL)
        let avPlayerVc = AVPlayerViewController()
        avPlayerVc.player = avPlayer
        if #available(iOS 9.0, *) {
            avPlayerVc.allowsPictureInPicturePlayback = false
        }
        NotificationCenter.default.addObserver(self, selector:#selector(self.endMovie),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayerVc.player?.currentItem)
        self.present(avPlayerVc, animated: true, completion: {
        })
        avPlayer.play()
    }
  

}
