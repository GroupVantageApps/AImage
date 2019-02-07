
import Foundation
import AVFoundation
import AVKit
class LuxuryLegendaryEnmeiViewController: LXBaseViewController, LXNavigationViewDelegte, LXHeaderViewDelegate, UIScrollViewDelegate{
    


    @IBOutlet weak private var mScrollV: UIScrollView!
    @IBOutlet weak private var mVContent: UIView!
    
    
    @IBOutlet var ProImage: UIImageView!
    @IBOutlet var LLEImage: UIImageView!
    
    @IBOutlet var ProBtn: UIButton!
    @IBOutlet var LLEBtn: UIButton!
    
//    private let mScreen = ScreenData(screenId: Const.screenIdLXProductDetail)
    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Luxury Legendary Enmei"
//    var products: [ProductData]!
//    var tmpProducts: [ProductData]!
    private var mUpperSteps = [DBStructStep]()
    private var mLowerSteps = [DBStructLineStep]()
    var isEnterWithNavigationView: Bool = true
    
    @IBOutlet var mHeaderView: LXHeaderView!
    @IBOutlet var mNavigationView: LXNavigationView!

    private static let outAppInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL, Const.outAppInfoUvInfo, Const.outAppInfoSoftener, Const.outAppInfoNavigator]
    private static let outAppFoundationInfos = [Const.outAppInfoFoundation, Const.outAppInfoUltimune, Const.outAppInfoESSENTIAL]
    
    @IBOutlet var LECImage: UIImageView!
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = UIImage(named: "page2_visual_1.png")
        self.ProImage.image = image1
        
        let image2 = UIImage(named: "page2_visual_2.png")
        self.LLEImage.image = image2
        
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
        
//        let lxArr = LanguageConfigure.lxcsv
//
//        let line = LineDetailData.init(lineId: 1)
//        mUpperSteps = line.step
//        mLowerSteps = mUpperSteps.flatMap {$0.lineStep}
//        var beautyCsvId = 7
//        print(mLowerSteps)
//        for (i, step) in mLowerSteps.enumerated() {
//            let baseV = self.view.viewWithTag(i + 10)! as UIView
//            let stepLbl = baseV.viewWithTag(i + 60) as! UILabel
//            let stepCsvId = i + 4
//
//            if ((lxArr[String(stepCsvId)]?.data(using: String.Encoding.ascii, allowLossyConversion: false)) != nil) {
//                stepLbl.text = lxArr[String(stepCsvId)]
//            } else {
//                let font: UIFont? = UIFont(name: "ACaslonPro-Regular", size: 20)
//                let stepLblString: NSMutableAttributedString = NSMutableAttributedString(string: lxArr[String(stepCsvId)]!, attributes: [NSFontAttributeName: font!])
//                stepLblString.setAttributes([NSFontAttributeName: font!,NSBaselineOffsetAttributeName: -1], range: NSRange(location:0,length: (lxArr[String(stepCsvId)]?.count)!))
//                stepLbl.attributedText = stepLblString
//            }
//
//                }
            }
        }
    
func viewWillAppear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewWillAppear")
//        self.navigationController?.isNavigationBarHidden = true
//        if (bgAudioPlayer != nil){ bgAudioPlayer.play() }
    }
func viewDidAppear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewDidAppear")
    }
func viewWillDisappear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewWillDisappear")
    }
func viewDidDisappear(_ animated: Bool) {
        print("LuxuryLegendaryEnmeiViewController.viewDidDisappear")
    }






    


