//
//  ViewController.swift
//  iTunes-Demo
//
//  Created by Miguel Angel on 02-11-20.
//

import UIKit

/*
 Topics to expand:
    - Delegates
    - Extensions
    - High Order functions
    - Optional Unwraps
 */

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var tracks: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let useCase = UseCase()
        useCase.delegate = self
        
        //useCase.searchArtistResponse(query: "Metallica")
        useCase.lookupTracksArtist(id: "4906")
    }
    
}

extension ViewController: UseCaseOutputDelegate {
    
    func onSuccess(_ results: Codable) {
        
        if let response = results as? SearchArtistResponse {
            showArtist(response)
        }
        
        if let response = results as? LookupTracksArtistResponse {
            lookupTracksArtist(response)
        }
        
    }
    
    func onError(_ error: Error) {
        print(error.localizedDescription)
    }
    
}

extension ViewController {
    
    func lookupTracksArtist(_ response: LookupTracksArtistResponse) {
        let tracks = response.results?.compactMap({ trackResponse -> Track in
            return Track(artist: trackResponse.artistName ?? "DefaultArtist",
                         album: trackResponse.collectionName ?? "DefaultAlbum",
                         name: trackResponse.trackName ?? "DefaultName",
                         previewUrl: trackResponse.previewUrl ?? "DefaulLink",
                         artworkUrl: trackResponse.artworkUrl100 ?? "DefaultArtwork")
        }) ?? []
        self.tracks = tracks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /// Note: Avoid the `!`
    func showArtist(_ response: SearchArtistResponse) {
        let artists = response.results?.map { Artist(id: $0.artistId!, name: $0.artistName!, linkUrl: $0.artistLinkUrl!) }
        artists?.forEach { print($0) }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath)
        cell.textLabel?.text = tracks[indexPath.row].name
        cell.detailTextLabel?.text = tracks[indexPath.row].album
        return cell
    }
    
}
