//
//  UseCaseLocator.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Abstraction for a Service Locator that provides centralized access from anywhere in the app
/// to the use cases. Using a protocol allows mocking for easier testing.
protocol UseCaseLocatorProtocol {
    func getUseCase<C>(of type: C.Type) -> C?
}

/// Implementation for the `UseCaseLocatorProtocol`.
class UseCaseLocator: UseCaseLocatorProtocol {
    /// Singleton to access all uses cases.
    static let main = UseCaseLocator(service: GistFetchService(), repository: InMemoryDataRepository())
    
    /// The repository to store data to be used with this Service Locator and its use cases.
    fileprivate let repository: DataRepository
    
    /// The `FetchService` to be used with this Service Locator and its use cases.
    fileprivate let service: FetchService
    
    /// Initializes the Service Locator with a `FetchService` and `DataRepository` implementations.
    init(service: FetchService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }
    
    /// Returns an concrete implementation of a `UseCaseImplementation`.
    /// - Parameter type: The type for the use case to be resolved.
    /// - Returns: A `UseCaseImplementation` instance.
    func getUseCase<Case>(of type: Case.Type) -> Case? {
        switch String(describing: type){
        case String(describing: GetMainInformation.self):
            return buildUseCase(forType: GetMainInformationImplementation.self)
        case String(describing: ShowCurriculum.self):
            return buildUseCase(forType: ShowCurriculumImplementation.self)
        default:
            return nil
        }
    }
    
    /// Creates an instance of the `UseCaseImplementation` that is being resolved from
    /// this Service Locator.
    private func buildUseCase<Implementation: UseCaseProtocol, Case>(forType type: Implementation.Type) -> Case? {
        return Implementation(service: service, repository: repository) as? Case
    }
}
