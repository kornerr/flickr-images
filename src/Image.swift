import Anchorage
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

        // Lay image out so that it's completely visible.
        let v = startLastView(forVC: self)
        self.imageView.topAnchor == v.bottomAnchor
        self.imageView.widthAnchor == self.view.widthAnchor
        finishLastView(self.imageView, forVC: self)
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
        self.view.addSubview(self.imageView)
        self.imageView.backgroundColor = .black
        self.imageView.contentMode = .scaleAspectFit

        self.imageChanged.subscribe { [weak self] in
            self?.imageView.image = self?.image
        }
    }

}

