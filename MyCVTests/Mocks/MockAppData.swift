//
//  MockAppData.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/21/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
@testable import MyCV

struct MockApplicationData: ApplicationData {
    var firstName: String
    var lastName: String
    var age: Int
    var city: String
    var languages: [Language]
    var programmingLanguages: [ProgrammingLanguage]
    var summary: String
    var workExperience: [Work]
    var education: [Education]
    
    init(firstName: String, lastName: String, age: Int, city: String,
        languages: [Language], programmingLanguages: [ProgrammingLanguage],
        summary: String, workExperience: [Work], education: [Education]) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.city = city
        self.languages = languages
        self.programmingLanguages = programmingLanguages
        self.summary = summary
        self.workExperience = workExperience
        self.education = education
    }
}
