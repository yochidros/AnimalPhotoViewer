//
//  APITests.swift
//  APITests
//
//  Created by yochidros on 2019/06/29.
//  Copyright © 2019 yochidros. All rights reserved.
//

import XCTest
@testable import API

class APITests: XCTestCase {
    
    private let searchException: XCTestExpectation = XCTestExpectation(description: "fetch api test")
    private let repository: SearchRepository = APISearchRepository()
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testAPIClinetSearch() {
        let req = APISearchImageRequest()
        APIClient.send(request: req) { [searchException] result in
            switch result {
            case .success(let response):
                print(response)
                searchException.fulfill()
            case .failure(let error):
                print(error)
                XCTAssert(false)
                searchException.fulfill()
            }
        }
        wait(for: [searchException], timeout: 1)
    }
    
    func testAPIClientSearchWithQuery() {
        let req = APISearchImageRequest(["q": "dog"])
        APIClient.send(request: req) { [searchException] result in
            switch result {
            case .success(let response):
                dump(response)
                searchException.fulfill()
            case .failure(let error):
                print(error)
                XCTAssert(false)
                searchException.fulfill()
            }
        }
        wait(for: [searchException], timeout: 1)
    }
    
    func testAPISearchRepository() {
        repository.search(next: false, params: nil, onSuccess: { [searchException] (response) in
            dump(response)
            searchException.fulfill()
        }) { [searchException] (error) in
            dump(error)
            XCTAssert(false)
            searchException.fulfill()
        }
        
        wait(for: [searchException], timeout: 1)
    }
    

}
