import Alamofire
import SwiftyJSON
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
    let API_BASE_URL = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&format=json&nojsoncallback=1&api_key="
    let API_KEY = "da9d38d3dee82ec8dda8bb0763bf5d9c"
    let LIMIT = 20

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
        guard
            let url = URL(string: self.API_BASE_URL + self.API_KEY)
        else
        {
            LOG("ERROR Request URL was malformed")
            return
        }

        Alamofire.request(url).responseJSON { [weak self] response in
            let result = response.result
            // Success.
            if
                result.isSuccess,
                let value = result.value
            {
                self?.parseItemsJSON(JSON(value))
            }
            // Failure.
            else
            {
                self?.LOG("ERROR Could not get images: '\(String(describing: result.error))'")
            }
        }
    }

    private func parseItemsJSON(_ json: JSON)
    {
        let jsonItems = json["photos"]["photo"]

        var items = [String]()
        for jsonItem in jsonItems
        {
            let ji = jsonItem.1
            let urlString =
                flickrImageURLString(
                    forFarm: ji["farm"].stringValue,
                    server: ji["server"].stringValue,
                    id: ji["id"].stringValue,
                    secret: ji["secret"].stringValue
                )
            items.append(urlString)

            // Only parse LIMIT number of JSON items.
            if items.count >= self.LIMIT
            {
                break
            }
        }

        self.items = items
    }

}

