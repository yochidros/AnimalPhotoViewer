//
//  SearchPresentation.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/07/06.
//  Copyright © 2019 yochidros. All rights reserved.
//

import UIKit

protocol SearchPresentation: BasePresentation{
    var view: SearchView { get }
    var dataSource: UICollectionViewDataSource? { get }
    var collectionDelegate: UICollectionViewDelegate? { get }
    func searchImages(searchText: String?)
    func nextLoad()
}
