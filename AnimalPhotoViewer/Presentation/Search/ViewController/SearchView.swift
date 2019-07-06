//
//  SearchView.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/07/06.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation
protocol SearchView {
    var presenter: SearchPresentation? { get }
    
    func onReceivedItems(count: Int)
}
