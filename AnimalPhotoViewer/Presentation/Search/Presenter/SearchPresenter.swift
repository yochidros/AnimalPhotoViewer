//
//  SearchPresenter.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation
import Models
import API


final class SearchPresenter: NSObject, SearchPresentation {
	var dataSource: UICollectionViewDataSource?
	var collectionDelegate: UICollectionViewDelegate?
	
	var view: SearchView
	let respository: SearchRepository
	
	private var images: [ImageResponse] = []
	private var searchText: String?
	private var isLoading: Bool = true
	
	private lazy var fetchImagesIfNeeds: Bool? = {
		self.searchImages(searchText: nil)
		return nil
	}()
	
	init(view: SearchView) {
		self.view = view
		self.respository = APISearchRepository()
		super.init()
		self.dataSource = self
		self.collectionDelegate = self
	}
	
	// Life cycle view
	func viewDidLoad() {
	}
	
	func viewWillAppear() {
		guard fetchImagesIfNeeds == nil else {
			return
		}
	}
	
	func viewDidAppear() {
	}
	
	func viewWillDisappear() {
	}
	func viewDidDisappear() {
	}
	
	func searchImages(searchText: String?) {
		self.searchText = searchText
		self.images = []
		self.isLoading = true
		var params: [String: String] = [:]
		if Utils.isJapanese {
			params["lang"] = "ja"
			params["q"] = (searchText != nil) ? "動物+\(searchText!)" : "動物"
		} else {
			if let code = NSLocale.current.languageCode {
				params["lang"] = code
			}
			params["q"] = (searchText != nil) ? "animal+\(searchText!)" : "animal"
		}
		self.respository.search(
			params: params,
			onSuccess: { [self] (response) in
				self.images = response.items
				self.isLoading = false
				DispatchQueue.main.async { [weak self] in
					self?.view.onReceivedItems(count: self?.images.count ?? 0)
				}
		}) { (error) in
			print(error ?? "error")
			DispatchQueue.main.async {
				[weak self] in
				self?.view.onReceivedItems(count: 0)
			}
		}
	}
	
	func nextLoad() {
		self.isLoading = true
		var params: [String: String] = [:]
		if Utils.isJapanese {
			params["lang"] = "ja"
			params["q"] = (searchText != nil) ? "動物+\(searchText!)" : "動物"
		} else {
			if let code = NSLocale.current.languageCode {
				params["lang"] = code
			}
			params["q"] = (searchText != nil) ? "animal+\(searchText!)" : "animal"
		}
		self.respository.searchNext(
			params: params,
			onSuccess: { [self] (response) in
				self.images.append(contentsOf: response.items)
				self.isLoading = false
				DispatchQueue.main.async { [weak self] in
					self?.view.onReceivedItems(count: self?.images.count ?? 0)
				}
		}) { [weak self] (error) in
			print(error ?? "error")
			DispatchQueue.main.async {
				[weak self] in
				self?.view.onReceivedItems(count: 0)
			}
			
		}
	}
}

extension SearchPresenter: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		guard self.images.count > 0 else {
			return .zero
		}
		let image = self.images[indexPath.row]
		return CGSize(width: image.previewWidth, height: image.previewHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let image = self.images[indexPath.row]
		let view = PreviewViewController(image: image)
		(self.view as? UIViewController)?.navigationController?.pushViewController(view, animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.row == images.count - 2, !isLoading{
			self.isLoading = true
			self.nextLoad()
		}
	}
}

extension SearchPresenter: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchListCollectionViewCell.className, for: indexPath)
		if let c = cell as? SearchListCollectionViewCell, images.count != 0 {
			let item = self.images[indexPath.row]
			c.configure(imageURL: item.previewURL)
		}
		return cell
	}
	
}
