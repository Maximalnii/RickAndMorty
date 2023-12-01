//
//  Model.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 27.11.2023.
//

import Foundation

struct Episodes: Decodable {
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [DetailedInformation]
}

struct DetailedInformation: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
