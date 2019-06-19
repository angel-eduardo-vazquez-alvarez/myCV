//
//  CVViewModel.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/20/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
import CoreGraphics

class CurriculumViewModel {
    
    // MARK: - Properties
    private let locator: UseCaseLocatorProtocol
    
    // MARK: - Computed properties
    var languages: [Language] {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return [] }
        return showCurriculum.getLanguages()
    }
    
    var programmingLanguages: [ProgrammingLanguage] {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return [] }
        return showCurriculum.getProgrammingLanguages()
    }
    
    var works: [Work] {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return [] }
        return showCurriculum.getWorks()
    }
    
    var educationValues: [Education] {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return [] }
        return showCurriculum.getEducationValues()
    }
    
    var basicInfo: BasicInfoDTO {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return BasicInfoDTO.makeEmpty() }
        return showCurriculum.getBasicInfo()
    }
    
    // MARK: - Initializers
    init(locator: UseCaseLocatorProtocol) {
        self.locator = locator
    }
    
    // MARK: - Methods    
    func heightForLanguageCard() -> Int {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return 0 }
        let count = showCurriculum.getNumberOfLanguages()
        return 100 + count * 60
    }
    
    func heightForProgrammingCard() -> Int {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return 0 }
        let count = showCurriculum.getNumberOfProgrammingLanguages()
        return 100 + count * 60
    }
    
    func heightForWorkCard() -> Int {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return 0 }
        let count = showCurriculum.getNumberOfWorks()
        return 100 + count * 235
    }
    
    func heightForEducationCard() -> Int {
        guard let showCurriculum = locator.getUseCase(of: ShowCurriculum.self) else { return 0 }
        let count = showCurriculum.getNumberOfEducationValues()
        return 100 + count * 110
    }
}
