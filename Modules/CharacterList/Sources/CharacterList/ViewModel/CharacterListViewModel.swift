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
    func didApplyFilterType()
    func checkIfReachedEndOfPage(for index: Int)
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    var uiModel: CharacterListViewModel.UIModel = .init()
    var characterListDomainModels: [CharacterDomainModel] = []
    let useCase: FetchCharacterListUseCaseProtocol
    let navigation: NavigationProtocol
    var page = 1
    private var hasReachedEndOfPage = false

    init(useCase: FetchCharacterListUseCaseProtocol,
         navigation: NavigationProtocol) {
        self.useCase = useCase
        self.navigation = navigation
        Task {
           let list = await fetchItems()
        }
        getStatuses(from: characterListDomainModels)
    }

    func fetchItems(status: String? = nil) async  {
        let result = await useCase.fetchCharacters(in: page, status: status?.lowercased())
        print("fetching for page \(page)")
        switch result {
        case .success(let paginatedOutput):
            // If no more next
            guard paginatedOutput.next != nil else { return }
            let list = paginatedOutput.output
            characterListDomainModels += paginatedOutput.output
            uiModel.characterList += mapItemUIModel(from: list)
        case .failure(let error):
            print("handle error")
        }
    }
    
    func checkIfReachedEndOfPage(for index: Int) {
        if index + 1 == uiModel.characterList.count {
            if !hasReachedEndOfPage {
                didReachEndOfPage()
                hasReachedEndOfPage = true
            }
        } else {
            hasReachedEndOfPage = false
        }
    }
    
    func didReachEndOfPage() {
        page += 1
        Task {
            try await fetchItems(status: uiModel.selectedFilterItem)
        }
    }
    
    func mapItemUIModel(from characterListDomainModels: [CharacterDomainModel]) -> [CharaterItemUIModel] {
        characterListDomainModels.map { domainModel in
            .init(title: domainModel.name, image: domainModel.image, species: domainModel.species)
        }
    }
    
    func didSelctItem(at index: Int) {
        let featureModel = CharacterDetailsFeatureModel(character: characterListDomainModels[index])
        navigation.navigate(to: "characterDetails", arguments: featureModel)
    }
    
    func didApplyFilterType() {
        reset()
        Task {
            try await fetchItems(status: uiModel.selectedFilterItem)
        }
    }
    
    func reset() {
        page = 1
        uiModel.characterList = []
        characterListDomainModels = []
    }
    
    func getStatuses(from characters: [CharacterDomainModel]) {
        let basicStatuses: Set<String> = Set(Status.allCases.map { $0.rawValue })
        let characterStatuses = Set(characters.map { $0.status })
        let allStatuses = basicStatuses.union(characterStatuses)
        uiModel.characterStatusesList = Array(allStatuses)
    }
}
 
extension CharacterListViewModel {
    class UIModel {
        @Published var characterList: [CharaterItemUIModel] = []
        @Published var characterStatusesList: [String] = []
        @Published var selectedFilterItem: String?

    }

    struct CharaterItemUIModel {
        let title: String
        let image: String
        var species: String
    }
}

