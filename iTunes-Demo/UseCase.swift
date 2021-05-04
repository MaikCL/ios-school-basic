//
//  UseCase.swift
//  iTunes-Demo
//
//  Created by Miguel Angel on 03-11-20.
//

import Foundation

/*
 Topics to expand:
    - Delegates
    - Retain Cycle in delegates with weak
 */

protocol UseCaseOutputDelegate: AnyObject {
    func onSuccess(_ results: Codable)
    func onError(_ error: Error)
}

class UseCase {
    weak var delegate: UseCaseOutputDelegate?
    private let networking = Networking()

    func searchArtistResponse(query: String) {
        print ("Connecting iTunes Api...")
        networking.performNetworkTask(endpoint: .searchArtist(query: query), type: SearchArtistResponse.self,
        onSuccess: { response in
            self.delegate?.onSuccess(response)
            print ("Finish iTunes Api Success")
        },
        onError: { error in
            self.delegate?.onError(error)
            print ("Finish iTunes Api Error")
        })
    }
    
    func lookupTracksArtist(id: String) {
        print ("Connecting iTunes Api...")
        networking.performNetworkTask(endpoint: .lookupArtist(id: id), type: LookupTracksArtistResponse.self,
        onSuccess: { response in
            self.delegate?.onSuccess(response)
            print ("Finish iTunes Api Success")
        },
        onError: { error in
            self.delegate?.onError(error)
            print ("Finish iTunes Api Error")
        })
    }
}

