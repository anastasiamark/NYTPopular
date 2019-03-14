//
//  FavoriteArticleListVC.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/13/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import UIKit
import CoreData

class FavoriteArticleListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [NSManagedObject] = []
    
    private let articleCellReuseIdentifier = String(describing: ArticleTableViewCell.self)
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //MARK: View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchArticlesFromCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: articleCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: articleCellReuseIdentifier)
    }
    
    //MARK: Private Functions
    private func fetchArticlesFromCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedArticle")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            articles = result as! [NSManagedObject]
        } catch {
            print("Failed")
        }
        tableView.reloadData()
    }
}

extension FavoriteArticleListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellReuseIdentifier, for: indexPath) as! ArticleTableViewCell
        let article = articles[indexPath.row]
        let title = article.value(forKey: "title") as! String
        cell.configureCell(title)
        
        return cell
    }
}

extension FavoriteArticleListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC {
            
            let savedArticle = articles[indexPath.row]
            let urlSrting = savedArticle.value(forKey: "url") as! String
            
            vc.articleUrlString = urlSrting
            vc.navigationItem.title = "Detail"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: ShortDetailVC.self)) as? ShortDetailVC {
            vc.navigationItem.title = "Short Detail"
            
            let savedArticle = articles[indexPath.row]
            let title = savedArticle.value(forKey: "title") as! String
            let abstract = savedArticle.value(forKey: "abstract") as! String
            let author = savedArticle.value(forKey: "author") as! String
            vc.articleTitle = title
            vc.articleAuthor = author
            vc.articleAbstract = abstract
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
