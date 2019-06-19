//
//  GetMainInformationMock.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
@testable import MyCV

class GetMainInformationSuccessMock: UseCaseProtocol, GetMainInformation {
    var service: FetchService
    var repository: DataRepository

    required init(service: FetchService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }
    
    func download(_ completionHandler: @escaping (DownloadResult) -> Void) {
        completionHandler(.success)
    }
}

class GetMainInformationFailureUnknownMock: UseCaseProtocol, GetMainInformation {
    var service: FetchService
    var repository: DataRepository
    
    required init(service: FetchService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }
    
    func download(_ completionHandler: @escaping (DownloadResult) -> Void) {
        completionHandler(.failure(error: .unknown))
    }
}

class GetMainInformationFailureNotConnectedMock: UseCaseProtocol, GetMainInformation {
    var service: FetchService
    var repository: DataRepository
    
    required init(service: FetchService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }
    
    func download(_ completionHandler: @escaping (DownloadResult) -> Void) {
        completionHandler(.failure(error: .notConnected))
    }
}
