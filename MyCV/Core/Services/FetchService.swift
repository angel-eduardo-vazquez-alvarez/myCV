//
//  FetchService.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Represents a network error.
enum NetworkError: Error {
    case unknown
}

/// Represents the possible states for service that
/// fetches content from the Internet.
enum FetchServiceResponse: CustomStringConvertible {
    case failure(error: Error)
    case notConnected
    case success(info: ApplicationData)
    
    var description: String {
        switch self {
        case .failure:
            return "failure"
        case .notConnected:
            return "notConnected"
        default:
            return "success"
        }
    }
}

/// Protocol that all Fetch Services implementations must conform.
/// A protocol allows for the service to be mocked to allow easier testing.
protocol FetchService {
    /// Method that fetches content from the internet and wraps it inside the `FetchServiceResponse`
    /// enumeration when successful.
    /// - Parameter session: An implementation that conforms to the `URLSessionProtocol`.
    /// - Parameter completionHandler: Closure to handle the data after it has been fetched.
    /// - Parameter response: Possible values: `.failure`, `.notConnected`, `success(let info)`.
    func retrieveInfo(using session: URLSessionProtocol, completionHandler: @escaping (_ response: FetchServiceResponse) -> Void)
}
