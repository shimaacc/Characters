//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation
import Common

protocol CharacterDetailsViewModelProtocol {
    var uiModel: CharacterDetailsViewModel.UIModel { get set }
}


enum CharaterDetailsCellType {
    case image(String)
    case description(name: String, species: String, gender: String, status: String)
    case location(String)
}


class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    var uiModel: CharacterDetailsViewModel.UIModel = .init()
    let featureModel: CharacterDetailsFeatureModel
    
    init(featureModel: CharacterDetailsFeatureModel) {
        self.featureModel = featureModel
        setupSetions()
    }
    
    func setupSetions() {
        let item = featureModel.character
        uiModel.sections.append(.image(item.image))
        uiModel.sections.append(.description(name: item.name, species: item.species, gender: item.gender.rawValue, status: item.status))
        uiModel.sections.append(.location(item.location))
    }
}
extension CharacterDetailsViewModel {
    class UIModel {
        @Published var characterItem: CharacterDomainModel?
        @Published var sections: [CharaterDetailsCellType] = []
    }
}
