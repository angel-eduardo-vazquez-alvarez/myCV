//
//  MockFetchService.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
@testable import MyCV

class MockFetchService: FetchService {
    
    static let endpoint = "info.json"
    
    func retrieveInfo(using session: URLSessionProtocol, completionHandler: @escaping (FetchServiceResponse) -> Void) {
        guard let url = URL(string: MockFetchService.endpoint) else {
            completionHandler(.failure(error: NetworkError.unknown))
            return
        }
        
        let _ = session.dataTask(with: url) { data, urlResponse, error in
            guard let urlResponse = urlResponse as? HTTPURLResponse, let data = data else {
                if let error = error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    completionHandler(.notConnected)
                } else {
                    completionHandler(.failure(error: NetworkError.unknown))
                }
                return
            }
            
            switch urlResponse.statusCode {
            case (200 ..< 300):
                if let applicationData = MockFetchService.parse(data: data) {
                    completionHandler(.success(info: applicationData))
                } else {
                    completionHandler(.failure(error: NetworkError.unknown))
                }
            case NSURLErrorNotConnectedToInternet:
                completionHandler(.notConnected)
            default:
                completionHandler(.failure(error: NetworkError.unknown))
            }
        }
    }
}

// MARK: Parsing
extension MockFetchService {
    static func parse(data: Data) -> ApplicationData? {
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(MockApplicationData.self, from: data)
    }
}
