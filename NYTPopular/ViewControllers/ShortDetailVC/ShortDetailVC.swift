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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
    }
 
    //MARK: Private Functions
    private func configureVC() {
        guard let article = article else {
            return
        }
        titleTextView.text = article.title
        abstractTextView.text = article.abstract
        authorTextView.text = article.author
    }
}
