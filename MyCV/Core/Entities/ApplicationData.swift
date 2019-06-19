//
//  ApplicationData.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation

/// Represents an spoken language.
struct Language: Codable {
    let name: String
    let level: String
}

/// Represents a programming language.
struct ProgrammingLanguage: Codable {
    let name: String
    let duration: String
}

/// Represents a place for work.
struct Work: Codable {
    let name: String
    let role: String
    let startDate: String
    let endDate: String?
    let description: String
}

/// Represents an educational achievement.
struct Education: Codable {
    let name: String
    let degree: String
    let startDate: String
    let endDate: String?
}

/// Data to be used within the application. Using a protocol
/// allows stubbing.
protocol ApplicationData: Codable {
    var firstName: String { get }
    var lastName: String { get }
    var age: Int { get }
    var city: String { get }
    var languages: [Language] { get }
    var programmingLanguages: [ProgrammingLanguage] { get }
    var summary: String { get }
    var workExperience: [Work] { get }
    var education: [Education] { get }
}

/// Data to be used within the application. Concrete implementation that conforms
/// to the `ApplicationData` protocol.
struct RawApplicationData: ApplicationData {
    var firstName: String
    var lastName: String
    var age: Int
    var city: String
    var languages: [Language]
    var programmingLanguages: [ProgrammingLanguage]
    var summary: String
    var workExperience: [Work]
    var education: [Education]
    
    private init() {
        self.firstName = ""
        self.lastName = ""
        self.age = 0
        self.city = ""
        self.languages = []
        self.programmingLanguages = []
        self.summary = ""
        self.workExperience = []
        self.education = []
    }
    
    /// Creates an instance of the ApplicationData with all of its values initialized
    /// to an empty state. For example, strings are initialized to the empty string `""`,
    /// integers default to 0, and arrays default to an empty array `[]`.
    static func makeEmpty() -> RawApplicationData {
        return RawApplicationData()
    }
}
