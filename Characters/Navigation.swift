//
//  Navigation.swift
//  Characters
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation
import Common
import CharacterList
import CharacterDetails
import UIKit

class Navigation: NavigationProtocol {
    private var navigationController: UINavigationController
    
    @MainActor
    func navigate(to destination: String, arguments: Any?) {
        switch destination {
        case "characterDetails":
            guard let arguments = arguments as? CharacterDetailsFeatureModel else { return }
            
            let vc = CharacterDetailsBuilder.build(featureModel: arguments)
            vc.modalPresentationStyle = .fullScreen
            navigationController.present(vc, animated: true)
        default:
            break
        }
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
