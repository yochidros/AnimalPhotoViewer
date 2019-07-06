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
	
	private let cached: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
	
	static func loadImage(url: String, into view: UIImageView?) {
		guard let url = URL(string: url), let v = view else { return }
		v.showLoading()
		shared.load(url: url, view: v)
	}
	
	private func load(url: URL, view: UIImageView) {
		if let cachedImage = cached.object(forKey: url.absoluteString as NSString) {
			view.image = cachedImage
			view.hideLoadingView()
			return
		}
		URLSession.shared.dataTask(with: url) { [view, url, weak self] (data, _, error) in
			if error != nil {
				view.hideLoadingView()
				return
			}
			
			guard let data = data, let image = UIImage(data: data) else {
				view.hideLoadingView()
				return
			}
			self?.cached.setObject(image, forKey: url.absoluteString as NSString)
			
			DispatchQueue.main.async {
				[view, image] in
				view.image = image
				view.hideLoadingView()
			}
			}.resume()
	}
	
}
