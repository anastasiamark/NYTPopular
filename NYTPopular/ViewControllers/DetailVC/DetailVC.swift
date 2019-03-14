//
//  DetaileVC.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/13/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import CoreData
import WebKit

class DetailVC: UIViewController {
    
    var webView: WKWebView!
    var article: Article?
    var articleUrlString: String?
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: View Life Cycle
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorite)), animated: true)
        
        configureWebView()
    }
    
    //MARK: Private Functions
    @objc private func addToFavorite() {
        
        let alert = UIAlertController(title: "Add Article to FAVORITE", message: "Would you like to continue?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { [weak self] action in
            self!.saveArticleToCoreData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveArticleToCoreData() {
        let entity = NSEntityDescription.entity(forEntityName: "SavedArticle", in: context)
        let favoriteArticle = NSManagedObject(entity: entity!, insertInto: context)
        if let article = article {
            favoriteArticle.setValue(article.id, forKey: "id")
            favoriteArticle.setValue(article.title, forKey: "title")
            favoriteArticle.setValue(article.abstract, forKey: "abstract")
            favoriteArticle.setValue(article.author, forKey: "author")
            favoriteArticle.setValue(article.url, forKey: "url")
        }
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    private func loadAddress(_ urlString: String) {
        let url = URL(string: urlString)
        webView.load(URLRequest(url: url!))
    }
    
    private func configureWebView() {
        if let article = article, let string = article.url {
            loadAddress(string)
        } else if let string = articleUrlString {
            loadAddress(string)
        }
    }
}

extension DetailVC: WKNavigationDelegate {

}
