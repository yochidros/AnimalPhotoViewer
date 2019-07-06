//
//  SearchResponse.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public struct SearchResponse: Codable {
  public let totalCount: Int
  public let items: [ImageResponse]
  
  enum CodingKeys: String, CodingKey {
    case totalCount = "totalHits"
    case items = "hits"
  }
}
