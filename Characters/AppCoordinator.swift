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

class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let vc = CharacterListBuilder.build()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
