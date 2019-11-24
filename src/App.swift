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
    private var imagesController: ImagesController!
    
    private func setupImages()
    {
        let vc = ImagesVC()
        self.imagesVC = vc
        vc.title = NSLocalizedString("Images.Title", comment: "")

        let controller = ImagesController()
        self.imagesController = controller

        controller.itemsChanged.subscribe { [weak self] in
            guard let items = self?.imagesController.items else { return }
            self?.LOG("Image items: '\(items)'")
            // self?.imagesVC.items = items
        }

        controller.refresh()
    }

}
