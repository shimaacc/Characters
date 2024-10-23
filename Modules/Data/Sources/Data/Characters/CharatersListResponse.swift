//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Common

// MARK: - Network Response
struct CharactersListResponse: Codable, Sendable {
    let info: Info
    let results: [CharacterItem]
}

// MARK: - Info
struct Info: Codable, Sendable {
    let count, pages: Int
    let next, prev: String
}
