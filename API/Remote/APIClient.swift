//
//  APIRepository.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public class APIClient<Request: APIRequest>: NSObject {
 
  public let session: URLSession = URLSession.shared
  private let json: JSONDecoder = JSONDecoder()

  public override init() {
    super.init()
  }
  
  public static func send(request: Request, onSuccess: @escaping (Request.Response) -> Void, onError: @escaping (Error?) -> Void )  {
    let client = APIClient<Request>()
    print(request.request)
    client.session.dataTask(with: request.request) { (data, response, error) in
      if let data = data, response != nil {
        do {
          let obj = try client.json.decode(Request.Response.self, from: data)
          DispatchQueue.main.async {
            onSuccess(obj)
          }
        } catch let e {
          DispatchQueue.main.async {
            onError(e)
          }
        }
      } else {
        DispatchQueue.main.async {
          onError(error)
        }
      }
    }.resume()
  }
}

