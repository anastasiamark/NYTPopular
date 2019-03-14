//
//  DetaileVC.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/13/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var article: Article?
    let progressHUD = ProgressHUD(text: "Loading")
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorite)), animated: true)
        webView.delegate = self
        loadAddress()
    }
    
    //MARK: Private Functions
    @objc private func addToFavorite() {
        
        let alert = UIAlertController(title: "Add Article to FAVORITE", message: "Would you like to continue?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
            
            
            
            print("Add to FAVORITE")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loadAddress() {
        guard let article = article, let string = article.url else {
            return
        }
        let url = URL(string: string)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
}

extension DetailVC: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        webView.addSubview(progressHUD)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        progressHUD.removeFromSuperview()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        progressHUD.removeFromSuperview()

    }
}
