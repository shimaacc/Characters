//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Common

public struct CharacterDomainModel: Decodable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: Gender
    public let image: String
    public let location: String
    
    public init(id: Int, name: String, status: String, species: String, gender: Gender, image: String, location: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
        self.location = location
    }
    
    public static func from(_ characterItem: CharacterItem) -> CharacterDomainModel {
           return CharacterDomainModel(
               id: characterItem.id,
               name: characterItem.name,
               status: characterItem.status,
               species: characterItem.species,
               gender: Gender(rawValue: characterItem.gender) ?? .unknown,
               image: characterItem.image,
               location: characterItem.location.name
           )
       }
}



// MARK: - Enums for Business Logic
public enum Gender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "Unknown"
}

public enum Status: String, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
