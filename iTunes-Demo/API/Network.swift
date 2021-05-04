//
//  Network.swift
//  iTunes-Demo
//
//  Created by Miguel Angel on 03-11-20.
//

import Foundation

/*
 Topics to expand:
    - Generics
    - Closures (important learn about @escaping and @nonescaping)
    - Error Protocol
 */

enum NetworkError: Error {
    case noData
    case failToDecode
    case malformedUrl
    case unknown(_ error: Error)
}

struct Networking {
    
    func performNetworkTask<T: Codable>(endpoint: ItunesAPI, type: T.Type, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) {
        guard let urlRequest = URL(string: endpoint.baseUrl + endpoint.path) else {
            return onError(NetworkError.malformedUrl)
        }
            
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                onError(NetworkError.unknown(error))
            }
            
            guard let data = data else {
                return onError(NetworkError.noData)
            }
            
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return onError(NetworkError.failToDecode)
            }
            onSuccess(decoded)
        }
        urlSession.resume()
    }
}
