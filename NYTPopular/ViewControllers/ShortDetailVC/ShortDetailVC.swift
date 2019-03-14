//
//  ShortDetailVC.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/14/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import UIKit

class ShortDetailVC: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    var article: Article?
    @IBOutlet weak var abstractTextView: UITextView!
    @IBOutlet weak var authorTextView: UITextView!
    
    var articleTitle = ""
    var articleAbstract = ""
    var articleAuthor = ""
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
    }
 
    //MARK: Private Functions
    private func configureVC() {
        guard let article = article else {
            titleTextView.text = articleTitle
            abstractTextView.text = articleAbstract
            authorTextView.text = articleAuthor
            return
        }
        titleTextView.text = article.title
        abstractTextView.text = article.abstract
        authorTextView.text = article.author
    }
}
