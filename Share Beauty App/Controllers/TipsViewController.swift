//
//  TipsViewController.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/07.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController, NavigationControllerAnnotation {

    @IBOutlet private weak var mImgVTips: UIImageView!

    private let mScreen = ScreenData(screenId: Const.screenIdTips)

    weak var delegate: NavigationControllerDelegate?
    var theme: String?
    var isEnterWithNavigationView: Bool = true

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.theme = mScreen.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let appItemId: Int = AppItemTable.getIdByItemCode(Const.itemIdBeautyTips)
        let entity: AppItemTranslateEntity = AppItemTranslateTable.getEntity(appItemId)
        mImgVTips.image =  FileTable.getImage(entity.mainImage[0])

        Utility.log(entity)
    }
}
