//
//  APISearchRequest.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

final class APISearchImageRequest: APIRequest {

  typealias Response = SearchResponse
  
  let queryParams: [String: String]
  
  init(_ query: [String: String] = [:]) {
    self.queryParams = query
  }
  
  var query: [String : String] {
    return self.queryParams
  }
  
}
