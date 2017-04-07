//
//  FileEntity.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/10.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class FileEntity: NSObject {

    var fileId: Int? = 0

    //content
    var fileName: String = String()
    var relationLanguage: [Int] = []
    var relationMaster: [Int] = []
    var remarks: String = String()

    var lastUpdateTs: String = String()
    var deleteFlg: Int? = 0
}
