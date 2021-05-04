//
//  ItunesAPI.swift
//  iTunes-Demo
//
//  Created by Miguel Angel on 02-11-20.
//

import Foundation

/*
 Topics to expand:
    - Protocols
    - Enums
    - Computed Property
 */

protocol EndpointType {
    var baseUrl: String { get }
    var path: String { get }
}

enum ItunesAPI {
    case searchArtist(query: String)
    case lookupArtist(id: String)
}

extension ItunesAPI: EndpointType {
    
    var baseUrl: String {
        return "https://itunes.apple.com"
    }
    
    var path: String {
        switch self {
            case .searchArtist(query: let query):
                return "/search?term=\(query)&entity=musicArtist&attribute=artistTerm&media=music"
            case .lookupArtist(id: let id):
                return "/lookup?amgArtistId=\(id)&entity=song&limit=5&sort=recent"
        }
    }
}
