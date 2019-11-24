import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.setupImages()
        let nc = UINavigationController(rootViewController: self.imagesVC)
        self.window?.rootViewController = nc

        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        return true
    }

    private func LOG(_ message: String)
    {
        NSLog("App \(message)")
    }

    // MARK: - IMAGES

    private var imagesVC: ImagesVC!
    
    private func setupImages()
    {
        let vc = ImagesVC()
        self.imagesVC = vc
        vc.title = NSLocalizedString("Images.Title", comment: "")
    }

}
