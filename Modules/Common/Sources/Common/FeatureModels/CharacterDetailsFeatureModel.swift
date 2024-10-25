//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation

public struct CharacterDetailsFeatureModel {
    var character: CharacterDomainModel
    
    public init(character: CharacterDomainModel) {
        self.character = character
    }
}
