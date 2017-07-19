import UIKit
import APNGKit

class LoadingView: BaseView {
        
    static var darkBlurView = UIVisualEffectView()
    
    static func show(vc: UIViewController) {
        let viewFrame = CGRect(x: 0, y: 0, width: vc.view.bounds.width, height: vc.view.bounds.height)
        darkBlurView =
            blurEffectView(
                fromBlurStyle: .dark,
                frame: viewFrame)
        let apngImage = APNGImage(data: getResourceImage(name: "35")! as Data )
        let loadingImageView = APNGImageView(image: apngImage)
        loadingImageView.frame = CGRect(x: vc.view.bounds.width / 2 - 25, y: vc.view.bounds.height / 2 - 25, width: 50, height: 50)
        loadingImageView.startAnimating()
        darkBlurView.addSubview(loadingImageView)
        vc.view.addSubview(darkBlurView)
    }
    static func dismiss(vc: UIViewController) {
        self.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            darkBlurView.alpha = 0
        }, completion: { (finished: Bool) in
            darkBlurView.removeFromSuperview()
        })
    }
    
    static func blurEffectView(fromBlurStyle style: UIBlurEffectStyle, frame: CGRect) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = frame
        return blurView
    }
    static func getResourceImage(name:String)-> NSData?{
        let bundlePath : String = Bundle.main.path(forResource: "bundles", ofType: "bundle")!
        let bundle : Bundle = Bundle(path: bundlePath)!
        if let imagePath : String = bundle.path(forResource: name, ofType: "png"){
            let fileHandle : FileHandle = FileHandle(forReadingAtPath: imagePath)!
            let imageData : NSData = fileHandle.readDataToEndOfFile() as NSData
            return imageData
        }
        return nil
    }
    
}
