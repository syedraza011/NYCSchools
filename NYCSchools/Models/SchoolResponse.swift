//
//  SchoolResponse.swift
//  NYCSchools
//
//  Created by Syed Raza on 7/29/23.
//

import Foundation

struct SchoolResponse: Decodable{
    let schools: [School]
}
struct School: Decodable,Identifiable {
    let id = UUID()
    let school_name: String
    let boro: String
    
}
