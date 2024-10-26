//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 22.10.2024.
//

import Foundation
import Common

public class NetworkingService: NetworkingType {
    private let requestBuilder: RequestBuilderType
    private let urlSession: URLSessionType

    public init(requestBuilder: RequestBuilderType = RequestBuilder(),
                urlSession: URLSessionType = URLSession.shared) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
    }

    public func request<R>(_ resource: R) async -> Result<R.Response, NetworkError> where R: ResourceType {
        let request: URLRequest
        
        do {
            request = try requestBuilder.createURLRequest(for: resource)
        } catch {
            return .failure(.invalidRequest)
        }
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return .failure(.serverError)
            }
            
            let parsedResponse = try resource.parse(data: data, response: httpResponse)
            
            return .success(parsedResponse)
        } catch {
            return .failure(.networkError)
        }
    }
}
