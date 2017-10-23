import UIKit
import SDWebImage

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var thumbnailView: UIImageView!

    var link: String! {
        didSet {
            APIManager.ogRequest(
                url: link,
                success: { (data) -> Void in
                    if let imageUrl = data["og:image"] {
                        self.setThumbnailImageView(imageUrl: URL(string: imageUrl))
                    } else {
                        self.setThumbnailImageView(imageUrl: URL(string: "http://placehold.jp/70x70.png?text=no%20image"))
                    }
                },
                fail: { (error) -> Void in
                    print(error!)
                }
            )
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setThumbnailImageView(imageUrl: URL?) {
        self.thumbnailView.sd_setImage(with: imageUrl) { (image, error, cacheType, url) -> Void in
            UIView.animate(withDuration: 0.25) {
                // https://ja.stackoverflow.com/questions/27845/uitableview%E3%81%AE%E3%82%BB%E3%83%AB%E3%81%8C%E5%86%8D%E5%88%A9%E7%94%A8%E3%81%95%E3%82%8C%E3%82%8B%E9%9A%9B%E3%81%AB%E5%89%8D%E3%81%AE%E7%94%BB%E5%83%8F%E3%81%AA%E3%81%A9%E3%81%8C%E6%AE%8B%E3%81%A3%E3%81%A6%E3%81%97%E3%81%BE%E3%81%86%E5%A0%B4%E5%90%88%E3%81%AE%E5%AF%BE%E5%87%A6
                if imageUrl! == url! {
                    self.thumbnailView.alpha = 1
                    self.indicator.stopAnimating()
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
