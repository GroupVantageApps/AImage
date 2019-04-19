//
//  LXTechGeneView.swift
//  Share Beauty App
//
//  Created by Matsuda Hidehiko on 2019/02/07.
//  Copyright © 2019年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import APNGKit

class LXTechGene3View : UIView{
    
    @IBOutlet weak var mVSlider: UISlider!
    @IBOutlet weak var mVContent: UIView!
    
    @IBOutlet weak var BeforeFace: UIImageView!
    
    func setUI() {
       
        mVSlider = sliderSetting(slider: mVSlider, thambImage: UIImage(named: ""))
        mVSlider.tag = 1
        mVSlider.minimumValue = 0
        mVSlider.maximumValue = 1
        mVSlider.value = 0
        mVSlider.addTarget(self, action: #selector(self.sliderAction(slider:)), for: UIControlEvents.valueChanged)
        mVContent.addSubview(mVSlider)
        
        
 
        
    }
    
    func sliderSetting(slider:UISlider, thambImage:UIImage?) -> UISlider {
        slider.setThumbImage(thambImage, for: .normal)
        slider.setMinimumTrackImage(UIImage(named: "efficacy_slider_full"), for: .normal)
        slider.setMaximumTrackImage(UIImage(named: "efficacy_slider_empty"), for: .normal)
        return slider
    }
    func sliderAction(slider:UISlider) {
        let tag = slider.tag
        switch tag {
        case 1:
            self.BeforeFace.alpha = CGFloat(1 - slider.value)
            break;

        default:
            break;
        }
}
}
