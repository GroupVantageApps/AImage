//
//  GcodeEntityswift
//  Share Beauty App
//
//  Created by koji on 2016/09/24.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

import UIKit

class GcodeEntity: NSObject {

    var gcodeId: Int? = 0
    var gcode: String = String()
    var productId: Int? = 0

    //content
    var colorball: Int? = 0
    var unitId: Int? = 0

    var lastUpdateTs: String = String()
    var deleteFlg: Int? = 0
}
