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
    case description(String)
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
        uiModel.sections = [
             .image("star.fill"),
             .description("This is a description for the second cell."),
             .location("New York, USA")
         ]
    }
}
extension CharacterDetailsViewModel {
    class UIModel {
//        @Published var characterItem: CharaterItemUIModel = .init()
        @Published var sections: [CharaterDetailsCellType] = []
    }
}
