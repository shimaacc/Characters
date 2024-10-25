//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation

// MARK: - Character Item
public struct CharacterItem: Codable, Sendable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: Location
    public let location: Location
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}

// MARK: - Location
public struct Location: Codable, Sendable {
    public let name: String
    public let url: String
}
