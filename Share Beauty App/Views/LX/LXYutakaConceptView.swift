//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
enum LXYutakaConceptViewActionType: Int {
    case sounds, tool, music, smell
}

protocol LXYutakaConceptViewDelegate: NSObjectProtocol {
    func didLXYutakaConceptViewAction(_ type: LXYutakaConceptViewActionType)
    func movieAct()
}
class LXYutakaConceptView: UIView {
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    weak var delegate: LXYutakaConceptViewDelegate?
    var showMovieBtn: UIButton!
    
    func setAction(){
        mXbutton.setImage(UIImage(named: "btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        showMovieBtn = self.viewWithTag(30) as! UIButton!
        showMovieBtn.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
    }
    @IBAction func showMovie(_ sender: Any) {
        self.isHidden = true
        delegate?.movieAct()
    }
    
    @IBAction private func tappedToolBtn(_ sender: AnyObject) {
        delegate?.didLXYutakaConceptViewAction(.tool)
    }

    @IBAction private func tappedMusicBtn(_ sender: AnyObject) {
        delegate?.didLXYutakaConceptViewAction(.music)
    }

    @IBAction private func tappedSmellBtn(_ sender: AnyObject) {
        delegate?.didLXYutakaConceptViewAction(.smell)
    }

    @IBAction func close(_ sender: Any) {
        self.isHidden = true
    }
}
