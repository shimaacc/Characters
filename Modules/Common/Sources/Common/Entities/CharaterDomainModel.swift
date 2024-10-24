//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Common

public struct CharacterDomainModel {
    public let id: Int
    public let name: String
    public let status: Status
    public let species: String
    public let gender: Gender
    public let image: String
    
    public static func from(_ characterItem: CharacterItem) -> CharacterDomainModel {
           return CharacterDomainModel(
               id: characterItem.id,
               name: characterItem.name,
               status: Status(rawValue: characterItem.status) ?? .unknown,
               species: characterItem.species,
               gender: Gender(rawValue: characterItem.gender) ?? .unknown,
               image: characterItem.image
           )
       }
}



// MARK: - Enums for Business Logic
public enum Gender: String {
    case female = "Female"
    case male = "Male"
    case unknown = "Unknown"
}

public enum Status: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
