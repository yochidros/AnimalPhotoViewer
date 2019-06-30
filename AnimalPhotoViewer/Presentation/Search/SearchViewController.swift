//
//  SearchViewController.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchView {
  var presenter: SearchPresentation?
  
  @IBOutlet weak var collectionView: UICollectionView?

  private lazy var searchController: UISearchController = {
      return UISearchController(searchResultsController: nil)
  }()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter = SearchPresenter(view: self)
    self.presenter?.viewDidLoad()
    self.prepareViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter?.viewWillAppear()
  }

  func onReceivedItems() {
    self.collectionView?.reloadData()
  }
  
  private func prepareViews() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = true
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    
    if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      let margin: CGFloat = 16
      layout.minimumLineSpacing = margin
      layout.minimumInteritemSpacing = margin
      layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
      self.collectionView?.collectionViewLayout = layout
    }
    self.collectionView?.register(UINib(nibName: SearchListCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: SearchListCollectionViewCell.className)
    self.collectionView?.dataSource = self.presenter?.dataSource
    self.collectionView?.delegate = self.presenter?.collectionDelegate
  }

}
extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
//    if let text = searchController.searchBar.text, !text.isEmpty {
//        self.presenter?.searchImages(searchText: text)
//    }
  }
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchController.searchBar.text, !text.isEmpty {
      self.presenter?.searchImages(searchText: text)
    }
  }
}
