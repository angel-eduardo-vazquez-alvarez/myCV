//
//  ShowCurriculum.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/20/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Use a Data Transfer Object to simplify the transfer of primitive types.
struct BasicInfoDTO {
    let firstName: String
    let lastName: String
    let fullName: String
    let age: Int
    let summary: String
    let city: String
    
    /// Creates an instance of the `BasicInfoDTO` struct with empty values.
    static func makeEmpty() -> BasicInfoDTO {
        return BasicInfoDTO(firstName: "", lastName: "", fullName: "", age: 0, summary: "", city: "")
    }
}

/// Use case to show the detail screen of a curriculum vitae.
protocol ShowCurriculum {
    func getNumberOfLanguages() -> Int
    func getNumberOfWorks() -> Int
    func getNumberOfProgrammingLanguages() -> Int
    func getNumberOfEducationValues() -> Int
    func getLanguages() -> [Language]
    func getWorks() -> [Work]
    func getEducationValues() -> [Education]
    func getProgrammingLanguages() -> [ProgrammingLanguage]
    func getBasicInfo() -> BasicInfoDTO
}
