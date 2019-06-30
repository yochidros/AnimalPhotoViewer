//
//  SearchRepository.swift
//  API
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public protocol SearchRepository {
  func search(params: [String: String]?, onSuccess: @escaping (SearchResponse) -> Void, onError: @escaping (Error?) -> Void)
}

public class APISearchRepository: SearchRepository {
  
  public init() {
  }
  
  public func search(params: [String : String]?, onSuccess: @escaping (SearchResponse) -> Void, onError: @escaping (Error?) -> Void) {
    let request = APISearchImageRequest(params ?? [:])
    APIClient.send(request: request) {
      [onSuccess, onError] (result) in
      switch result {
      case .success(let response):
        onSuccess(response)
      case .failure(let error):
        onError(error)
      }
    }
  }
}
