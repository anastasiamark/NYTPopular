//
//  ArticleTableViewCell.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/13/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    //MARK: Cell Configuration Method
    func configureCell(_ labelText: String?) {
        if let text = labelText {
            label.text = text
        }
    }
    
}
