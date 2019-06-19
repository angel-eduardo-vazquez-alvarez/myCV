//
//  MyCVTests.swift
//  MyCVTests
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/19/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import XCTest
@testable import MyCV

class MyCVTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMakeEmptyApplicationDataCreatesEmptyObject() {
        let emptyData = RawApplicationData.makeEmpty()
        XCTAssertEqual(emptyData.age, 0)
        XCTAssertEqual(emptyData.firstName, "")
        XCTAssertEqual(emptyData.lastName, "")
        XCTAssertEqual(emptyData.summary, "")
        XCTAssertEqual(emptyData.city, "")
        XCTAssertTrue(emptyData.languages.isEmpty)
        XCTAssertTrue(emptyData.education.isEmpty)
        XCTAssertTrue(emptyData.programmingLanguages.isEmpty)
        XCTAssertTrue(emptyData.workExperience.isEmpty)
    }
    
    func testDataRepositoryReturnsStringsCorrectly() {
        // Given
        let information = createStubApplicationData()
        let sut = MockInMemoryDataRepository(information: information)
        
        // When
        let firstName = sut.string(forKey: .firstName)
        let lastName = sut.string(forKey: .lastName)
        let city = sut.string(forKey: .city)
        let summary = sut.string(forKey: .summary)
        let emptyString = sut.string(forKey: .age)
        
        // Then
        XCTAssertEqual(firstName, "Angel")
        XCTAssertEqual(lastName, "Vazquez")
        XCTAssertEqual(city, "CDMX")
        XCTAssertEqual(summary, "Awesome summary")
        XCTAssertEqual(emptyString, "")
    }
    
    func testDataRepositoryReturnsIntegersCorrectly() {
        // Given
        let information = createStubApplicationData()
        let sut = MockInMemoryDataRepository(information: information)
        
        // When
        let zero = sut.integer(forKey: .summary)
        let age = sut.integer(forKey: .age)
        
        // Then
        XCTAssertEqual(age, 22)
        XCTAssertEqual(zero, 0)
    }
    
    func testDataRepositoryReturnsLanguagesCorrectly() {
        // Given
        let information = createStubApplicationData()
        let sut = MockInMemoryDataRepository(information: information)
        
        // When
        let emptyArray = sut.languages(forKey: .summary)
        let languages = sut.languages(forKey: .languages)
        guard let language = languages.first, languages.count == 1 else {
            XCTFail("Should contain exactly 1 item")
            return
        }
        
        // Then
        XCTAssertEqual(language.name, "Spanish")
        XCTAssertEqual(language.level, "Native")
        XCTAssertTrue(emptyArray.isEmpty)
    }
    
    func testDataRepositoryReturnsWorksCorrectly() {
        // Given
        let information = createStubApplicationData()
        let sut = MockInMemoryDataRepository(information: information)
        
        // When
        let emptyArray = sut.works(forKey: .summary)
        let works = sut.works(forKey: .workExperience)
        guard let work = works.first, works.count == 1 else {
            XCTFail("Should contain exactly 1 item")
            return
        }
        
        // Then
        XCTAssertEqual(work.name, "First job")
        XCTAssertEqual(work.role, "Junior")
        XCTAssertEqual(work.startDate, "02/2008")
        XCTAssertEqual(work.endDate, "02/2010")
        XCTAssertTrue(emptyArray.isEmpty)
    }
    
    func testDataRepositoryReturnsProgrammingLanguagesCorrectly() {
        // Given
        let information = createStubApplicationData()
        let sut = MockInMemoryDataRepository(information: information)
        
        // When
        let emptyArray = sut.programmingLanguages(forKey: .summary)
        let programmingLanguages = sut.programmingLanguages(forKey: .programmingLanguages)
        guard let programmingLanguage = programmingLanguages.first, programmingLanguages.count == 1 else {
            XCTFail("Should contain exactly 1 item")
            return
        }
        
        // Then
        XCTAssertEqual(programmingLanguage.name, "C++")
        XCTAssertEqual(programmingLanguage.duration, "2 months")
        XCTAssertTrue(emptyArray.isEmpty)
    }
    
    func testDataRepositoryReturnsEducationValuesCorrectly() {
        // Given
        let information = createStubApplicationData()
        let sut = MockInMemoryDataRepository(information: information)
        
        // When
        let emptyArray = sut.educationValues(forKey: .summary)
        let educationValues = sut.educationValues(forKey: .education)
        guard let value = educationValues.first, educationValues.count == 1 else {
            XCTFail("Should contain exactly 1 item")
            return
        }
        
        // Then
        XCTAssertEqual(value.name, "Awesome School")
        XCTAssertEqual(value.degree, "Degree")
        XCTAssertEqual(value.startDate, "02/2000")
        XCTAssertEqual(value.endDate, "02/2004")
        XCTAssertTrue(emptyArray.isEmpty)
    }
    
    func testFetchServiceParsesValidJSONCorrectly() {
        let session = MockURLSession()
        session.data = loadJSONFromFile()
        let expectation = XCTestExpectation(description: "Correct parsing")
        
        // when
        session.dataTask(with: URL(fileURLWithPath: "info.json")) { data, response, error in
            guard let data = data else {
                XCTFail()
                return
            }
            let appData = MockFetchService.parse(data: data)
            XCTAssertNotNil(appData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchServiceParsesFailsWithInvalidJSON() {
        let session = MockURLSession()
        session.data = loadJSONFromFile(name: "badinfo")
        let expectation = XCTestExpectation(description: "Correct parsing")
        
        // when
        session.dataTask(with: URL(fileURLWithPath: "badinfo.json")) { data, response, error in
            guard let data = data else {
                XCTFail()
                return
            }
            let appData = MockFetchService.parse(data: data)
            XCTAssertNil(appData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchServiceFailsWhenTheresNoInternet() {
        // given
        let sut = GistFetchService()
        let session = MockURLSession()
        session.error = NSError(domain: "Not connected", code: NSURLErrorNotConnectedToInternet)
        let expectation = XCTestExpectation(description: "When there's no internet")
        
        // when
        sut.retrieveInfo(using: session) { response in
            switch response {
            case .notConnected:
                XCTAssertEqual(response.description, "notConnected")
                expectation.fulfill()
            case .failure, .success:
                XCTFail("Response should be not connected.")
            }
        }
        
        // then
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchServiceSucceedsInNormalConditions() {
        // given
        let sut = GistFetchService()
        let session = MockURLSession()
        session.data = loadJSONFromFile()
        let response = HTTPURLResponse(url: URL(fileURLWithPath: "info.json"), statusCode: 200, httpVersion: nil, headerFields: nil)
        session.response = response
        let expectation = XCTestExpectation(description: "Success in normal conditions")
        
        // when
        sut.retrieveInfo(using: session) { response in
            switch response {
            case .success:
                XCTAssertEqual(response.description, "success")
                expectation.fulfill()
            case .failure, .notConnected:
                XCTFail("Response should be success.")
            }
        }
        
        // then
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchServiceFailsWithAnyError() {
        // given
        let sut = GistFetchService()
        let session = MockURLSession()
        session.error = NSError(domain: "Any error", code: 500, userInfo: nil)
        let expectation = XCTestExpectation(description: "Failure when error")
        
        // when
        sut.retrieveInfo(using: session) { response in
            switch response {
            case .failure:
                XCTAssertEqual(response.description, "failure")
                expectation.fulfill()
            case .notConnected, .success:
                XCTFail("Response should be failure.")
            }
        }
        
        // then
        wait(for: [expectation], timeout: 2)
    }
    
    func testUseCaseLocatorReturnCorrectUseCase() {
        // given
        let sut = UseCaseLocator.main
        
        // when
        let getInformation = sut.getUseCase(of: GetMainInformation.self)
        let showCurriculum = sut.getUseCase(of: ShowCurriculum.self)
        
        // then
        XCTAssertTrue(getInformation is GetMainInformationImplementation)
        XCTAssertTrue(showCurriculum is ShowCurriculumImplementation)
    }
    
    func testInitialViewModelSuccessState() {
        // given
        let caseLocator = UseCaseLocatorMock(service: MockFetchService(), repository: MockInMemoryDataRepository(information: RawApplicationData.makeEmpty()))
        caseLocator.informationType = .success
        let sut = InitialViewModel(locator: caseLocator)
        
        // when
        sut.start()
        
        // then
        XCTAssertEqual(sut.appState, InitialViewModel.State.finished)
    }
    
    func testInitialViewModelFailureNotConnectedState() {
        // given
        let caseLocator = UseCaseLocatorMock(service: MockFetchService(), repository: MockInMemoryDataRepository(information: RawApplicationData.makeEmpty()))
        caseLocator.informationType = .notConnected
        let sut = InitialViewModel(locator: caseLocator)
        
        // when
        sut.start()
        
        // then
        XCTAssertEqual(sut.appState, InitialViewModel.State.error(message: NSLocalizedString("Disconnected", comment: "")))
    }
    
    func testInitialViewModelFailureUnknownState() {
        // given
        let caseLocator = UseCaseLocatorMock(service: MockFetchService(), repository: MockInMemoryDataRepository(information: RawApplicationData.makeEmpty()))
        caseLocator.informationType = .failure
        let sut = InitialViewModel(locator: caseLocator)
        
        // when
        sut.start()
        
        // then
        XCTAssertEqual(sut.appState, InitialViewModel.State.error(message: NSLocalizedString("Error", comment: "")))
    }
    
    func testCurriculumViewModelReturnsCorrectHeightForLanguagesCard() {
        // Given
        let caseLocator = UseCaseLocatorMock(service: MockFetchService(), repository: MockInMemoryDataRepository(information: createStubApplicationData()))
        let sut = CurriculumViewModel(locator: caseLocator)
        
        // When
        let height = sut.heightForLanguageCard()
        
        // Then
        XCTAssertEqual(height, 160)
    }
    
    func testCurriculumViewModelReturnsCorrectHeightForEducationCard() {
        // Given
        let caseLocator = UseCaseLocatorMock(service: MockFetchService(), repository: MockInMemoryDataRepository(information: createStubApplicationData()))
        let sut = CurriculumViewModel(locator: caseLocator)
        
        // When
        let height = sut.heightForEducationCard()
        
        // Then
        XCTAssertEqual(height, 210)
    }
    
    func testCurriculumViewModelReturnsCorrectHeightForProgrammingLanguagesCard() {
        // Given
        let caseLocator = UseCaseLocatorMock(service: MockFetchService(), repository: MockInMemoryDataRepository(information: createStubApplicationData()))
        let sut = CurriculumViewModel(locator: caseLocator)
        
        // When
        let height = sut.heightForProgrammingCard()
        
        // Then
        XCTAssertEqual(height, 160)
    }
    
    func testCurriculumViewModelReturnsCorrectHeightForWorkExperienceCard() {
        // Given
        let caseLocator = UseCaseLocatorMock(service: MockFetchService(), repository: MockInMemoryDataRepository(information: createStubApplicationData()))
        let sut = CurriculumViewModel(locator: caseLocator)
        
        // When
        let height = sut.heightForWorkCard()
        
        // Then
        XCTAssertEqual(height, 335)
    }
}

// MARK: - Helper methods
extension MyCVTests {
    func createStubApplicationData() -> ApplicationData {
        return MockApplicationData(firstName: "Angel", lastName: "Vazquez", age: 22, city: "CDMX", languages: [Language(name: "Spanish", level: "Native")], programmingLanguages: [ProgrammingLanguage(name: "C++", duration: "2 months")], summary: "Awesome summary", workExperience: [Work(name: "First job", role: "Junior", startDate: "02/2008", endDate: "02/2010", description: "Awesome description")], education: [Education(name: "Awesome School", degree: "Degree", startDate: "02/2000", endDate: "02/2004")])
    }
    
    func loadJSONFromFile(name: String = "info") -> Data {
        guard let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: "json") else {
            fatalError("Could not load file named: \(name)")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not read data from file")
        }
        
        return data
    }
}
