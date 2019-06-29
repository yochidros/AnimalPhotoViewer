//
//  APIRequest.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public protocol Request {
  associatedtype Response: Codable
}

public protocol APIRequest: Request {
  var query: [String: String] { get }
}

extension APIRequest {
  

  var baseURL: String {
    return APIURL
  }
  

  var request: URLRequest {
    let url = URL(string: baseURL)!
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: url.baseURL != nil)
    urlComponents?.queryItems = [
      URLQueryItem(name: "key", value: APIKey)
    ]
    query.forEach { (arg) in
      let (key, value) = arg
      urlComponents?.queryItems?.append(URLQueryItem(name: key, value: value))
    }
    
    return URLRequest(url: urlComponents!.url!)
  }
}
