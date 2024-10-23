//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation

public protocol NetworkingType {
    func request<R: ResourceType>(_ resource: R) async -> Result<R.Response, NetworkError>
}
