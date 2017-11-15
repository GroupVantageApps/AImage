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
    var theme: String? = "ABOUT SHISEIDO BRAND"
    var isEnterWithNavigationView: Bool = true
    
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
        if let frontImage = FileTable.getImage(6363) {
            FrontImageView.image = frontImage
        }
    }    
    
    @IBAction func tapedPlayMovie(_ sender: Any) {
        let vc = UIViewController.GetViewControllerFromStoryboard("AboutShiseidoBrandViewController", targetClass: AboutShiseidoBrandViewController.self) as! AboutShiseidoBrandViewController
        self.delegate?.nextVc(vc)
    }
}


