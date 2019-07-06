//
//  BasePresentation.swift
//  AnimalPhotoViewer
//
//  Created by yochidros on 2019/07/06.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation
protocol BasePresentation {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}
