import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class ImageVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupImage()
    }

    private func LOG(_ message: String)
    {
        NSLog("ImageVC \(message)")
    }

    // MARK: - IMAGE

    var image: UIImage?
    {
        didSet
        {
            self.imageChanged.report()
        }
    }
    let imageChanged = Reporter()

    private var imageView: UIImageView!

    private func setupImage()
    {
        self.imageView = UIImageView()
        self.view.embeddedView = self.imageView
        self.imageView.backgroundColor = .black
        self.imageView.contentMode = .scaleAspectFit

        self.imageChanged.subscribe { [weak self] in
            self?.imageView.image = self?.image
        }
    }

}

