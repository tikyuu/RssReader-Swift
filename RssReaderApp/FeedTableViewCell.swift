import UIKit
import SDWebImage

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var thumbnailView: UIImageView!
    
    let api = "http://api.hitonobetsu.com/ogp/analysis?url="
    // let api = "http://140note.hitonobetsu.com/apipage/ogp?url="
    var link: String! {
        didSet {
            // OGP失敗しまくりなので適当な画像を貼り付け。
            self.setThumbnailImageView(imageUrl: URL(string: "https://cdn-ak.f.st-hatena.com/images/fotolife/i/ie-kau/20151120/20151120074851.png"))
            /*
            Yql.stringRequest(
                url: "\(api)'\(link!)'",
                url: url,
                success: { (response: Dictionary<String, String>) -> Void in
                    print(response)
                    if let imageUrl = response["image"] {
                        self.setThumbnailImageView(imageUrl: URL(string: imageUrl))
                    }
                },
                fail: { (error: Error?) -> Void in
                    print(error!)
                }
            )
 */
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setThumbnailImageView(imageUrl: URL?) {
        self.thumbnailView.sd_setImage(with: imageUrl) { (image, error, cacheType, url) -> Void in
            UIView.animate(withDuration: 0.25) {
                self.thumbnailView.alpha = 1
                self.indicator.stopAnimating()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
