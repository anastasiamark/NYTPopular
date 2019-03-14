//
//  Article.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/13/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleResponse: Mappable {
    var copyright: String?
    var results: [Article]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        copyright <- map["copyright"]
        results <- map["results"]
    }
}

class Article: Mappable {
    var title: String?
    var id: Int?
    var url: String?
    var abstract: String?
    var author: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        id <- map["id"]
        url <- map["url"]
        abstract <- map["abstract"]
        author <- map["byline"]
    }
}

