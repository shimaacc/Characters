//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Business
import Combine

protocol CharacterListViewModelProtocol {
    var uiModel: CharacterListViewModel.UIModel { get set }

    func didSelctItem(at index: Int)
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    var uiModel: CharacterListViewModel.UIModel = .init()
  
//    init() {
//        Task {
//           await fetchItems()
//        }
//    }
//
//    func fetchItems() async  {
//        let result = await FetchCharactersUseCase(repository: <#CharactersRepositoryProtocol#>).execute()
//        switch result {
//        case .success(let list):
//            mapItemUIModel(with: list)
//        case .failure(let error):
//            print("error")
//        }
//    }
    
    
    func mapItemUIModel(from characterListDomainModels: [CharacterDomainModel]) -> [CharaterItemUIModel] {
        characterListDomainModels.map { domainModel in
                .init(title: "", image: "",species: "" )
        }
    }
    
    func didSelctItem(at index: Int) {
        
    }
    
}
 
extension CharacterListViewModel {
    class UIModel {
        @Published var characterListItem: [CharaterItemUIModel] = []
    }

    struct CharaterItemUIModel {
        let title: String
        let image: String
        var species: String
    }
}

