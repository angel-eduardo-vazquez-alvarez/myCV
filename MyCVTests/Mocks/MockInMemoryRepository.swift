//
//  MockInMemoryRepository.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
@testable import MyCV

class MockInMemoryDataRepository: DataRepository {
    
    // MARK: - Properties
    private var information: ApplicationData
    
    init(information: ApplicationData) {
        self.information = information
    }
    
    // MARK: - Methods
    func string(forKey key: DataKey) -> String {
        switch key {
        case .firstName:
            return information.firstName
        case .lastName:
            return information.lastName
        case .fullName:
            return "\(information.firstName) \(information.lastName)"
        case .city:
            return information.city
        case .summary:
            return information.summary
        default:
            return ""
        }
    }
    
    func integer(forKey key: DataKey) -> Int {
        switch key {
        case .age:
            return information.age
        default:
            return 0
        }
    }
    
    func languages(forKey key: DataKey) -> [Language] {
        switch key {
        case .languages:
            return information.languages
        default:
            return []
        }
    }
    
    func works(forKey key: DataKey) -> [Work] {
        switch key {
        case .workExperience:
            return information.workExperience
        default:
            return []
        }
    }
    
    func programmingLanguages(forKey key: DataKey) -> [ProgrammingLanguage] {
        switch key {
        case .programmingLanguages:
            return information.programmingLanguages
        default:
            return []
        }
    }
    
    func educationValues(forKey key: DataKey) -> [Education] {
        switch key {
        case .education:
            return information.education
        default:
            return []
        }
    }
    
    
    func save(information: ApplicationData) -> Bool {
        self.information = information
        return true
    }
}
