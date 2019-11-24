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
    private var imageVC: ImageVC!
    private var imagesController: ImagesController!
    
    private func setupImages()
    {
        self.imagesVC = ImagesVC()
        self.imagesVC.title = NSLocalizedString("Images.Title", comment: "")

        self.imageVC = ImageVC()
        self.imageVC.title = NSLocalizedString("Image.Title", comment: "")

        self.imagesController = ImagesController()
        self.imagesController.itemsChanged.subscribe { [weak self] in
            guard let items = self?.imagesController.items else { return }
            //self?.LOG("Image items: '\(items)'")
            self?.imagesVC.items = items
        }

        // Display image in full screen upon selection.
        // Only for loaded images.
        self.imagesVC.selectedItemIdChanged.subscribe { [weak self] in
            guard
                let imagesVC = self?.imagesVC,
                let imageVC = self?.imageVC,
                let image = imagesVC.images[imagesVC.selectedItemId]
            else
            {
                return
            }

            imageVC.image = image
            imagesVC.show(imageVC, sender: nil)
        }

        // Load images the first time.
        self.imagesController.refresh()
    }

}
