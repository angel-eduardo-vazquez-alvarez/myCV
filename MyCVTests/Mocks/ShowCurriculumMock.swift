//
//  ShowCurriculumMock.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
@testable import MyCV

class ShowCurriculumMock: UseCaseProtocol, ShowCurriculum {
    
    var service: FetchService
    var repository: DataRepository
    
    required init(service: FetchService, repository: DataRepository) {
        self.service = service
        self.repository = repository
    }

    
    func getNumberOfLanguages() -> Int {
        do {
            return try repository.languages(forKey: .languages).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    func getNumberOfWorks() -> Int {
        do {
            return try repository.works(forKey: .workExperience).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    func getNumberOfProgrammingLanguages() -> Int {
        do {
            return try repository.programmingLanguages(forKey: .programmingLanguages).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    func getNumberOfEducationValues() -> Int {
        do {
            return try repository.educationValues(forKey: .education).count
        } catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    func getLanguages() -> [Language] {
        do {
            return try repository.languages(forKey: .languages)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [Language]()
        }
    }
    
    func getWorks() -> [Work] {
        do {
            return try repository.works(forKey: .workExperience)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [Work]()
        }
    }
    
    func getEducationValues() -> [Education] {
        do {
            return try repository.educationValues(forKey: .education)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [Education]()
        }
    }
    
    func getProgrammingLanguages() -> [ProgrammingLanguage] {
        do {
            return try repository.programmingLanguages(forKey: .programmingLanguages)
        } catch {
            print("Error: \(error.localizedDescription)")
            return [ProgrammingLanguage]()
        }
    }
    
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
