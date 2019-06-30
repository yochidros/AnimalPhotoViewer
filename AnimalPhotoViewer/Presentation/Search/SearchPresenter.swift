//
//  SearchPresenter.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation
import API

protocol BasePresentation {
  func viewDidLoad()
  func viewWillAppear()
  func viewDidAppear()
  func viewWillDisappear()
  func viewDidDisappear()
}

protocol SearchView {
  var presenter: SearchPresentation? { get }
  
  func onReceivedItems()
}

protocol SearchPresentation: BasePresentation{
  var view: SearchView { get }
  var dataSource: UICollectionViewDataSource? { get }
  var collectionDelegate: UICollectionViewDelegate? { get }
  func searchImages(searchText: String?)
  func nextLoad()
}

final class SearchPresenter: NSObject, SearchPresentation {
  var dataSource: UICollectionViewDataSource?
  var collectionDelegate: UICollectionViewDelegate?
  
  var view: SearchView
  let respository: SearchRepository
  
  private var images: [ItemResponse] = []
  private var searchText: String?
  private var isLoading: Bool = true
  
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
    self.searchImages(searchText: nil)
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
    self.respository.search(
      next: false,
      params: (searchText != nil) ? ["q": searchText ?? ""] : nil,
      onSuccess: { [self] (response) in
        self.images = response.items
        self.isLoading = false
      DispatchQueue.main.async { [weak self] in
        self?.view.onReceivedItems()
      }
    }) { (error) in
      print(error ?? "error")
    }
  }
  
  func nextLoad() {
    self.isLoading = true
    self.respository.search(
      next: true,
      params: (self.searchText != nil) ? ["q": self.searchText ?? ""] : nil,
      onSuccess: { [self] (response) in
        self.images.append(contentsOf: response.items)
        self.isLoading = false
        DispatchQueue.main.async { [weak self] in
          self?.view.onReceivedItems()
        }
    }) { (error) in
      print(error ?? "error")
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
    let item = self.images[indexPath.row]
    if let c = cell as? SearchListCollectionViewCell {
      c.configure(imageURL: item.previewURL)
    }
    return cell
  }
  
}
