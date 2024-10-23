//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 22.10.2024.
//

import Foundation
import Common

public class CharactersRepository: CharactersRepositoryProtocol {
    private let networkingService: NetworkingType

    public init(networkingService: NetworkingType) {
        self.networkingService = networkingService
    }

    public func fetchCharacters(in page: Int) async -> Result<[CharacterItem], NetworkError> {
        let resource = CharactersResource()
        return await networkingService.request(resource)
    }
}

//TODO: delete it, replace with endpoint, move it to the feature itself
struct CharactersResource: ResourceType {
    let method: HTTPMethod = .get
    let path = "api/character"
    let parameters: [RequestParameter] = []
    
    func baseURL() -> String {
        return "https://rickandmortyapi.com"
    }
    
    func parse(data: Data, response: HTTPURLResponse) throws -> [CharacterItem] {
        let decoder = JSONDecoder()
        let data = try decoder.decode([CharacterItem].self, from: data)
        return data
    }
}
