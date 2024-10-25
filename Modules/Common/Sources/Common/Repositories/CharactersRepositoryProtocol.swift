//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation

public protocol CharactersRepositoryProtocol {
    func fetchCharacters(in page: Int, status: String?) async -> Result<CharactersListResponse, NetworkError>
}
