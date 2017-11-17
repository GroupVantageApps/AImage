//
//  AboutShiseidoImageViewController.swift
//  Share Beauty App
//
//  Created by yushikaneshima on 2017/11/14.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class AboutShiseidoImageViewController: UIViewController, NavigationControllerAnnotation {
    
    @IBOutlet weak var FrontImageView: UIImageView!
    @IBOutlet weak var playMovieButton: UIButton!
    // NavigationControllerAnnotation
    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true
    private let mScreen = ScreenData(screenId: Const.screenIdAboutShiseido)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }
    
    deinit {
        self.delegate?.setAboutShiseidoButtonEnabled(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        self.delegate?.setAboutShiseidoButtonEnabled(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getImage() {
        let frontImage = AppItemTable.getMainImageByItemId(itemId: 7844)
        FrontImageView.image = FileTable.getImage(frontImage.first)
    }
    
    @IBAction func tapedPlayMovie(_ sender: Any) {
        let vc = UIViewController.GetViewControllerFromStoryboard("AboutShiseidoBrandViewController", targetClass: AboutShiseidoBrandViewController.self) as! AboutShiseidoBrandViewController
        self.delegate?.nextVc(vc)
    }
}


