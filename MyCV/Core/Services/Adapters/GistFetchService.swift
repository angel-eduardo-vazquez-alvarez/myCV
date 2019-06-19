//
//  GistFetchService.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Implementation of the `FetchService` protocol that fetches information
/// from GitHub Gist.
struct GistFetchService: FetchService {
    
    /// Endpoint from where to fetch information.
    static let endpoint = "https://gist.githubusercontent.com/angel-eduardo-vazquez-alvarez/2210afefe2f1d4b7bd02132605ceadea/raw/c0688b78db02969ba85501541dc210d38c632503/info.json"
    
    /// Method that fetches information from GitHub Gist and handles possible errors.
    /// - Parameter session: An implementation that conforms to the `URLSessionProtocol`
    /// - Parameter completionHandler: Closure to handle the data after it has been fetched.
    /// - Parameter response: Possible values: `.failure`, `.notConnected`, `success(let info)`.
    func retrieveInfo(using session: URLSessionProtocol, completionHandler: @escaping (_ response: FetchServiceResponse) -> Void) {
        guard let url = URL(string: GistFetchService.endpoint) else {
            completionHandler(.failure(error: NetworkError.unknown))
            return
        }

        let dataTask = session.dataTask(with: url) { data, urlResponse, error in
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
                if let applicationData = GistFetchService.parse(data: data) {
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
        
        dataTask.resume()
    }
}

// MARK: Parsing
private extension GistFetchService {
    /// Helper function that parses the fetched `data` into an instance that conforms
    /// to the `ApplicationData` protocol.
    /// - Parameter data: The data to be parsed into an `ApplicationData` implementation.
    static func parse(data: Data) -> ApplicationData? {
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(RawApplicationData.self, from: data)
    }
}
