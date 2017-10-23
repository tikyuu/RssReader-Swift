
import Alamofire
import HTMLReader

class APIManager {
    class func test_request() {
        APIManager.yqlRequest(
            url: "http://d.hatena.ne.jp/nitoyon/rss",
            query: "select title from rss",
            success: { (data: Dictionary) in print(data) },
            fail: { (error: Error?) in print(error!) }
        )
    }

    // rssデータからjsonへの変換
    // https://qiita.com/tmf16/items/d2f13088dd089b6bb3e4
    // https://qiita.com/mishimay/items/1232dbfe8208e77ed10e
    class func yqlRequest(
        url: String,
        query: String,
        limit: Int = 0,
        success: @escaping (_ data: Dictionary<String, Any>) -> Void,
        fail: @escaping (_ error: Error?) -> Void) {
        
        let host = "https://query.yahooapis.com/v1/public/yql"
        let limit_query = (limit == 0) ? "" : "limit \(limit)"
        
        let param: Parameters = [
            "format": "json",
            "q": "\(query) where url='\(url)' \(limit_query)"
        ]
        
        Alamofire.request(host, method: .get, parameters: param).responseJSON { response in
            if response.result.isSuccess {
                success(response.result.value as! Dictionary)
            } else {
                fail(response.result.error)
            }
        }
    }

    // ["og:image": "http://image.png"]
    class func ogRequest(
        url: String,
        success: @escaping (_ data: Dictionary<String, String>) -> Void,
        fail: @escaping(_ error: Error?) -> Void) {
        
        Alamofire.request(url, method: .get).responseString { response in
            if response.result.isFailure {
                print(response.result.error!)
                return
            }
            
            let html = HTMLDocument(string: response.result.value!)
            
            let ogTags:[HTMLElement] = html.nodes(matchingSelector: "meta[property^=\"og:\"]")
                
            var dict = Dictionary<String, String>()
            ogTags.forEach {
                let property = $0.attributes["property"]!
                let content = $0.attributes["content"]!
                dict[property] = content
            }
                
            success(dict)
        }
        
    }
}
