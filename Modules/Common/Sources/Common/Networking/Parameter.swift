//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import Foundation

public enum Parameter {
    /**
        URL-encoded query parameter
    ```
        // Definition Example
        var parameters: [RequestParameter] {
            return [
                .init(name: "pageId", value: .query("2")),
            ]
        }
    ```
    */
    case query(String)
    
    /// Potentially, we can introduce other parameter types, like .header
    /// and builder will be responsible for mapping it
}
