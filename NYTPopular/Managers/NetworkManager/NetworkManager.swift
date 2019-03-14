//
//  NetworkManager.swift
//  NYTPopular
//
//  Created by Anastasia Sokolenko on 3/13/19.
//  Copyright © 2019 Anastasia Sokolenko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

typealias Success = (Array<Article>?) -> Void

typealias Failure = (Int?) -> Void

class NetworkManager: NSObject {

    static let apiKey = "NUPh2IADAIcOizlNGiypFFAwoiaGQ7mr"
    static let baseURL = "https://api.nytimes.com"
    
    struct Endpoints {
        static let emailed = "/svc/mostpopular/v2/emailed/30"
        static let shared = "/svc/mostpopular/v2/shared/30"
        static let viewed = "/svc/mostpopular/v2/viewed/30"
    }
    
    public func fetchEmailedArticles(success: @escaping Success, failure: @escaping Failure) {
        Alamofire.request(NetworkManager.baseURL + Endpoints.emailed, parameters:["api-key":NetworkManager.apiKey]).responseObject {(response: DataResponse<ArticleResponse>) in
            
            let articleResponse = response.result.value
            if let articles = articleResponse?.results {
                success(articles)
            } else {
                failure(response.response?.statusCode)
            }
        }
    }
    
    public func fetchSharedArticles(success: @escaping Success, failure: @escaping Failure) {
        Alamofire.request(NetworkManager.baseURL + Endpoints.shared, parameters:["api-key":NetworkManager.apiKey]).responseObject {(response: DataResponse<ArticleResponse>) in
            
            let articleResponse = response.result.value
            if let articles = articleResponse?.results {
                success(articles)
            } else {
                failure(response.response?.statusCode)
            }
        }
    }
    
    public func fetchViewedArticles(success: @escaping Success, failure: @escaping Failure) {
        Alamofire.request(NetworkManager.baseURL + Endpoints.viewed, parameters:["api-key":NetworkManager.apiKey]).responseObject {(response: DataResponse<ArticleResponse>) in
            
            let articleResponse = response.result.value
            if let articles = articleResponse?.results {
                success(articles)
            } else {
                failure(response.response?.statusCode)
            }
        }
    }
}
