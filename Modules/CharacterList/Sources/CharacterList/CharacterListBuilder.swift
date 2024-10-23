//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit

public struct CharacterListBuilder {
    public static func build() -> UIViewController {
        let viewModel = CharacterListViewModel()
        let viewController = CharacterListViewController(viewModel: viewModel)
        return viewController
    }
}
