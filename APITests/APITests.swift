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

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testURLSession() {
    let exception = expectation(description: "fetch test")
    let req = APISearchImageRequest(query: ["q": "犬"])
    APIClient.send(request: req, onSuccess: { (response) in
      print(response)
      exception.fulfill()
    }) { (error) in
      print(error)
      XCTAssert(false)
      exception.fulfill()
    }
    wait(for: [exception], timeout: 10)
  }
  
}
