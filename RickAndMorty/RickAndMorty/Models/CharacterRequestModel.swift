//
//  CharacterRequestModel.swift
//  RickAndMorty
//
//  Created by Максим Жуков on 29.11.2023.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    
    struct Origin: Decodable {
        let name: String
        let url: String
    }
    
    struct Location: Decodable {
        let name: String
        let url: String
    }
}
