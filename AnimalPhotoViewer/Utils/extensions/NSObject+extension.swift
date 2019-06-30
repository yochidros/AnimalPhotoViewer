//
//  NSObject+extension.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

protocol ClassNameProtocol {
  static var className: String { get }
  var className: String { get }
}

extension ClassNameProtocol {
  static var className: String {
    return String(describing: self)
  }
  
  public var className: String {
    return type(of: self).className
  }
}

extension NSObject: ClassNameProtocol {}
