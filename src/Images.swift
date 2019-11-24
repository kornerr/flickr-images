import Alamofire
import UIKit

class ImagesVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.setupWebView()
    }

    private func LOG(_ message: String)
    {
        NSLog("ImagesVC \(message)")
    }

    // MARK: - WEB VIEW

    /*
    private var webView: WKWebView!

    private func setupWebView()
    {
        self.webView = WKWebView(frame: .zero, configuration: self.cfgWithCookies())
        self.view.embeddedView = self.webView
    }
    */

}

class ImagesController
{
    let apiBaseURL = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&format=json&nojsoncallback=1&api_key="
    let apiKey = "da9d38d3dee82ec8dda8bb0763bf5d9c"

    init() { }

    func refresh()
    {
        self.loadItems()
    }

    private func LOG(_ message: String)
    {
        NSLog("ImagesController \(message)")
    }

    // MARK: - ITEMS

    var items = [String]()
    {
        didSet
        {
            self.itemsChanged.report()
        }
    }
    let itemsChanged = Reporter()

    func loadItems()
    {
        if let url = URL(string: apiBaseURL + apiKey)
        {
            LOG("loadItems. url: '\(url)'")
            Alamofire.request(url).responseJSON { [weak self] response in
                self?.LOG("Response: '\(response)'")
            }
        }
        else
        {
            LOG("ERROR Request URL was malformed")
        }
    }

}

