//
//  DataRepository.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Keys to fetch data used within the application
/// from the `DataRepository` implementations.
enum DataKey: String {
    
    /// Errors that may be thrown when using the `DataKey` enum.
    enum KeyError: Error {
        case notSupported
    }
    
    case firstName
    case lastName
    case fullName
    case city
    case summary
    case age
    case languages
    case programmingLanguages
    case workExperience
    case education
}

/// Data Repository that stores information across all flows of the app.
/// It is a protocol to allow mocking to allow for easier testing.
protocol DataRepository {
    func languages(forKey key: DataKey) throws -> [Language]
    func works(forKey key: DataKey) throws -> [Work]
    func programmingLanguages(forKey key: DataKey) throws -> [ProgrammingLanguage]
    func educationValues(forKey key: DataKey) throws -> [Education]
    func string(forKey key: DataKey) throws -> String
    func integer(forKey key: DataKey) throws -> Int
    func save(information: ApplicationData) -> Bool
}
