//
//  SchoolService.swift
//  NYCSchools
//
//  Created by Syed Raza on 7/29/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "invalid url"
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .serviceUnavailable:
            return "service unavailable"
        case .decodingError:
            return "decoding error"
        }
    }
}

class SchoolService {
//    let urlString = "https://data.cityofnewyork.us/Education/DOE-High- School-Directory-2017/s3k6-pzi2.Json?"
    let urlString = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    func fetchSchools() async throws -> SchoolResponse {
        
        guard let url =  URL(string: urlString) else {
            throw APIError.invalidUrl
        }
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            return try JSONDecoder().decode(SchoolResponse.self, from: data)
        }catch {
            throw APIError.decodingError
        }
    }
}
