
import Alamofire


class Yql {
    class func test_request() {
        Yql.request(
            url: "http://d.hatena.ne.jp/nitoyon/rss",
            query: "select title from rss",
            success: { (data: Dictionary) in print(data) },
            fail: { (error: Error?) in print(error!) }
        )
    }

    // https://qiita.com/tmf16/items/d2f13088dd089b6bb3e4
    // https://qiita.com/mishimay/items/1232dbfe8208e77ed10e
    class func request(
        url: String,
        query: String,
        limit: Int = 0,
        success: @escaping (_ data: Dictionary<String, Any>) -> Void,
        fail: @escaping (_ error: Error?) -> Void) {
        
        let host = "https://query.yahooapis.com/v1/public/yql"
        // let _url = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
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
    
    class func stringRequest(
        url: String,
        success: @escaping (_ data: Dictionary<String,String>) -> Void,
        fail: @escaping (_ error: Error?) -> Void) {
        
        Alamofire.request("url", method: .get, parameters: nil).responseJSON { response in
            if response.result.isSuccess {
                success(response.result.value as! Dictionary)
            } else {
                fail(response.result.error)
            }
        }
    }
}
