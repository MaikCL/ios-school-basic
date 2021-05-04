//
//  Response.swift
//  iTunes-Demo
//
//  Created by Miguel Angel on 02-11-20.
//

import Foundation

/*
 Topics to expand:
    - Codable and JSONDecoder
    - Generics
    - Extensions
 */

struct Response {
    private var data: Data
    
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch {
            return nil
        }
        
    }
}
