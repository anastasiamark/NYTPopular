//
//  EmailedArticleListVC.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/13/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import UIKit

class EmailedArticleListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let networkManager = NetworkManager()
    
    var articles: [Article] = []
    
    private let articleCellReuseIdentifier = String(describing: ArticleTableViewCell.self)
    
    //MARK: View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchArticles()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: articleCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: articleCellReuseIdentifier)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

    }
    
    //MARK: Private Functions
    private func fetchArticles() {
        
        self.networkManager.fetchEmailedArticles(success: {[weak self] articles in
            if let articles = articles {
                self!.articles = articles
            }
            DispatchQueue.main.async {
                self!.tableView.reloadData()
            }
        }) { responseStatusCode in
            if let statusCode = responseStatusCode {
                print(statusCode)
            }
        }
    }
}

extension EmailedArticleListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellReuseIdentifier, for: indexPath) as! ArticleTableViewCell
        cell.configureCell(articles[indexPath.row].title)
        
        return cell
    }
}

extension EmailedArticleListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC {
            vc.article = articles[indexPath.row]
            vc.navigationItem.title = "Detail"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: ShortDetailVC.self)) as? ShortDetailVC {
            vc.navigationItem.title = "Short Detail"
            vc.article = articles[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
