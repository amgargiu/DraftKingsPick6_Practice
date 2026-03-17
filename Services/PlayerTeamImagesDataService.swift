//
//  TeamImagesDataService.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation
import SwiftUI
import Combine


class PlayerTeamImagesDataService {
    
    @Published var playerTeamImage: UIImage?
    let player : PlayerModel
    var cancellables: Set<AnyCancellable> = []
    
    let cacheManager = CacheManager.instance
    let imageCacheKey: String

    
    init(player: PlayerModel) {
        self.player = player
        self.imageCacheKey = player.team ?? "unkown"
        getImage()
    }
    
    
    func getImage() {
        // eventually will check FM or Cache first then call download
        if let image = cacheManager.get(key: imageCacheKey) {
            self.playerTeamImage = image
            print("got player team image from cache")
        } else {
            downloadImage()
            print("downloading player team image")
        }
    }
    
    func downloadImage() {
        
        guard let urlString = player.teamImage else { return }
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> UIImage? in
                guard
                    let response = response as? HTTPURLResponse,
                        response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(.badServerResponse)
                }
                return UIImage(data: data) ?? nil
            }
            .sink(receiveCompletion: NetworkingManager.handleSinkCompletion, receiveValue: { [weak self] receivedImageData in
                guard let receivedImageData = receivedImageData else { return }
                guard let imageCacheKey = self?.imageCacheKey else { return }
                self?.playerTeamImage = receivedImageData
                self?.cacheManager.add(key: imageCacheKey, image: receivedImageData) // adding to cache
                print("added player team image to cache")
            })
            .store(in: &cancellables)
    }
    
    
}
