//
//  ItemResponse.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public struct ItemResponse: Codable {
  let id: Int
  let largeImageURL: String
  let previewURL: String
}
