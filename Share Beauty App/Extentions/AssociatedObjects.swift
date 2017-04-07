//
//  AssociatedObjects.swift
//  Share Beauty App
//
//  Created by tuntun34 on 2016/09/30.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

protocol HasAssociatedObjects {
    var associatedObjects: AssociatedObjects { get }
}

private var associatedObjectsKey: UInt8 = 0

extension HasAssociatedObjects where Self: AnyObject {

    var associatedObjects: AssociatedObjects {
        guard let associatedObjects = objc_getAssociatedObject(self, &associatedObjectsKey) as? AssociatedObjects else {
            let associatedObjects = AssociatedObjects()
            objc_setAssociatedObject(self, &associatedObjectsKey, associatedObjects, .OBJC_ASSOCIATION_RETAIN)
            return associatedObjects
        }
        return associatedObjects
    }

}

class AssociatedObjects: NSObject {

    var dictionary: [String: Any] = [:]

    subscript(key: String) -> Any? {
        get {
            return self.dictionary[key]
        }
        set {
            self.dictionary[key] = newValue
        }
    }
}
