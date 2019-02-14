
import Foundation
import AVFoundation
import AVKit
class LuxuryLegendaryEnmeiViewController: LXBaseViewController, LXProductBLSViewDelegate, MoviePlayerViewDelegate, LXNavigationViewDelegte, LXHeaderViewDelegate, LXIngredientViewDelegate, UIScrollViewDelegate{
    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet var ProBtn: UIButton!

    @IBOutlet var LLEBtn: UIButton!
    
    private let mScreen = ScreenData(screenId: Const.screenIdLXProductDetail)
    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Luxury Legendary Enmei"
    var products: [ProductData]!
    var tmpProducts: [ProductData]!
    private var mUpperSteps = [DBStructStep]()
    private var mLowerSteps = [DBStructLineStep]()
    var isEnterWithNavigationView: Bool = true
    
    var bgAudioPlayer: AVAudioPlayer!

    
    @IBOutlet var mHeaderView: LXHeaderView!
    @IBOutlet var mNavigationView: LXNavigationView!

    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL, Const.outAppInfoUvInfo, Const.outAppInfoSoftener, Const.outAppInfoNavigator]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL]
    
    @IBOutlet var LECImage: UIImageView!
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        let lecImage = UIImage(named: "page2_lead.png")
        self.LECImage.image = lecImage

        mScrollV.delegate = self
        mHeaderView.delegate = self
        mNavigationView.delegate = self
        if LanguageConfigure.isOutAppBtnHiddenCountry {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppFoundationInfos.map {$0.title})
        } else {
            mHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        }
        print("LuxuryLegendaryEnmeiViewController")
        self.mScrollV.sendSubview(toBack: mHeaderView)
        self.mScrollV.sendSubview(toBack: mNavigationView)
        
//        LogManager.tapItem(screenCode: mScreen.code, itemId: "")
        
        let lxArr = LanguageConfigure.lxcsv

        let line = LineDetailData.init(lineId: 1)
        mUpperSteps = line.step
        mLowerSteps = mUpperSteps.flatMap {$0.lineStep}
        var beautyCsvId = 7
        print(mLowerSteps)

    }
    
    @IBAction func showSubView(_ sender: Any) {
        let popup: LXIngredientView = UINib(nibName: "LXIngredientView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXIngredientView
        popup.setAction(productId: 621)
        popup.delegate = self
        popup.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
        self.view.addSubview(popup)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewWillAppear")
        //        self.navigationController?.isNavigationBarHidden = true
        //        if (bgAudioPlayer != nil){ bgAudioPlayer.play() }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewDidDisappear")
    }
    
    @IBAction func tappedProduct(_ sender: AnyObject) {
        let toVc = UIViewController.GetViewControllerFromStoryboard("LuxuryProductDetailViewController", targetClass: LuxuryProductDetailViewController.self) as! LuxuryProductDetailViewController
        toVc.productId = 621    //sender.tag
        //    toVc.bgAudioPlayer = self.bgAudioPlayer
        self.navigationController?.pushViewController(toVc, animated: false)
    }
    
    func movieAct(){
        
        bgAudioPlayer.pause()
        let path = Utility.getDocumentPath(String(format: "lx_movie/lx_movie/17AW_LX.mp4"))
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
    
    func onTapRecommend(_ sender: BaseButton) {
        sender.isSelected = !sender.isSelected
        let product = tmpProducts[sender.tag - 80]
        
        if sender.isSelected {
            if RecommendTable.check(product.productId) == 0 {
                var value: DBInsertValueRecommend = DBInsertValueRecommend()
                value.product = product.productId
                value.line = product.lineId
                value.beautySecond = product.beautySecondId
                RecommendTable.insert(value)
            }
            LogManager.tapProductReccomend(recommedFlg: 1, productId: product.productId, screenCode: self.mScreen.code)
        } else {
            RecommendTable.delete(product.productId)
            LogManager.tapProductReccomend(recommedFlg: -1, productId: product.productId, screenCode: self.mScreen.code)
        }
    }
    func didTapshowSkinGraph(){}
    
    func didTapshowGeneTech(){
//        let technologyV: LXProductTechnologyView = UINib(nibName: "LXProductTechnologyView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! LXProductTechnologyView
//        technologyV.frame = CGRect(x: 0,y: 0,width: 960,height: 630)
//        technologyV.setUI(productId: 621)
//        technologyV.center = CGPoint(x: self.view.width * 0.5, y:self.view.height * 0.5)
//        self.view.addSubview(technologyV)
    }
}

