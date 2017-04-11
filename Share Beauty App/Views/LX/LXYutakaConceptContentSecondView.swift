//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation

class LXYutakaConceptContentSecondView: UIView {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    
    @IBOutlet var mDetailLbl: UILabel!
    func setUI(){
        self.mDetailLbl.text = "YUTAKA OMOTENASHI SOUND  ows with the rhythm of the massage therapist’s arm movements, a technology unique to SHISEIDO.\nThe composition includes natural sounds recorded at Mount Koya, one of Japan’s most spiritual sites. \nThese sounds create an immersive relaxation effect that deepens the skincare experience."
        self.mDetailLbl.clipsToBounds = true
    }
    
    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
}
