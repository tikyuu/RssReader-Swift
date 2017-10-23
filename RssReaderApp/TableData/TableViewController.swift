
import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    var url: String?
    var query: String?
    var parentView: UIViewController?
    var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(
            UINib(nibName: "FeedTableViewCell", bundle: nil),
            forCellReuseIdentifier: "FeedTableViewCell"
        )
        APIManager.yqlRequest(
            url: self.url!,
            query: self.query!,
            limit: 10,
            success: { (str: Dictionary) -> Void in
                let json = JSON(str)
                let items = json["query"]["results"]["item"]
                if let _items = items.array {
                    for item in _items {
                        self.entries.append(Entry(
                            title: item["title"].string!,
                            desc: item["description"].string, // なくてもよい
                            link: item["link"].string!
                        ))
                    }
                    self.tableView.reloadData()
                }
            },
            fail: { (error: Error?) -> Void in
                print(error!)
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // カウント数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    // 最大値？
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    // 各セルに値を代入していく。
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        let entry = self.entries[indexPath.row]
        if cell.title.text == entry.title {
            return cell
        }
        
        cell.title.text = entry.title
        cell.desc.text = entry.desc
        cell.link = entry.link
        return cell
    }
    // 選択した時 navigationcontrollerにwebview追加
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.entry = self.entries[indexPath.row]
        parentView!.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
}
