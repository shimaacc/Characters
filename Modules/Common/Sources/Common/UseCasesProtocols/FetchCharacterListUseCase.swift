//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 24.10.2024.
//

import Foundation

public protocol FetchCharacterListUseCaseProtocol {
    func fetchCharacters(in page: Int, status: String?) async -> Result<PaginatedOutput<[CharacterDomainModel]>, NetworkError>
}
