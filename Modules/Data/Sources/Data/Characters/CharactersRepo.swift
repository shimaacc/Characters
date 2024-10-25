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
    
    public func fetchCharacters(in page: Int, status: String? = nil) async -> Result<[CharacterItem], NetworkError> {
        var parameters: [RequestParameter] = [RequestParameter(name: "page", value: .query("\(page)"))]
        if let status {
             parameters = [RequestParameter(name: "status", value: .query(status))]
        }
        var resource = CharactersResource(parameters: parameters)
        
        let result: Result<CharactersResource.Response, NetworkError> = await networkingService.request(resource)
        switch result {
        case .success(let data):
            return .success(data.results ?? [])
        case .failure(let error):
            return .failure(error)
        }
    }
}
//TODO: delete it, replace with endpoint, move it to the feature itself
struct CharactersResource: ResourceType {
    let method: HTTPMethod = .get
    let path = "api/character"
    var parameters: [RequestParameter] = []
    
    init(parameters: [RequestParameter]) {
        self.parameters = parameters
    }
    
    func baseURL() -> String {
        return "https://rickandmortyapi.com"
    }
    
    func parse(data: Data, response: HTTPURLResponse) throws -> CharactersListResponse {
        let decoder = JSONDecoder()
        let data = try decoder.decode(CharactersListResponse.self, from: data)
        return data
    }
}
