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
    let scrollContentBaseV = UIView()
    let scrollContentV = UIScrollView()
    let pageControll = UIPageControl()
    let closeBtn = UIButton()
    let pageControll_pop = UIPageControl()
    let closeBtn_pop = UIButton()
    let gold = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0 )
    var bgAudioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var topTitleLabel: UILabel!
    
    
    let lx2Arr = LanguageConfigure.lx2csv
    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL, Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoESSENTIAL]
    
    let btnTitleText = ["THE ENMEI\nHERB","BURNET\nEXTRACT","JAPANESE\nBOTANICALS","RICH TEXTURE\nDELICATE\nFRAGRANCE","ELEGANT\nDESIGN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mScrollV.delegate = self
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        
        topTitleLabel.text = lx2Arr["2"]
        
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

            titleLabel.text = lx2Arr[String(i + 3)]
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont(name: "ACaslonPro-Regular", size: 18)
            titleLabel.textColor = UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0)
            titleLabel.frame = CGRect(x: 0 + (Int((self.mVContent.frame.width-4)/5))*i+i, y: 440, width: Int((self.mVContent.frame.width-4)/5), height: 85)
            self.mVContent.addSubview(titleLabel)
            
            var movieBtn = UIButton()
            movieBtn.frame = CGRect(x: self.mVContent.frame.width-70, y: 105, width: 40, height: 40)
            movieBtn.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
            movieBtn.addTarget(self, action: #selector(self.playMovie(_:)), for: .touchUpInside)
            self.mVContent.addSubview(movieBtn)
        }
        
    }
    
 
    
    @objc private func onTapSecret(_ sender: AnyObject){

        scrollContentBaseV.frame = CGRect(x: 0, y: 0, width: self.mVContent.frame.width - 70, height: self.view.frame.height - 80)
        scrollContentBaseV.center = self.view.center
        scrollContentBaseV.origin.y += 25
        scrollContentBaseV.tag = 70
        
        //let closeBtn = UIButton()
        self.closeBtn.setImage(UIImage(named: "close_button.png"), for: .normal)
        self.closeBtn.frame = CGRect(x: scrollContentBaseV.frame.width - 40, y: 35, width: 40, height: 40)
        self.closeBtn.addTarget(self, action: #selector(self.onTapCloseScroll(_:)), for: .touchUpInside)
        
        self.pageControll.isHidden = false
        let currentPage = sender.tag! - 80
        self.pageControll.numberOfPages = 5
        self.pageControll.currentPage = currentPage
        self.pageControll.pageIndicatorTintColor = UIColor.lightGray
        self.pageControll.currentPageIndicatorTintColor = gold
        self.pageControll.frame = CGRect(x: scrollContentBaseV.frame.width/2 - 100  , y: scrollContentBaseV.frame.height-50, width: 200, height: 50)
        
        self.scrollContentV.delegate = self
        self.scrollContentV.tag = 88
        self.scrollContentV.frame.size = CGSize(width: scrollContentBaseV.frame.width, height:scrollContentBaseV.frame.height)
        self.scrollContentV.origin.x = scrollContentBaseV.origin.x - 35
        self.scrollContentV.contentSize = CGSize(width: (scrollContentBaseV.frame.width)*5, height: scrollContentBaseV.frame.height)
        self.scrollContentV.isPagingEnabled = true
        self.scrollContentV.bounces = false
        let scrollViewWidth = self.scrollContentV.frame.width
        
        
        
        for i in 0...4{
            
            let page = UIImageView(image: UIImage(named:"ns_page_0\(i).png"))
            page.frame = CGRect(x: CGFloat(i) * scrollViewWidth, y: 0, width: scrollViewWidth, height: self.scrollContentV.frame.height)
            page.contentMode = .scaleAspectFit
            
            var titleText = UILabel()
            titleText.textColor  = gold

//            titleText.font = UIFont.boldSystemFontOfSize(CGFloat(UIFont(name: "ACaslonPro-Regular", size: 30))!)
            titleText.font = (UIFont(name: "ACaslonPro-Regular", size: 30))
            titleText.numberOfLines = 0
            titleText.textAlignment = NSTextAlignment.left
            
            var descriptionText = UILabel()
            descriptionText.textColor  = gold
            descriptionText.font = UIFont(name: "ACaslonPro-Regular", size: 18)
            descriptionText.numberOfLines = 0
            descriptionText.textAlignment = NSTextAlignment.left

            let toDetailBtn = UIButton()
            toDetailBtn.backgroundColor = UIColor.black
            toDetailBtn.layer.borderColor = gold.cgColor
            toDetailBtn.layer.borderWidth = 1
            toDetailBtn.titleLabel?.font = UIFont(name: "ACaslonPro-Regular", size: 18)
            toDetailBtn.setTitleColor(UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0), for: .normal)
            toDetailBtn.tag = 80 + i
            toDetailBtn.addTarget(self, action: #selector(self.onTapDetailBtn(_:)), for: .touchUpInside)
            
            self.scrollContentV.addSubview(page)
            self.scrollContentV.addSubview(titleText)
            self.scrollContentV.addSubview(descriptionText)
            self.scrollContentV.addSubview(toDetailBtn)
            
            if i == 0{
                titleText.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 130, width: 400, height: 60)
                descriptionText.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 240, width: 400, height: 300)
                toDetailBtn.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 580, width: 180, height: 30)
                
                self.setText(i: i, titleText: titleText, descriptionText: descriptionText, toDetailBtn: toDetailBtn)
                
            }else if i == 1{
                titleText.frame = CGRect(x: 50+(CGFloat(i)*scrollViewWidth), y: 300, width: 500, height: 40)
                descriptionText.frame = CGRect(x: 50+(CGFloat(i)*scrollViewWidth), y: 270, width: 500, height: 300)
                toDetailBtn.frame = CGRect(x: 60+(CGFloat(i)*scrollViewWidth), y: 500, width: 180, height: 30)
                
                self.setText(i: i, titleText: titleText, descriptionText: descriptionText, toDetailBtn: toDetailBtn)
                
            }else if i == 2{
                titleText.frame = CGRect(x: 50+(CGFloat(i)*scrollViewWidth), y: 50, width: 500, height: 40)
                descriptionText.frame = CGRect(x: 50+(CGFloat(i)*scrollViewWidth), y: -15, width: 500, height: 300)
                
                self.setText(i: i, titleText: titleText, descriptionText: descriptionText, toDetailBtn: toDetailBtn)
                
                //let japaneseDetailBtn = UIButton()
                for j in 0...2{
                    
                    let efficacyTitle = UILabel()
                    efficacyTitle.frame = CGRect(x: (45+(scrollViewWidth/3*CGFloat(j)))+(CGFloat(i)*scrollViewWidth), y: 410, width: 300, height: 120)
                    efficacyTitle.textColor  = gold
                    efficacyTitle.font = UIFont(name: "ACaslonPro-Regular", size: 18)
                    efficacyTitle.numberOfLines = 0
                    efficacyTitle.textAlignment = NSTextAlignment.left
                    
                    let efficacyDescription = UILabel()
                    efficacyDescription.frame = CGRect(x: (45+(scrollViewWidth/3*CGFloat(j)))+(CGFloat(i)*scrollViewWidth), y: 395, width: 280, height: 300)
                    efficacyDescription.textColor  = gold
                    efficacyDescription.font = UIFont(name: "ACaslonPro-Regular", size: 18)
                    efficacyDescription.numberOfLines = 0
                    efficacyDescription.textAlignment = NSTextAlignment.left
                    
                    let efficacyBtn = UIButton()
                    efficacyBtn.backgroundColor = UIColor.black
                    efficacyBtn.layer.borderColor = gold.cgColor
                    efficacyBtn.layer.borderWidth = 1
                    efficacyBtn.titleLabel?.font = UIFont(name: "ACaslonPro-Regular", size: 18)
                    efficacyBtn.tag = 100 + j
                    efficacyBtn.addTarget(self, action: #selector(self.onTapDetailBtn(_:)), for: .touchUpInside)
                    efficacyBtn.setTitleColor(UIColor(red: 171/255.0, green: 154/255.0, blue: 89/255.0, alpha: 1.0), for: .normal)
                    efficacyBtn.frame = CGRect(x: (45+(scrollViewWidth/3*CGFloat(j)))+(CGFloat(i)*scrollViewWidth), y: 600, width: 180, height: 30)
                    
                    self.scrollContentV.addSubview(efficacyTitle)
                    self.scrollContentV.addSubview(efficacyDescription)
                    self.scrollContentV.addSubview(efficacyBtn)
                    
                    self.setEfficacyText(j: j, titleText: efficacyTitle, descriptionText: efficacyDescription, toDetailBtn: efficacyBtn)

                }
                
                
                
            }else if i == 3{
                titleText.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 100, width: 400, height: 60)
                descriptionText.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 110, width: 400, height: 300)
                toDetailBtn.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 390, width: 180, height: 30)
                
                self.setText(i: i, titleText: titleText, descriptionText: descriptionText, toDetailBtn: toDetailBtn)

                
            }else if i == 4{
                titleText.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 100, width: 400, height: 60)
                descriptionText.frame = CGRect(x: 550+(CGFloat(i)*scrollViewWidth), y: 140, width: 400, height: 300)
                
                self.setText(i: i, titleText: titleText, descriptionText: descriptionText, toDetailBtn: toDetailBtn)

            }
            
            
        }
        self.scrollContentV.contentOffset = CGPoint(x: self.scrollContentV.contentSize.width / 5 * CGFloat(sender.tag-80), y: 0)
        self.view.addSubview(scrollContentBaseV)
        scrollContentBaseV.addSubview(self.scrollContentV)
        scrollContentBaseV.addSubview(self.pageControll)
        scrollContentBaseV.addSubview(self.closeBtn)
        
    }
    
    @objc private func onTapCloseScroll(_ sender: UIButton){
        if let contentbaseV = self.view.viewWithTag(70){
            contentbaseV.removeFromSuperview()
        }
    }
    
    @objc private func onTapDetailBtn(_ sender: AnyObject){
        
        if sender.tag < 100{
            
            if sender.tag == 80{
                let popup: LXIngredientView = UINib(nibName: "LXIngredientView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXIngredientView
                popup.delegate = self
                popup.setAction()
                self.scrollContentBaseV.addSubview(popup)
                
                
            }else if sender.tag == 81{
                let popup: LXProductTechnologyView = UINib(nibName: "LXProductTechnologyView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductTechnologyView
                popup.setUI(productId: 521)
                popup.center = CGPoint(x: (sender.superview??.centerX)!, y: (sender.superview??.centerY)!)
                popup.mPageControl.isHidden = true
                popup.mScrollV.contentSize = CGSize(width: popup.mScrollV.contentSize.width/2, height: popup.mScrollV.contentSize.height)
                self.scrollContentBaseV.addSubview(popup)
                
                
            }else if sender.tag == 83{
                let popup: LXYutakaConceptContentThirdView = UINib(nibName: "LXYutakaConceptContentThirdView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXYutakaConceptContentThirdView
                popup.setUI()
                popup.center = CGPoint(x: (sender.superview??.centerX)!, y: (sender.superview??.centerY)!)
                popup.tag = 90
                
                let closeBtn = UIButton()
                closeBtn.setImage(UIImage(named: "close_button.png"), for: .normal)
                closeBtn.frame = CGRect(x: popup.frame.width-40, y: 10, width: 40, height: 40)
                closeBtn.addTarget(self, action: #selector(self.onTapClosePopUp(_:)), for: .touchUpInside)
                popup.addSubview(closeBtn)
                
                self.scrollContentBaseV.addSubview(popup)
                
                
            }
            
        }else{
            
            let japanBotanicalBaseV = UIView()
            japanBotanicalBaseV.frame.size = CGSize(width: 701, height: self.scrollContentBaseV.height)
            japanBotanicalBaseV.center = CGPoint(x: (sender.superview??.centerX)!, y:(sender.superview??.centerY)!)
            japanBotanicalBaseV.tag = 90
            
            self.closeBtn_pop.setImage(UIImage(named: "close_button.png"), for: .normal)
            self.closeBtn_pop.frame = CGRect(x: japanBotanicalBaseV.frame.width - 40, y: 35, width: 40, height: 40)
            self.closeBtn_pop.addTarget(self, action: #selector(self.onTapClosePopUp(_:)), for: .touchUpInside)
            
            self.pageControll_pop.isHidden = false
            let currentPage = sender.tag! - 80
            self.pageControll_pop.numberOfPages = 3
            self.pageControll_pop.pageIndicatorTintColor = UIColor.lightGray
            self.pageControll_pop.currentPageIndicatorTintColor = gold
            self.pageControll_pop.frame = CGRect(x: japanBotanicalBaseV.frame.width/2 - 100  , y: japanBotanicalBaseV.frame.height-50, width: 200, height: 50)
            
            let japanBotanicalscrollV = UIScrollView()
            japanBotanicalscrollV.delegate = self
            japanBotanicalscrollV.backgroundColor = UIColor.gray
            japanBotanicalscrollV.tag = 89
            japanBotanicalscrollV.frame.size = CGSize(width: 701, height: self.scrollContentBaseV.height)
            japanBotanicalscrollV.origin.x = japanBotanicalBaseV.origin.x - 125
            japanBotanicalscrollV.contentSize = CGSize(width: (japanBotanicalscrollV.frame.width)*3, height: japanBotanicalscrollV.frame.height)
            japanBotanicalscrollV.isPagingEnabled = true
            japanBotanicalscrollV.bounces = false
            
            let skingraph: LXAngelicaView = UINib(nibName: "LXAngelicaView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXAngelicaView
            skingraph.setUI()
            skingraph.mXbutton.isHidden = true
            skingraph.frame = CGRect(x: 0, y: 0, width: 701, height: skingraph.frame.height)
            japanBotanicalscrollV.addSubview(skingraph)
            
            let cherryGraphView: LXCherryGraphView = UINib(nibName: "LXCherryGraphView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXCherryGraphView
            cherryGraphView.setUI()
            cherryGraphView.mXbutton.isHidden = true
            cherryGraphView.frame = CGRect(x: 701, y: 0, width: 701, height: cherryGraphView.frame.height)
            japanBotanicalscrollV.addSubview(cherryGraphView)
            
            let greenTeaView: LXGreenTeaView = UINib(nibName: "LXGreenTeaView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXGreenTeaView
            greenTeaView.setUI()
            greenTeaView.mXbutton.isHidden = true
            greenTeaView.frame = CGRect(x: 1402, y: 0, width: 701, height: greenTeaView.frame.height)
            japanBotanicalscrollV.addSubview(greenTeaView)
            
            if sender.tag == 100{
                japanBotanicalscrollV.contentOffset = CGPoint(x: 0, y: 0)
                self.pageControll_pop.currentPage = 0
            }else if sender.tag == 101{
                japanBotanicalscrollV.contentOffset = CGPoint(x: 701, y: 0)
                self.pageControll_pop.currentPage = 1
            }else if sender.tag == 102{
                japanBotanicalscrollV.contentOffset = CGPoint(x: 1402, y: 0)
                self.pageControll_pop.currentPage = 2
            }
            
            self.scrollContentBaseV.addSubview(japanBotanicalBaseV)
            japanBotanicalBaseV.addSubview(japanBotanicalscrollV)
            japanBotanicalBaseV.addSubview(self.closeBtn_pop)
            japanBotanicalBaseV.addSubview(self.pageControll_pop)
            
            
        }
        
    }
    
    @objc private func onTapClosePopUp(_ sender: AnyObject){
        if let popup = self.scrollContentBaseV.viewWithTag(90){
            popup.removeFromSuperview()
        }
    }
    
    @objc private func playMovie(_ sender: AnyObject){
        print("moviestart")
    }
    
    //*UIPageController
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControll.currentPage = Int(pageNumber)
        self.pageControll_pop.currentPage = Int(pageNumber)
    }
    
    
    //*LXIngredientViewDelegate
    func movieAct() {
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
    
    //* tag番号
    
    //* text
    func setText(i:Int, titleText:UILabel, descriptionText:UILabel, toDetailBtn:UIButton){
        if i == 0{
            titleText.text = lx2Arr["8"] 
            descriptionText.text = "\(lx2Arr["9"] as! String)\n\(lx2Arr["10"] as! String)\n\(lx2Arr["11"] as! String)"
            toDetailBtn.setTitle(lx2Arr["12"], for: .normal)
            
        }else if i == 1{
            titleText.text = lx2Arr["13"]
            descriptionText.text = lx2Arr["14"]
            toDetailBtn.setTitle(lx2Arr["15"], for: .normal)
            
        }else if i == 2{
            titleText.text = lx2Arr["16"]
            descriptionText.text = lx2Arr["17"]
            toDetailBtn.setTitle(lx2Arr["15"], for: .normal)
            
        }else if i == 20{
            titleText.text = lx2Arr["16"]
            descriptionText.text = lx2Arr["17"]
            toDetailBtn.setTitle(lx2Arr["15"], for: .normal)
            
        }
        else if i == 3{
            titleText.text = lx2Arr["25"]
            descriptionText.text = lx2Arr["26"]
            toDetailBtn.setTitle(lx2Arr["15"], for: .normal)
        }else if i == 4{
            titleText.text = lx2Arr["28"]
            descriptionText.text = lx2Arr["29"]
            toDetailBtn.setTitle("", for: .normal)
        }
    }
    
    func setEfficacyText(j:Int, titleText:UILabel, descriptionText:UILabel, toDetailBtn:UIButton){
        if j == 0{
            titleText.text = lx2Arr["18"]
            descriptionText.text = lx2Arr["19"]
            toDetailBtn.setTitle(lx2Arr["12"], for: .normal)
            
        }else if j == 1{
            titleText.text = lx2Arr["20"]
            descriptionText.text = lx2Arr["21"]
            toDetailBtn.setTitle(lx2Arr["12"], for: .normal)
            
        }else if j == 2{
            titleText.text = lx2Arr["22"]
            descriptionText.text = lx2Arr["23"]
            toDetailBtn.setTitle(lx2Arr["12"], for: .normal)
            
        }
    }
    
}
