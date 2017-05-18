//
//  MakeupUsageView.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2017/03/06.
//  Copyright © 2017年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class MakeupUsageView: BaseView {
    @IBOutlet weak private var mVContent: UIView!

    let space: CGFloat = 30 //30

    var movies = [Int]()

    var productId: Int = 0 {
        didSet {
            self.makeDummyData()
            self.setupUsageView()
        }
    }

    var movieInfos: [MovieInfo]!

    private func makeDummyData() {
        let items = AppItemTable.getItemsByScreenCode("17AWSMK")
        let basic = AppItemTable.getNameByItemId(itemId: 7899)
        let cateye = AppItemTable.getNameByItemId(itemId: 7900)
        if productId == 513 { //ink eyeliner
            var movieInfo1 = MovieInfo()
            movieInfo1.title = basic
            movieInfo1.movieId = 6025

            var stepInfo1 = StepUsageInfo()
            stepInfo1.stepNumber = 1
            stepInfo1.text = items["11"]
            stepInfo1.startTime = 0 //AppItemTable.getSeekByItemId(itemId: 7861) 以下時間ベタがきに変更　t-hirai
            stepInfo1.endTime = 10//AppItemTable.getSeekByItemId(itemId: 7862)
            var stepInfo2 = StepUsageInfo()
            stepInfo2.stepNumber = 2
            stepInfo2.text = items["12"]
            stepInfo2.startTime = 10//AppItemTable.getSeekByItemId(itemId: 7862)
            stepInfo2.endTime = 15.00//AppItemTable.getSeekByItemId(itemId: 7863)
            var stepInfo3 = StepUsageInfo()
            stepInfo3.stepNumber = 3
            stepInfo3.text = items["13"]
            stepInfo3.startTime = 15.00//AppItemTable.getSeekByItemId(itemId: 7863) //7863
            stepInfo3.endTime = 30//AppItemTable.getSeekByItemId(itemId: 7864)
            var stepInfo4 = StepUsageInfo()
            stepInfo4.stepNumber = 4
            stepInfo4.text = items["14"]
            stepInfo4.startTime = 30//AppItemTable.getSeekByItemId(itemId: 7864)
            stepInfo4.endTime = 46
            // Cateyeを表示
            movieInfo1.stepUsageInfos = [stepInfo1, stepInfo2, stepInfo3] //BasicなのでstepInfo4を削除
            var movieInfo2 = MovieInfo()
            movieInfo2.title = cateye
            movieInfo2.movieId = 6025 //変更平井
            movieInfo2.stepUsageInfos = [stepInfo1, stepInfo2, stepInfo3, stepInfo4]
            
            movieInfos = [movieInfo1, movieInfo2]
            
           // movieInfos = [movieInfo1]
        } else if productId == 514 { //Brush
            var movieInfo1 = MovieInfo()
            movieInfo1.title = basic
            movieInfo1.movieId = 6028 //変更平井

            var stepInfo1 = StepUsageInfo()
            stepInfo1.stepNumber = 1
            stepInfo1.text = items["21"]
            stepInfo1.startTime = 0 //AppItemTable.getSeekByItemId(itemId: 7906)
            stepInfo1.endTime = 3 //AppItemTable.getSeekByItemId(itemId: 7907)
            var stepInfo2 = StepUsageInfo()
            stepInfo2.stepNumber = 2
            stepInfo2.text = items["22"]
            stepInfo2.startTime = 3 //AppItemTable.getSeekByItemId(itemId: 7907)
            stepInfo2.endTime = 7 //AppItemTable.getSeekByItemId(itemId: 7908)
            var stepInfo3 = StepUsageInfo()
            stepInfo3.stepNumber = 3
            stepInfo3.text = items["23"]
            stepInfo3.startTime = 8 //AppItemTable.getSeekByItemId(itemId: 7908)
            stepInfo3.endTime = 22 //AppItemTable.getSeekByItemId(itemId: 7909)
            var stepInfo4 = StepUsageInfo()
            stepInfo4.stepNumber = 4
            stepInfo4.text = items["24"]
            stepInfo4.startTime = 24 //AppItemTable.getSeekByItemId(itemId: 7909)//開始キー
            stepInfo4.endTime = 44
        
            movieInfo1.stepUsageInfos = [stepInfo1, stepInfo2, stepInfo3]

            var movieInfo2 = MovieInfo()
            movieInfo2.title = cateye
            movieInfo2.movieId = 6028 //変更平井
            movieInfo2.stepUsageInfos = [stepInfo1, stepInfo2, stepInfo3, stepInfo4]

            movieInfos = [movieInfo1, movieInfo2]
        } else if productId == 313 {
            var movieInfo1 = MovieInfo()
            movieInfo1.title = basic
            movieInfo1.movieId = 5992

            var stepInfo1 = StepUsageInfo()
            stepInfo1.stepNumber = 1
            stepInfo1.text = items["31"]
            stepInfo1.startTime = 0 //AppItemTable.getSeekByItemId(itemId: 7903)
            stepInfo1.endTime = 12 //AppItemTable.getSeekByItemId(itemId: 7904)
            var stepInfo2 = StepUsageInfo()
            stepInfo2.stepNumber = 2
            stepInfo2.text = items["33"]
            stepInfo2.startTime = 13 //AppItemTable.getSeekByItemId(itemId: 7904)
            stepInfo2.endTime = 21 //AppItemTable.getSeekByItemId(itemId: 7905)
            var stepInfo3 = StepUsageInfo()
            stepInfo3.stepNumber = 3
            stepInfo3.text = items["32"]
            stepInfo3.startTime = 21//AppItemTable.getSeekByItemId(itemId: 7905)
            stepInfo3.endTime = 27
            var stepInfo4 = StepUsageInfo()
            stepInfo4.stepNumber = 4
            stepInfo4.text = items["32"]
            stepInfo4.startTime = 28 //AppItemTable.getSeekByItemId(itemId: 7905)
            stepInfo4.endTime = 33

            movieInfo1.stepUsageInfos = [stepInfo1, stepInfo2, stepInfo3, stepInfo4]
            movieInfos = [movieInfo1]

        } else if productId == 252 {
            var movieInfo1 = MovieInfo()
            movieInfo1.title = basic
            movieInfo1.movieId = 5989

            var stepInfo1 = StepUsageInfo()
            stepInfo1.stepNumber = 1
            stepInfo1.text = items["41"]
            stepInfo1.startTime = 0//AppItemTable.getSeekByItemId(itemId: 7901)
            stepInfo1.endTime = 6//AppItemTable.getSeekByItemId(itemId: 7902)
            var stepInfo2 = StepUsageInfo()
            stepInfo2.stepNumber = 2
            stepInfo2.text = items["42"]
            stepInfo2.startTime = 6//AppItemTable.getSeekByItemId(itemId: 7902)
            stepInfo2.endTime = 13

            movieInfo1.stepUsageInfos = [stepInfo1, stepInfo2]
            movieInfos = [movieInfo1]

        }
//        var movieInfos = StepUsageInfo()
//        movieInfo.movieId =
//            movieInfo.title = "title"
//        stepUsageInfos = []
//        for i in 0..<3 {
//            var info = StepUsageInfo()
//            info.stepNumber = i + 1
//            let str = "step\(info.stepNumber) dummy "
//            var combined = ""
//            (0..<20).forEach({ _ in
//                combined += str
//            })
//            info.text = combined
//            info.startTime = Float64(i * 4)
//            info.endTime = info.startTime + Float64(4)
//            stepUsageInfos.append(info)
//        }
    }

    private func setupUsageView() {
        movieInfos.forEach { movieInfo in
            let stepUsageView = StepUsageView()
            stepUsageView.translatesAutoresizingMaskIntoConstraints = false
            mVContent.addSubview(stepUsageView)
            stepUsageView.setup(movieInfo: movieInfo)
        }
        var constraints = [NSLayoutConstraint]()
        mVContent.subviews.forEach { view in
            let top = NSLayoutConstraint.equalTopEdge(item: view, toItem: mVContent, space: space)
            let bottom = NSLayoutConstraint.equalBottomEdge(item: mVContent, toItem: view, space: space)
            constraints += [top, bottom]
            if view == mVContent.subviews.first {
                let left = NSLayoutConstraint.equalLeftEdge(item: view, toItem: mVContent, space: space)
                constraints.append(left)
            } else {
                let width = NSLayoutConstraint.equalWidth(item: view, toItem: mVContent.subviews.first!)
                constraints.append(width)
            }
            if view == mVContent.subviews.last {
                let right = NSLayoutConstraint.equalRightEdge(item: mVContent , toItem: view, space: space)
                constraints.append(right)
            } else {
                let right = NSLayoutConstraint.connectLeftRightEdge(item: mVContent.subviews.after(view)! , toItem: view, space: space)
                constraints.append(right)
            }
        }
        mVContent.addConstraints(constraints)
    }
}
