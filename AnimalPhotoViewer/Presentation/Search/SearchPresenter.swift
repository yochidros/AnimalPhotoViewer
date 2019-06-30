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
  func searchImages()
}

final class SearchPresenter: NSObject, SearchPresentation {
  var dataSource: UICollectionViewDataSource?
  var collectionDelegate: UICollectionViewDelegate?
  
  var view: SearchView
  let respository: SearchRepository
  
  private var images: [ItemResponse] = []
  
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
    self.searchImages()
  }
  
  func viewDidAppear() {
  }
  
  func viewWillDisappear() {
  }
  func viewDidDisappear() {
  }
  
  func searchImages() {
    self.respository.search(params: nil, onSuccess: { [self] (response) in
      self.images.append(contentsOf: response.items)
      self.view.onReceivedItems()
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
    dump(image)
    return CGSize(width: image.previewWidth, height: image.previewHeight)
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
