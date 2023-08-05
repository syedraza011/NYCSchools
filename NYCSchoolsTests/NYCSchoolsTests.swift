//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by Syed Raza on 7/29/23.
//

import XCTest
@testable import NYCSchools
import Combine
enum FileName: String {
    case schoolSuccess, schoolFailure, emptyData
}
final class NYCSchoolsTests: XCTestCase {
    
    var cancellables: Set <AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func test_Fetch_School_should_Succeed() async throws{
        
        let viewModel = SchoolViewModel(service: MockSchoolService(fileName: .schoolSuccess))
        
        let expection = XCTestExpectation(description: "School Fetch Success Call")
        
        await viewModel.getSchools()
        
        viewModel.$allSchools.dropFirst().sink{ school in
           
            XCTAssertFalse(school.isEmpty, "stockShouldNotBeEmpty")
            let first = school.first!
            XCTAssertEqual(first.name, "Clinton School Writers & Artists, M.S. 260")
            expection.fulfill()
        }
        .store(in: &cancellables)
        await fulfillment(of: [expection], timeout: 5)
    }
    
    func test_Fetch_School_should_Fail() async  {
        let viewModel = SchoolViewModel(service: MockSchoolService(fileName: .schoolFailure))
        let exp = XCTestExpectation(description: "School Fetch Fail Call")

        await viewModel.getSchools()
        viewModel.$state
            .dropFirst()
            .sink { state in
                XCTAssert(state == .error)
                exp.fulfill()
            }
            .store(in: &cancellables)

        await fulfillment(of: [exp], timeout: 5)

      
    }

                               
}
class MockSchoolService: SchoolServiceProtocol {
    let fileName: FileName
    
    init(fileName: FileName) {
        self.fileName = fileName
    }
    
    func load(_ file: String) -> URL? {
        return Bundle(for: type(of: self)).url(forResource: file, withExtension: "json")
    }
    
    func fetchSchools() async throws -> [SchoolResponse] {
        guard let url = load(fileName.rawValue) else {
            throw APIError.invalidUrl
        }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([SchoolResponse].self, from: data)
        
            return result
        } catch {
            throw APIError.emptyData
        }
    }
    func fetchSAT() async throws -> [SATResponse] {
        guard let url = load(fileName.rawValue) else {
            throw APIError.invalidUrl
        }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([SATResponse].self, from: data)
        
            return result
        } catch {
            throw APIError.emptyData
        }
    }
}

