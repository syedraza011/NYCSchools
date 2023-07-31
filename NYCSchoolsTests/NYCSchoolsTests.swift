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
    case schoolSuccessData, schoolMissingData, schoolEmptyData
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
    
    
//    func test_should_pass_real_Data() async throws {
//        let viewModel = SchoolViewModel(service: MockSchoolService(fileName: .schoolSuccessData))
//        let exp = XCTestExpectation(description: "Expecting to succeed")
//
//        await viewModel.getSchools()
//
//        viewModel.$allSchools
//            .sink { schools in
//
//                XCTAssertEqual(schools.first.dbn,"02M260")
//                XCTAssertEqual(schools.first.name,"Clinton School Writers & Artists, M.S. 260")
//                XCTAssertEqual(schools.first.city,"Manhattan")
//                XCTAssertEqual(schools.first.state,"NY")
//                XCTAssertEqual(schools.first.zip,"10003")
//                exp.fulfill()
//            }
//            .store(in: &cancellables)
//
//        wait(for: [exp], timeout: 5.0)
//    }
//    func test_should_pass_real_Data() async throws {
//        // Given
//        let viewModel = SchoolViewModel(service: MockSchoolService(fileName: .schoolSuccessData))
//        let exp = XCTestExpectation(description: "Expecting to succeed")
//
//        // When
//        do {
//            try await viewModel.getSchools()
//
//            // Then
//            let schools = try await viewModel.$allSchools.first() // Await the first value from the publisher
//
//            if let firstSchool = allSchools.first as? SchoolViewModel {
//                XCTAssertEqual(firstSchool.dbn, "02M260")
//                XCTAssertEqual(firstSchool.name, "Clinton School Writers & Artists, M.S. 260")
//                XCTAssertEqual(firstSchool.city, "Manhattan")
//                XCTAssertEqual(firstSchool.state, "NY")
//                XCTAssertEqual(firstSchool.zip, "10003")
//                exp.fulfill()
//            } else {
//                XCTFail("No schools found.")
//            }
//        } catch {
//            XCTFail("Unexpected error: \(error)")
//        }
//
//        // Wait for the expectation to be fulfilled
//        wait(for: [exp], timeout: 5.0)
//    }







                               
                               
}
//class MockSchoolService: SchoolServiceProtocol {
//    let fileName: FileName
//    
//    init(fileName: FileName) {
//        self.fileName = fileName
//    }
//    
//    func load(_ file: String) -> URL? {
//        return Bundle(for: type(of: self)).url(forResource: file, withExtension: "json")
//    }
//    
//    func fetchSchools() async throws -> [SchoolResponse] {
//        guard let url = load(fileName.rawValue) else {
//            throw APIError.invalidUrl
//        }
//        
//        do {
//            let data = try Data(contentsOf: url)
//            let result = try JSONDecoder().decode([SchoolResponse].self, from: data)
//        
//            return result
//        } catch {
//            throw APIError.emptyData
//        }
//    }
//}

