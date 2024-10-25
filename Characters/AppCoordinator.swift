//
//  AppCoordinator.swift
//  Characters
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit
import CharacterList
import CharacterDetails
import Common
import Network
import Data
import Business

class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    @MainActor
    func start() {
        // it's better to use dependency injection framework
        let network = NetworkingService()
        let charactersRepository = CharactersRepository(networkingService: network)
        let useCase = FetchCharactersUseCase(repository: charactersRepository)
        let navigationController = UINavigationController()
        let navigation = Navigation(navigationController: navigationController)
        let vc = CharacterListBuilder.build(useCase: useCase, navigation: navigation)
        navigationController.viewControllers = [vc]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
