//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 26.10.2024.
//

import Foundation

public struct PaginatedOutput<Output> {
    public var output: Output
    public var next: String?
    
    public init(output: Output, next: String? = nil) {
        self.output = output
        self.next = next
    }
}
