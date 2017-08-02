//
//  GscViewController.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/02/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import AVFoundation
protocol GscNavigationControllerDelegate: NSObjectProtocol {
    func nextVc<T: UIViewController>(_ toVc: T) where T: GscNavigationControllerAnnotation
}

protocol GscNavigationControllerAnnotation: NSObjectProtocol {
    weak var gscDelegate: GscNavigationControllerDelegate? {get set}
}

class GscNavigationViewController: GscBaseViewController, UIScrollViewDelegate, GscHeaderViewDelegate, GscNavigationControllerDelegate {
    @IBOutlet weak private var mVContent: UIView!
    @IBOutlet weak private var mScrollV: UIScrollView!
    private let mScreen = ScreenData(screenId: Const.screenIdLXTop)
    weak var delegate: NavigationControllerDelegate?
    private static let outAppInfos = [Const.outAppInfoNavigator, Const.outAppInfoUltimune, Const.outAppInfoUvInfo, Const.outAppInfoSoftener]
    @IBOutlet var mBtnOutApp: BaseButton!
    private let mDropDown = DropDown()
    
    @IBOutlet weak var mGscHeaderView: GscHeaderView!
    var lxArr = [String : String]()
    private var mConstraintWidthZero: NSLayoutConstraint?
    var bgAudioPlayer: AVAudioPlayer!
    var moviePlay: MoviePlayerView!
    var moviePlay2: MoviePlayerView!
    var ndGoProductVC = false
    var mSelectType: String = ""
    var mGroupType: String = ""
    
    @IBOutlet weak var mLogoImgV: UIImageView!
    @IBOutlet weak var mTopBGImgV: UIImageView!
    @IBOutlet weak var mBottomLogoImgV: UIImageView!
    var mTapLabel: UILabel!
    var mFindLabel: UILabel!
    
    var mProductId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mGscHeaderView.delegate = self
        mGscHeaderView.mBtnFind.isHidden = true
        mGscHeaderView.mLblTitle.text = ""
        mGscHeaderView.setDropDown(dataSource: type(of: self).outAppInfos.map {$0.title})
        
        let selfWidth = self.view.bounds.width
        let selfHeight = self.view.bounds.height
        
        mScrollV.delegate = self
        

        if (mProductId != nil) {
            let vcChild = UIViewController.GetViewControllerFromStoryboard("ProductDetailViewController", targetClass: ProductDetailViewController.self) as! ProductDetailViewController
            vcChild.productId = mProductId
            vcChild.gscDelegate = self
            vcChild.fromGscVc = true
            self.setVc(vcChild: vcChild)
        } else {
            let line = LineDetailData(lineId: 17)
            let lineListVc = UIViewController.GetViewControllerFromStoryboard("LineListViewController", targetClass: LineListViewController.self) as! LineListViewController
            lineListVc.line = line
            lineListVc.gscDelegate = self
            lineListVc.fromGscVc = true
            self.setVc(vcChild: lineListVc)
        }


    }

    func setVc(vcChild: UIViewController) {
        addChildViewController(vcChild)
        
        mVContent.addSubview(vcChild.view)
        
        vcChild.view.translatesAutoresizingMaskIntoConstraints = false
        
        let equalWidth = NSLayoutConstraint(item: vcChild.view, attribute: .width, relatedBy: .equal, toItem: mVContent, attribute: .width, multiplier: 1.0, constant: 0)
        let equalHeight = NSLayoutConstraint(item: vcChild.view, attribute: .height, relatedBy: .equal, toItem: mVContent, attribute: .height, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: vcChild.view, attribute: .top, relatedBy: .equal, toItem: mVContent, attribute: .top, multiplier: 1.0, constant: 0)
        let left = NSLayoutConstraint(item: vcChild.view, attribute: .left, relatedBy: .equal, toItem: mVContent, attribute: .left, multiplier: 1.0, constant: 0)
        
        mVContent.addConstraints([equalWidth, equalHeight, top, left])
        self.view.layoutIfNeeded()
        
        vcChild.didMove(toParentViewController: self)
    }
    
    func nextVc<T: UIViewController>(_ toVc: T) where T: GscNavigationControllerAnnotation {
        print(#function)
        toVc.gscDelegate = self
        addChildViewController(toVc)
        
        mVContent.addSubview(toVc.view)
        
        toVc.view.translatesAutoresizingMaskIntoConstraints = false
        
        let equalWidth = NSLayoutConstraint(item: toVc.view, attribute: .width, relatedBy: .equal, toItem: mVContent, attribute: .width, multiplier: 1.0, constant: 0)
        let equalHeight = NSLayoutConstraint(item: toVc.view, attribute: .height, relatedBy: .equal, toItem: mVContent, attribute: .height, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: toVc.view, attribute: .top, relatedBy: .equal, toItem: mVContent, attribute: .top, multiplier: 1.0, constant: 0)
        let left = NSLayoutConstraint(item: toVc.view, attribute: .left, relatedBy: .equal, toItem: mVContent, attribute: .left, multiplier: 1.0, constant: 0)
        
        mVContent.addConstraints([equalWidth, equalHeight, top, left])
        self.view.layoutIfNeeded()
        
        toVc.didMove(toParentViewController: self)

    }      

    override func viewWillAppear(_ animated: Bool) {
        print("GscViewController.viewWillAppear")
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        print("GscViewController.viewDidAppear")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("GscViewController.viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("GscViewController.viewDidDisappear")
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mVContent
    }
    @IBAction func outApp(_ sender: Any) {
        mDropDown.show()
    }

    @IBAction func goTop(_ sender: Any) {
        self.showTop()
    }

}
