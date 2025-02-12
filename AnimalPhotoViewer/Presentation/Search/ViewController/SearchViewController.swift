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
  @IBOutlet weak var textLabel: UILabel?

  private lazy var searchController: UISearchController = {
	let search = UISearchController(searchResultsController: nil)
	search.searchBar.placeholder = "name"
	return search
  }()
	
	private lazy var refreshControl: UIRefreshControl = {
		let control = UIRefreshControl()
		control.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		return control
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

  func onReceivedItems(count: Int) {
    self.view.hideLoadingView()
    if count == 0 {
      self.textLabel?.isHidden = false
    } else {
      self.textLabel?.isHidden = true
    }
    self.collectionView?.reloadData()
  }
  
  private func prepareViews() {
	definesPresentationContext = true
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = true
	searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false

	if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      let margin: CGFloat = 16
      layout.minimumLineSpacing = margin
      layout.minimumInteritemSpacing = margin
      layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
      self.collectionView?.collectionViewLayout = layout
    }
	self.collectionView?.addSubview(refreshControl)
	self.collectionView?.keyboardDismissMode = .onDrag
	self.collectionView?.contentInsetAdjustmentBehavior = .scrollableAxes
    self.collectionView?.register(UINib(nibName: SearchListCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: SearchListCollectionViewCell.className)
    self.collectionView?.dataSource = self.presenter?.dataSource
    self.collectionView?.delegate = self.presenter?.collectionDelegate
    self.view.showLoading()
  }

	@objc func refresh(sender: UIRefreshControl) {
		self.searchController.searchBar.text = ""
		self.presenter?.searchImages(searchText: nil)
		self.refreshControl.endRefreshing()
	}
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchController.searchBar.text, !text.isEmpty {
      self.presenter?.searchImages(searchText: text)
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.presenter?.searchImages(searchText: nil)
  }
}
