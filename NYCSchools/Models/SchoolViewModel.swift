//
//  SchoolViewModel.swift
//  NYCSchools
//
//  Created by Syed Raza on 7/29/23.
//

import Foundation
import Combine
//
//class SchoolViewModel: ObservableObject {
//    @Published var allSchools=[SchoolResponse]()
//    @Published var allSAT = [SATResponse]()
//    @Published var state: AsyncState = .initial
//
//    let service: SchoolServiceProtocol
//
//    init(service: SchoolServiceProtocol = SchoolService()){
//        self.service = service
//    }
//
//    @MainActor func getSchools() {
//        state = .loading
//        Task {
//            do {
//                allSchools = try await service.fetchSchools()
//            }catch {
//                print(error)
//            }
//        }
//
//    }
//    @MainActor func getSAT() {
//        state = .loading
//        Task {
//            do {
//                allSchools = try await service.fetchSchools()
//            }catch {
//                print(error)
//            }
//        }
//
//    }
//
//}
class SchoolViewModel: ObservableObject {
    @Published var allSchools = [SchoolResponse]()
    @Published var allSAT = [SATResponse]()
    @Published var tests: [SATResponse] = []
    @Published var state: AsyncState = .initial

    let service: SchoolServiceProtocol

    init(service: SchoolServiceProtocol = SchoolService()) {
        self.service = service
    }

    @MainActor
    func getSchools() {
        state = .loading
        Task {
            do {
                allSchools = try await service.fetchSchools()
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    func getSAT() {
        state = .loading
        Task {
            do {
                allSAT = try await service.fetchSAT()
            } catch {
                print(error)
            }
        }
    }

    // Function to put math, reading, and writing scores in a variable tests: [test]
    func test() -> [SATResponse] {
       
        for satResponse in allSAT {
            let dbn = satResponse.dbn
            let math = satResponse.maths
            let reading = satResponse.reading
            let writing = satResponse.writing

            let test = SATResponse(dbn: dbn, maths: math, reading: reading, writing: writing)
            tests.append(test)
        }
        return tests
    }
}
