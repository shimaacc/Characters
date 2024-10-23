//
//  File.swift
//  
//
//  Created by Shimaa Elcc on 22.10.2024.
//

import Foundation

public protocol URLSessionType {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {}
