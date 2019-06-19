//
//  MockURLSessionProtocol.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
@testable import MyCV

// This is a dummy. It doesn't do anything other than satisfy the need for dataTask to return something.
class DataTaskMock: URLSessionDataTask {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler
    var resumeWasCalled = false
    
    // Stash away the completion handler so we can call it later.
    init(completionHandler: @escaping CompletionHandler) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        resumeWasCalled = true
    }
}

class MockURLSession: URLSessionProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    @discardableResult func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        defer { completionHandler(data, response, error) }
        return DataTaskMock(completionHandler: completionHandler)
    }
}
