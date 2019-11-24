import UIKit

class ImagesVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.setupWebView()

        //self.addLeftBarItem(self.backButton)
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
