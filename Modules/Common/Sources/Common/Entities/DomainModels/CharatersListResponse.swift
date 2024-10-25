//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Common

// MARK: - Network Response
public struct CharactersListResponse: Codable, Sendable {
    public let info: Info?
    public let results: [CharacterItem]?
}

// MARK: - Info
public struct Info: Codable, Sendable {
    public let count, pages: Int?
    public let next, prev: String?
}
