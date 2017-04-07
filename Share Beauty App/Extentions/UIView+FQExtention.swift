import UIKit

extension UIView {

    public var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }

    public var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }

    public var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    public var right: CGFloat {
        get { return self.frame.origin.x + self.width }
        set { self.frame.origin.x = newValue - self.width }
    }
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.height }
        set { self.frame.origin.y = newValue - self.height }
    }
    public var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }

    public var centerX: CGFloat {
        get { return self.center.x }
        set { self.center = CGPoint(x: newValue, y: self.centerY) }
    }
    public var centerY: CGFloat {
        get { return self.center.y }
        set { self.center = CGPoint(x: self.centerX, y: newValue) }
    }

    public var origin: CGPoint {
        set { self.frame.origin = newValue }
        get { return self.frame.origin }
    }
    public var size: CGSize {
        set { self.frame.size = newValue }
        get { return self.frame.size }
    }
}

extension UIView {
    public class func animateIgnoreInteraction(duration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        animateIgnoreInteraction(duration: duration, delay: 0, options: .layoutSubviews, animations: animations, completion: completion)
    }

    public class func animateIgnoreInteraction(duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        animateIgnoreInteraction(duration: duration, delay: delay, options: .layoutSubviews, animations: animations, completion: completion)
    }

    public class func animateIgnoreInteraction(duration: TimeInterval, animations: @escaping () -> Void) {
        animateIgnoreInteraction(duration: duration, delay: 0, options: .layoutSubviews, animations: animations, completion: nil)
    }

    public class func animateIgnoreInteraction(duration: TimeInterval, delay: TimeInterval, options: UIViewAnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: animations,
            completion: { finished in
                completion?(finished)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        )
    }
}

extension UIView: HasAssociatedObjects {
    var stringTag: String {
        get {
            let stt = self.associatedObjects["stringTag"] as! String
            return stt
        }
        set {self.associatedObjects["stringTag"] = newValue}
    }
}

extension UIView {
    func copyView() -> UIView {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! UIView
    }
}
