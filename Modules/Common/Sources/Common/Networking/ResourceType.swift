//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation

public protocol ResourceType {
    associatedtype Response
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [RequestParameter] { get }

    func baseURL() -> String
    func parse(data: Data, response: HTTPURLResponse) throws -> Response
}
