//
//  ShowCurriculumImplementation.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/20/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Concrete implementation for the `ShowCurriculum` protocol.
class ShowCurriculumImplementation: UseCaseProtocol, ShowCurriculum {
    
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

    /// Returns the count for the `Language` array from its repository.
    func getNumberOfLanguages() -> Int {
        do {
            return try repository.languages(forKey: .languages).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    /// Returns the count for the `Work` array from its repository.
    func getNumberOfWorks() -> Int {
        do {
            return try repository.works(forKey: .workExperience).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    /// Returns the count for the `ProgrammingLanguage` array from its repository.
    func getNumberOfProgrammingLanguages() -> Int {
        do {
            return try repository.programmingLanguages(forKey: .programmingLanguages).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    /// Returns the count for the `Education` array from its repository.
    func getNumberOfEducationValues() -> Int {
        do {
            return try repository.educationValues(forKey: .education).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    /// Returns the `Language` array stored inside its repository.
    func getLanguages() -> [Language] {
        do {
            return try repository.languages(forKey: .languages)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [Language]()
        }
    }
    
    /// Returns the `Work` array stored inside its repository.
    func getWorks() -> [Work] {
        do {
            return try repository.works(forKey: .workExperience)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [Work]()
        }
    }
    
    /// Returns the `Education` array stored inside its repository.
    func getEducationValues() -> [Education] {
        do {
            return try repository.educationValues(forKey: .education)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [Education]()
        }
    }
    
    /// Returns the `ProgrammingLanguage` array stored inside its repository.
    func getProgrammingLanguages() -> [ProgrammingLanguage] {
        do {
            return try repository.programmingLanguages(forKey: .programmingLanguages)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [ProgrammingLanguage]()
        }
    }
    
    /// Returns a DTO of the basic information stored inside its repository.
    func getBasicInfo() -> BasicInfoDTO {
        do {
            let firstName = try repository.string(forKey: .firstName)
            let lastName = try repository.string(forKey: .lastName)
            let fullName = try repository.string(forKey: .fullName)
            let age = try repository.integer(forKey: .age)
            let summary = try repository.string(forKey: .summary)
            let city = try repository.string(forKey: .city)
            return BasicInfoDTO(firstName: firstName, lastName: lastName, fullName: fullName, age: age, summary: summary, city: city)
        } catch {
            print("Error: \(error.localizedDescription)")
            return BasicInfoDTO.makeEmpty()
        }
    }
}
