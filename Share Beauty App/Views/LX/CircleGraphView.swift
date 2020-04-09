//
//  CircleGraphView.swift
//  Share Beauty App
//
//  Created by madoka.igarashi on 2017/05/16.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
class CircleGraphView: UIView {
   
    @IBOutlet weak var animV: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var graphImgV: UIImageView!
    // CAShapeLayerインスタンスを生成
    var circle: CAShapeLayer = CAShapeLayer()
    // ※前提条件としてtargetViewが正方形であること
    func drawCircle() {
        
        // ゲージ幅
        let lineWidth: CGFloat = 10
        
        // 描画領域のwidth
        let viewScale: CGFloat = animV.size.width
        
        // 円のサイズ
        let radius: CGFloat = viewScale - lineWidth
        
        // 円の描画path設定
        circle.path = UIBezierPath(roundedRect: CGRect(x:0 ,y: 0, width: radius, height: radius), cornerRadius: radius / 2).cgPath
        
        
        // 円のポジション設定
        circle.position = CGPoint(x: lineWidth / 2 ,y: lineWidth / 2)
        
        // 塗りの色を設定
        circle.fillColor = UIColor.white.cgColor
        
        // 線の幅を設定
        circle.lineWidth = lineWidth
        
        // 該当のUIViewのlayerにsublayerとしてCALayerを追加
        animV.layer.addSublayer(circle)
        
//        // duration0.0のアニメーションにて初期描画(線が書かれていない状態)にしておく
        self.drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 1.0, toValue: 1.0, duration: 0.0, repeatCount: 1.0)
        
    }
    
    func drawCircleAnimation(key: String, animeName: String, fromValue: CGFloat, toValue: CGFloat, duration: TimeInterval, repeatCount: Float) {
        
        let maskLayer = CAShapeLayer()
        
        
        let maskHeight = animV.layer.bounds.size.height
        let maskWidth = animV.layer.bounds.size.width
        
        let centerPoint: CGPoint = CGPoint(x: maskWidth/2, y: maskHeight/2)
        
        let radius = sqrtf(Float(maskWidth * maskWidth) + Float(maskHeight * maskHeight))/2
        
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.black.cgColor
        
        maskLayer.lineWidth = CGFloat(radius)
        
        let arcPath = CGMutablePath()
        
        arcPath.move(to: CGPoint(x:centerPoint.x, y: centerPoint.y - CGFloat( radius/2 )))
        arcPath.addArc(center: CGPoint(x: centerPoint.x, y: centerPoint.y),radius: CGFloat(radius/2), startAngle: CGFloat(3*M_PI/2) ,endAngle:CGFloat( -M_PI/2), clockwise: true)
        
        maskLayer.path = arcPath;
        maskLayer.strokeEnd = fromValue;
        
        animV.layer.mask = maskLayer
        
        animV.layer.mask?.frame = animV.layer.bounds
        
        let swipe = CABasicAnimation(keyPath: "strokeEnd");
        swipe.duration = duration
        
        swipe.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        swipe.fillMode = CAMediaTimingFillMode.forwards
        swipe.isRemovedOnCompletion = false
        swipe.autoreverses = false
        
        swipe.toValue = toValue;
        maskLayer.add(swipe, forKey: "strokeEnd")
    }
}
