//
//  ViewController.swift
//  RssReaderApp
//
//  Created by 真野友佑 on 2017/10/19.
//  Copyright © 2017年 真野友佑. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pageMenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dev News"
        if let navBar = self.navigationController?.navigationBar {
            navBar.barTintColor = UIColor.black
            navBar.shadowImage = UIImage()
            navBar.tintColor = UIColor.white
            navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gray]
            navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        }
        
        self.pageMenu = createPageMenu(controllers: createFeedControllers());
    }
    func createFeedControllers() -> [UIViewController] {
        let feeds: [Dictionary<String, String>] = [
            [
                "link": "http://menthas.com/top/rss",
                "query": "select * from rss",
                "title": "top"
            ],
            [
                "link": "http://menthas.com/ruby/rss",
                "query": "select * from rss",
                "title": "ruby"
            ],
            [
                "link": "http://menthas.com/javascript/rss",
                "query": "select * from rss",
                "title": "javascript"
            ],
            [
                "link": "http://menthas.com/python/rss",
                "query": "select * from rss",
                "title": "python"
            ],
        ]

        return feeds.map { (item: Dictionary) -> UIViewController in
            let table = TableViewController(
                nibName: "TableViewController",
                bundle: nil)
            table.parentView = self
            table.url = item["link"]
            table.title = item["title"]
            table.query = item["query"]
            return table
        }
    }

    func createPageMenu(controllers: [UIViewController]) -> CAPSPageMenu {
        let params: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.black),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.orange),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 15.0)!),
            .menuHeight(30.0),
            .menuItemWidth(90.0),
            .centerMenuItems(true)
        ]
        let pageMenu = CAPSPageMenu(
            viewControllers: controllers,
            frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height),
            pageMenuOptions: params
        )
        
        self.addChildViewController(pageMenu)
        self.view.addSubview(pageMenu.view)
        pageMenu.didMove(toParentViewController: self)
        
        return pageMenu
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

