//
//  SchoolViewModel.swift
//  NYCSchools
//
//  Created by Syed Raza on 7/29/23.
//

import Foundation
class SchoolViewModel: ObservableObject {
    @Published var allSchools: [School] = []
//    @Published var allSchools = SchoolResponse(schools:[School]())
    @Published var state: AsyncState = .initial

    let service = SchoolService()

    @MainActor func getSchools() async {
        state = .loading
        Task {
            do {
                let schoolList: SchoolResponse = try await self.service.fetchSchools()
                if schoolList.schools.isEmpty{
                    throw APIError.emptyData
                }
                self.allSchools = schoolList.schools
                state = .loaded
            }catch {
                if let error = error as? APIError {
                    print(error.description)
                }else {
                    state = .error
                }
            }
        }
    }
}

