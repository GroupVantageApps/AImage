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

    @IBOutlet weak var mToolBtn: UIButton!
    
    @IBOutlet weak var mMusicBtn: UIButton!
    
    @IBOutlet weak var mSmellBtn: UIButton!
    
    func setAction(){
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControlState.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)
        
        showMovieBtn = self.viewWithTag(30) as! UIButton!
        showMovieBtn.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
        showMovieBtn.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        
        self.mToolBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_1.png"), for: .normal)
        self.mMusicBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_2.png"), for: .normal)
        self.mSmellBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_3.png"), for: .normal)
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
