//
//  ItemResponse.swift
//  API
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

public struct ItemResponse: Codable {
  public let id: Int
  public let largeImageURL: String
  public let previewURL: String
  public let previewWidth: CGFloat
  public let previewHeight: CGFloat
  public let imageWidth: CGFloat
  public let imageHeight: CGFloat
}
