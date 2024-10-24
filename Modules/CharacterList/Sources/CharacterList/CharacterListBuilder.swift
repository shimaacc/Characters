//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit
import Common

@MainActor
public struct CharacterListBuilder {
     public static func build(useCase: FetchCharacterListUseCaseProtocol) -> UIViewController {
//        let charactersRepository: CharactersRepositoryProtocol = CharactersRepository(networkingService: NetworkingService())

        let viewModel = CharacterListViewModel(useCase: useCase)
        if #available(iOS 16.0, *) {
            let viewController = CharacterListViewController(viewModel: viewModel)
            return viewController
        } else {
            return UIViewController()
        }
       
    }
}
