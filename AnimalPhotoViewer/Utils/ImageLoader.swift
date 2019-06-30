//
//  ImageLoader.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader: NSObject {
  private static let shared: ImageLoader = ImageLoader()
  
  static func loadImage(url: String, into view: UIImageView?) {
    guard let url = URL(string: url), let v = view else { return }
    v.showLoading()
    shared.load(url: url, view: v)
  }
  
  private func load(url: URL, view: UIImageView) {
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let e = error {
        view.hideLoadingView()
        print(e)
        return
      }
      
      guard let data = data else {
        view.hideLoadingView()
        return
      }
      
      DispatchQueue.main.async {
        [view, data] in
        view.image = UIImage(data: data)
        view.hideLoadingView()
      }
    }.resume()
  }

}
