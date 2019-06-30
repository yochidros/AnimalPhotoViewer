//
//  SearchResponse.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public struct SearchResponse: Codable {
  let totalCount: Int
  let items: [ItemResponse]
  
  enum CodingKeys: String, CodingKey {
    case totalCount = "totalHits"
    case items = "hits"
  }
}