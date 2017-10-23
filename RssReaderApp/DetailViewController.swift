import UIKit
import SwiftyJSON
import TOWebViewController

class DetailViewController: TOWebViewController {

    var detailWebView: UIWebView = UIWebView()
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailWebView.frame = self.view.bounds
        self.detailWebView.delegate = self
        self.view.addSubview(self.detailWebView)
        
        if let url = URL(string: self.entry!.link) {
            let request = URLRequest(url: url)
            self.detailWebView.loadRequest(request)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func webViewDidStartLoad(_ webView: UIWebView) {
        // インジケータの表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    override func webViewDidFinishLoad(_ webView: UIWebView) {
        // インジケータの非表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
