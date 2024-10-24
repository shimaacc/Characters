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
        let network = NetworkingService()
        let charactersRepository = CharactersRepository(networkingService: network)
        let useCase = FetchCharactersUseCase(repository: charactersRepository)
        
        let vc = CharacterListBuilder.build(useCase: useCase)
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
