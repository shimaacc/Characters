//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation
import UIKit
import Common

@MainActor
public struct CharacterDetailsBuilder {
    public static func build(featureModel: CharacterDetailsFeatureModel) -> UIViewController {
        let viewModel = CharacterDetailsViewModel(featureModel: featureModel)
        let viewController = CharacterDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
