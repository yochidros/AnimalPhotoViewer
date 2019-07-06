//
//  SearchRepository.swift
//  API
//
//  Created by yochidros on 2019/06/30.
//  Copyright © 2019 yochidros. All rights reserved.
//

import Foundation
import Models

public protocol SearchRepository {
    func search(params: [String: String]?, onSuccess: @escaping (SearchResponse) -> Void, onError: @escaping (Error?) -> Void)
    func searchNext(params: [String: String]?, onSuccess: @escaping (SearchResponse) -> Void, onError: @escaping (Error?) -> Void)
}

public class APISearchRepository: SearchRepository {
    public var hasNext: Bool {
        return self.totalPage > self.currentPage
    }
    
    private var totalPage: Int = 1
    private var currentPage: Int = 0
    
    public init() {
    }
    
    public func search(params: [String : String]?, onSuccess: @escaping (SearchResponse) -> Void, onError: @escaping (Error?) -> Void) {
        self.currentPage = 1
        var queries: [String: String] = params ?? [:]
        queries["page"] = "\(currentPage)"
        let request = APISearchImageRequest(queries)
        APIClient.send(request: request) {
            [onSuccess, onError] (result) in
            switch result {
            case .success(let response):
                self.totalPage = Int(round(Double(response.totalCount) / Double(20)))
                onSuccess(response)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    public func searchNext(params: [String : String]?, onSuccess: @escaping (SearchResponse) -> Void, onError: @escaping (Error?) -> Void) {
        if hasNext {
            self.currentPage += 1
        } else {
            return
        }
        var queries: [String: String] = params ?? [:]
        queries["page"] = "\(currentPage)"
        let request = APISearchImageRequest(queries)
        APIClient.send(request: request) {
            [onSuccess, onError] (result) in
            switch result {
            case .success(let response):
                self.totalPage = Int(round(Double(response.totalCount) / Double(20)))
                onSuccess(response)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
