//
//  LockupResponse.swift
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

struct LookupTracksArtistResponse: Codable {
    var resultCount: Int?
    var results: [TrackResponse]?
}

struct TrackResponse: Codable {
    var wrapperType: String?
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    var previewUrl: String?
    var artworkUrl100: String?
}
