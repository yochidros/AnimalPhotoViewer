//
//  Util.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation

class Utils {
  static var isJapanese: Bool {
    let codes = Locale.preferredLanguages
    guard codes.count != 0 else { return false }
    let lang = codes[0]
    return lang.prefix(2) == "ja"
  }
  
}
