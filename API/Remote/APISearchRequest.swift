//
//  APISearchRequest.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public class APISearchImageRequest: APIRequest {

  public typealias Response = SearchResponse
  
  let queryParams: [String: String]
  
  init(query: [String: String] = [:]) {
    self.queryParams = query
  }
  
  public var query: [String : String] {
    return self.queryParams
  }
  
}
