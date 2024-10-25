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
    var status: String?
    
    public init(repository: CharactersRepositoryProtocol, status: String? = nil) {
        self.repository = repository
        self.status = status
    }
    
    public func fetchCharacters(in page: Int, status: String?) async -> Result<PaginatedOutput<[CharacterDomainModel]>, NetworkError> {
        switch await repository.fetchCharacters(in: page, status: status) {
        case .success(let response):
            if let results = response.results {
                let characters = results.compactMap { CharacterDomainModel.from($0) }
                return .success(.init(output: characters, next: response.info?.next))
            } else  {
                return .failure(NetworkError.invalidRequest)
            }
        case .failure(let error):
            //TODO: check
            print("FetchCharactersUseCase failed in useCase")
            return .failure(NetworkError.networkError)
        }
    }
}

