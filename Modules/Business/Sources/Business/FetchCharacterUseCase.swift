//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Common

public class FetchCharactersUseCase {
    private let repository: CharactersRepositoryProtocol

    public init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }
 
    public func execute() async -> Result<[CharacterDomainModel], NetworkError> {
        switch await repository.fetchCharacters(in: 1) {
        case .success(let response):
            let characters = response.map { CharacterDomainModel.from($0) }
            return .success(characters)
        case .failure(let error):
            //TODO: check
                print("FetchCharactersUseCase failed in useCase")
            return .failure(.invalidRequest)
        }
    }
}
