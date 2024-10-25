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
    public static func build(useCase: FetchCharacterListUseCaseProtocol, navigation: NavigationProtocol) -> UIViewController {
        let viewModel = CharacterListViewModel(useCase: useCase, navigation: navigation)
        let viewController = CharacterListViewController(viewModel: viewModel)
        return viewController
    }
}
