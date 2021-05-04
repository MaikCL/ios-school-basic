//
//  SearchResponse.swift
//  iTunes-Demo
//
//  Created by Miguel Angel on 02-11-20.
//

import Foundation

/*
 Topics to expand:
    - Codable
    - Structs
    - Optionals
 */

struct SearchArtistResponse: Codable {
    var resultCount: Int?
    var results: [ArtistResponse]?
}

struct ArtistResponse: Codable {
    var wrapperType: String?
    var artistType: String?
    var artistName: String?
    var artistLinkUrl: String?
    var artistId: Int?
    var amgArtistId: Int?
    var primaryGenreName: String?
    var primaryGenreId: Int?
}
