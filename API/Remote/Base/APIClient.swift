//
//  APIRepository.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

final class APIClient<Request: APIRequest>: NSObject {
 
  private let session: URLSession = URLSession.shared
  private let json: JSONDecoder = JSONDecoder()

  override init() {
    super.init()
  }
  
  static func send(request: Request, onResult: @escaping (Result<Request.Response, Error>) -> Void)  {
    let client = APIClient<Request>()
    #if DEBUG
    print(#file, #line, request.request)
    #endif
    client.session.dataTask(with: request.request) { (data, response, error) in
      if let data = data, response != nil {
        do {
          let obj = try client.json.decode(Request.Response.self, from: data)
          onResult(Result.success(obj))
        } catch let e {
          onResult(Result.failure(e))
        }
      } else {
        if let err = error {
          onResult(Result.failure(err))
        }
      }
    }.resume()
  }
}

