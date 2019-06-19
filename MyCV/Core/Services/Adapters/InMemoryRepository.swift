//
//  InMemoryRepository.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Implementation of the `DataRepository` protocol that stores information in memory
/// instead of a persistence container.
class InMemoryDataRepository: DataRepository {
    
    // MARK: - Properties
    /// Property to store the information fetched from the `FetchService`.
    private var information: ApplicationData = RawApplicationData.makeEmpty()
    
    // MARK: - Methods
    /// Returns a string from an object that conforms to the `ApplicationData` protocol.
    /// - Parameter key: The key for a string.
    func string(forKey key: DataKey) throws -> String {
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
            throw DataKey.KeyError.notSupported
        }
    }
    
    /// Returns an integer from an object that conforms to the `ApplicationData` protocol.
    /// - Parameter key: The key for an integer.
    func integer(forKey key: DataKey) throws -> Int {
        switch key {
        case .age:
            return information.age
        default:
            throw DataKey.KeyError.notSupported
        }
    }
    
    /// Returns a `Language` array from an object that conforms to the `ApplicationData` protocol.
    /// - Parameter key: The key for a `Language` array.
    func languages(forKey key: DataKey) throws -> [Language] {
        switch key {
        case .languages:
            return information.languages
        default:
            throw DataKey.KeyError.notSupported
        }
    }
    
    /// Returns a `Work` array from an object that conforms to the `ApplicationData` protocol.
    /// - Parameter key: The key for a `[Work]`.
    func works(forKey key: DataKey) throws -> [Work] {
        switch key {
        case .workExperience:
            return information.workExperience
        default:
            throw DataKey.KeyError.notSupported
        }
    }
    
    /// Returns a `ProgrammingLanguage` array from an object that conforms to
    /// the `ApplicationData` protocol.
    /// - Parameter key: The key for a `ProgrammingLanguage` array.
    func programmingLanguages(forKey key: DataKey) throws -> [ProgrammingLanguage] {
        switch key {
        case .programmingLanguages:
            return information.programmingLanguages
        default:
            throw DataKey.KeyError.notSupported
        }
    }
    
    /// Returns an `Education` array from an object that conforms to the `ApplicationData` protocol.
    /// - Parameter key: The key for an `Education` array.
    func educationValues(forKey key: DataKey) throws -> [Education] {
        switch key {
        case .education:
            return information.education
        default:
            throw DataKey.KeyError.notSupported
        }
    }
    
    /// Stores the information fetched from the `FetchService` in a private container.
    /// - Parameter information: The fetched information to be stored inside the repository.
    func save(information: ApplicationData) -> Bool {
        self.information = information
        return true
    }
}
