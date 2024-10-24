//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation
import Common

//TODO: need to conform to protocol
public class FetchCharactersUseCase: FetchCharacterListUseCaseProtocol {
    
    private let repository: CharactersRepositoryProtocol
    
    public init(repository: CharactersRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchCharacters(in page: Int) async -> Result<[CharacterDomainModel], NetworkError> {
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

