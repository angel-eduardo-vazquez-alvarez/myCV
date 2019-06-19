//
//  GetMainInformationImplementation.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Concrete implementation for the `GetMainInformation` protocol.
class GetMainInformationImplementation: UseCaseProtocol, GetMainInformation {
    
    /// Fetching service
    var service: FetchService
    
    /// Repository to store data
    var repository: DataRepository
    
    /// - Parameter service: An object that conforms to the `FetchService` protocol.
    /// - Parameter repository: An object that conforms to the `DataRepository` protocol.
    required init(service: FetchService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }
    
    /// Starts the download of information from the Internet relying on its `FetchService`.
    /// - Parameter completionHandler: Closure to handle the information after it has been fetched.
    func download(_ completionHandler: @escaping (DownloadResult) -> Void) {
        service.retrieveInfo(using: URLSession.shared) { response in
            switch response {
            case .success(let information):
                let isSaved = self.repository.save(information: information)
                if isSaved {
                    completionHandler(.success)
                } else {
                    completionHandler(.failure(error: .unknown))
                }
                break
            case .failure:
                completionHandler(.failure(error: .unknown))
                break
            case .notConnected:
                completionHandler(.failure(error: .notConnected))
                break
            }
        }
    }
}
