//
//  SchoolViewModel.swift
//  NYCSchools
//
//  Created by Syed Raza on 7/29/23.
//

import Foundation
import Combine

class SchoolViewModel: ObservableObject {
    @Published var allSchools = [SchoolResponse]()
    @Published var allSAT = [SATResponse]()
   
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
                state = .loaded
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


}
