//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Common
import Combine
import Business

@MainActor
protocol CharacterListViewModelProtocol {
    var uiModel: CharacterListViewModel.UIModel { get set }
    func didSelctItem(at index: Int)
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    var uiModel: CharacterListViewModel.UIModel = .init()
    var useCase: FetchCharacterListUseCaseProtocol
    
    init(useCase: FetchCharacterListUseCaseProtocol) {
        self.useCase = useCase
        Task {
           await fetchItems()
        }
    }

    func fetchItems() async  {
        let result = await useCase.fetchCharacters(in: 1)
        switch result {
        case .success(let list):
            uiModel.characterList = mapItemUIModel(from: list)
        case .failure(let error):
            print("error")
        }
    }
    
    
    func mapItemUIModel(from characterListDomainModels: [CharacterDomainModel]) -> [CharaterItemUIModel] {
        characterListDomainModels.map { domainModel in
            .init(title: domainModel.name, image: domainModel.image, species: domainModel.species)
        }
    }
    
    func didSelctItem(at index: Int) {
        
    }
    
}
 
extension CharacterListViewModel {
    class UIModel {
        @Published var characterList: [CharaterItemUIModel] = []
    }

    struct CharaterItemUIModel {
        let title: String
        let image: String
        var species: String
    }
}

