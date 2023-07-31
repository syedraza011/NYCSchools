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


protocol SchoolServiceProtocol {
    func fetchSchools() async throws -> [SchoolResponse]
    func fetchSAT() async throws -> [SATResponse]
}


class SchoolService: SchoolServiceProtocol{
    
    struct Constants {
        static let baseURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        static let urlStringSAT="https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    }
    
    func fetchSchools() async throws ->  [SchoolResponse]{
        guard let url = URL(string: Constants.baseURL) else {
            throw APIError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            let result = try JSONDecoder().decode([SchoolResponse].self, from: data)
            return result
        } catch {
            print(error)
            throw APIError.decodingError
        }
        
    } // ending fetchSchools
    
    
    
        func fetchSAT() async throws -> [SATResponse] {
    
            guard let url =  URL(string: Constants.urlStringSAT) else {
                throw APIError.invalidUrl
            }
            do {
                let (data,response) = try await URLSession.shared.data(from: url)
                guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
                    throw APIError.invalidResponse
                }
                return try JSONDecoder().decode([SATResponse].self, from: data)
            }catch {
                throw APIError.decodingError
            }
        }
   
} //ending school service
