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

protocol CharacterListViewModelProtocol {
    var uiModel: CharacterListViewModel.UIModel { get set }
    func viewDidLoad()
    func didSelctItem(at index: Int)
    func didApplyFilterType()
    func checkIfReachedEndOfPage(for index: Int) async
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    var uiModel: CharacterListViewModel.UIModel = .init()
    var characterListDomainModels: [CharacterDomainModel] = []
    let useCase: FetchCharacterListUseCaseProtocol
    let navigation: NavigationProtocol
    var page = 1
    private var hasReachedEndOfPage = false
    private var isThereNextPages = true
    
    init(useCase: FetchCharacterListUseCaseProtocol,
         navigation: NavigationProtocol) {
        self.useCase = useCase
        self.navigation = navigation
    }
    
    func viewDidLoad() {
        Task {
            await fetchItems()
            getStatuses(from: characterListDomainModels)
        }
    }
    
    func fetchItems(status: String? = nil) async  {
        let result = await useCase.fetchCharacters(in: page, status: status?.lowercased())
        print("fetching for page \(page)")
        switch result {
        case .success(let paginatedOutput):
            // If no more next
            if paginatedOutput.next == nil {
                isThereNextPages = false
            }
            let list = paginatedOutput.output
            characterListDomainModels += paginatedOutput.output
            uiModel.characterList += mapItemUIModel(from: list)
        case .failure(_):
            print("handle error")
        }
    }
    
    func checkIfReachedEndOfPage(for index: Int) async {
        if isThereNextPages && index + 1 == uiModel.characterList.count {
            if !hasReachedEndOfPage {
                await didReachEndOfPage()
                hasReachedEndOfPage = true
            }
        } else {
            hasReachedEndOfPage = false
        }
    }
    
    func didSelctItem(at index: Int) {
        let featureModel = CharacterDetailsFeatureModel(character: characterListDomainModels[index])
        navigation.navigate(to: "characterDetails", arguments: featureModel)
    }
    
    func didApplyFilterType() {
        reset()
        Task {
            await fetchItems(status: uiModel.selectedFilterItem)
        }
    }
    
}

private extension CharacterListViewModel {
    func didReachEndOfPage() async {
        page += 1
        await fetchItems(status: uiModel.selectedFilterItem)
    }
    
    func mapItemUIModel(from characterListDomainModels: [CharacterDomainModel]) -> [CharaterItemUIModel] {
        characterListDomainModels.map { domainModel in
                .init(title: domainModel.name, image: domainModel.image, species: domainModel.species)
        }
    }
    
    func reset() {
        page = 1
        uiModel.characterList = []
        characterListDomainModels = []
    }
    
    func getStatuses(from characters: [CharacterDomainModel]) {
        let characterStatuses = Set(characters.map { $0.status })
        uiModel.characterStatusesList = Array(characterStatuses)
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

