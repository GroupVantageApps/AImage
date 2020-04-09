//
//  LXYutakaConcept.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/03/02.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
enum LXYutakaConceptViewActionType: Int {
    case tool, music, smell
}

protocol LXYutakaConceptViewDelegate: NSObjectProtocol {
    func didLXYutakaConceptViewAction(_ type: LXYutakaConceptViewActionType)
    func movieAct()
}
class LXYutakaConceptView: UIView  ,UIScrollViewDelegate{
    let mXbutton = UIButton(frame: CGRect(x: 960 - 38, y: 16.7, width: 38, height: 38))
    weak var delegate: LXYutakaConceptViewDelegate?
    var showMovieBtn: UIButton!

    @IBOutlet weak var mToolBtn: UIButton!
    
    @IBOutlet weak var mMusicBtn: UIButton!
    
    @IBOutlet weak var mSmellBtn: UIButton!
    @IBOutlet weak var mContentV: UIView!
    @IBOutlet weak var mScrollV: UIScrollView!
    func setAction(){
        mXbutton.setImage(FileTable.getLXFileImage("btn_close.png"), for: UIControl.State.normal)
        mXbutton.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.addSubview(mXbutton)

        self.mScrollV.delegate = self        
        self.mScrollV.minimumZoomScale = 1.0
        self.mScrollV.maximumZoomScale = 6.0
    
        showMovieBtn = self.viewWithTag(30) as! UIButton!
        showMovieBtn.setImage(FileTable.getLXFileImage("lx_start.png"), for: .normal)
        showMovieBtn.addTarget(self, action: #selector(showMovie), for: .touchUpInside)
        
        let path = FileTable.getPath(6108)
        if let arr = NSArray(contentsOf: path) as? [String] {
            print(arr)
            let countryCode = CountryTable.getEntity(LanguageConfigure.countryId)
            if arr.contains(countryCode.code){
                self.mToolBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_1b.png"), for: .normal)
            } else {
                self.mToolBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_1.png"), for: .normal)
            }
        } else {
            self.mToolBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_1.png"), for: .normal)
        }
        
        self.mMusicBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_2.png"), for: .normal)
        self.mSmellBtn.setImage(FileTable.getLXFileImage("lx_yutaka_c_3.png"), for: .normal)
        
        let lxArr = LanguageConfigure.lxcsv
        for i in 0..<5 {
            let label = self.viewWithTag(i + 10) as! UILabel
            let content = lxArr[String(format: "%d", i + 78)]
            label.text = content
        }
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
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.mContentV
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            self.mScrollV.isPagingEnabled = true
        } else {
            self.mScrollV.isPagingEnabled = false        
        }
    }
}
