//
//  CaseLocatorMock.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
@testable import MyCV

class UseCaseLocatorMock: UseCaseLocatorProtocol {
    static let main = UseCaseLocator(service: MockFetchService(), repository: MockInMemoryDataRepository(information: RawApplicationData.makeEmpty()))
    
    fileprivate let repository: DataRepository
    fileprivate let service: FetchService
    
    enum GetInformationType {
        case success
        case failure
        case notConnected
    }
    var informationType: GetInformationType = .success
    
    init(service: FetchService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }
    
    func getUseCase<Case>(of type: Case.Type) -> Case? {
        switch String(describing: type){
        case String(describing: GetMainInformation.self):
            switch informationType {
            case .failure:
                return buildUseCase(forType: GetMainInformationFailureUnknownMock.self)
            case .success:
                return buildUseCase(forType: GetMainInformationSuccessMock.self)
            case .notConnected:
                return buildUseCase(forType: GetMainInformationFailureNotConnectedMock.self)
            }
        case String(describing: ShowCurriculum.self):
            return buildUseCase(forType: ShowCurriculumMock.self)
        default:
            return nil
        }
    }
    
    private func buildUseCase<Implementation: UseCaseProtocol, Case>(forType type: Implementation.Type) -> Case? {
        return Implementation(service: service, repository: repository) as? Case
    }
}
