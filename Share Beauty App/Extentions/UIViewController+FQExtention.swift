import UIKit

public extension UIViewController {

    class func GetViewControllerFromMainStoryboard(_ targetClass: AnyClass) -> UIViewController {
        return GetViewControllerFromStoryboard("Main", targetClass: targetClass)
    }

    class func GetViewControllerFromStoryboard(targetClass: AnyClass) -> UIViewController {
        let className = NSStringFromClass(targetClass).components(separatedBy: ".").last!
        let mStoryboard = UIStoryboard(name: className, bundle: nil)
        return mStoryboard.instantiateViewController(withIdentifier: className)
    }

    class func GetViewControllerFromStoryboard(_ storyboardName: String, targetClass: AnyClass) -> UIViewController {
        let mStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let className = NSStringFromClass(targetClass).components(separatedBy: ".").last!
        return mStoryboard.instantiateViewController(withIdentifier: className)
    }
}

extension UIViewController: HasAssociatedObjects {
    fileprivate var alreadyCalledViewWillAppearOnce: Bool {
        get {
            return self.associatedObjects["once_viewWillAppear"] as? Bool ?? false
        }
        set {
            self.associatedObjects["once_viewWillAppear"] = newValue
        }
    }
    fileprivate var alreadyCalledViewDidAppearOnce: Bool {
        get {
            return self.associatedObjects["once_viewDidAppear"] as? Bool ?? false
        }
        set {
            self.associatedObjects["once_viewDidAppear"] = newValue
        }
    }
    fileprivate var alreadyCalledViewDidLayoutSubviewsOnce: Bool {
        get {
            return self.associatedObjects["once_viewDidLayoutSubviews"] as? Bool ?? false
        }
        set {
            self.associatedObjects["once_viewDidLayoutSubviews"] = newValue
        }
    }
    fileprivate func callOnce(_ flag: inout Bool, closure: () -> Void) {
        if !flag {
            closure()
            flag = true
        }
    }
    func viewWillAppearOnce(_ fromFunction: String = #function, closure: () -> Void) {
        guard fromFunction == "viewWillAppear" else {
            return
        }
        callOnce(&alreadyCalledViewWillAppearOnce, closure: closure)
    }

    func viewDidAppearOnce(_ fromFunction: String = #function, closure: () -> Void) {
        guard fromFunction == "viewDidAppear" else {
            return
        }
        callOnce(&alreadyCalledViewDidAppearOnce, closure: closure)
    }

    func viewDidLayoutSubviewsOnce(_ fromFunction: String = #function, closure: () -> Void) {
        guard fromFunction == "viewDidLayoutSubviews()" else {
            return
        }
        callOnce(&alreadyCalledViewDidLayoutSubviewsOnce, closure: closure)
    }
}
