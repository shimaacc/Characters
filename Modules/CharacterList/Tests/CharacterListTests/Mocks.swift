//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 26.10.2024.
//

import Foundation
import XCTest
import Combine
import Common
@testable import CharacterList

class MockFetchCharacterListUseCase: FetchCharacterListUseCaseProtocol {
    var fetchCharactersResult: Result<PaginatedOutput<[CharacterDomainModel]>, NetworkError>?
    var fetchCharactersCallCount = 0
    
    func fetchCharacters(in page: Int, status: String?) async -> Result<PaginatedOutput<[CharacterDomainModel]>, NetworkError> {
        fetchCharactersCallCount += 1
        return fetchCharactersResult ?? .failure(NetworkError.invalidRequest)
    }
}

class MockNavigation: NavigationProtocol {
    var didNavigateTo: String?
    var didNavigateWithArguments: Any?
    
    func navigate(to destination: String, arguments: Any?) {
        didNavigateTo = destination
        didNavigateWithArguments = arguments
    }
}
