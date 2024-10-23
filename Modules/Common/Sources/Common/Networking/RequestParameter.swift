//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation

public struct RequestParameter {
    public let name: String
    public let value: Parameter

    public init(name: String, value: Parameter) {
        self.name = name
        self.value = value
    }
}
