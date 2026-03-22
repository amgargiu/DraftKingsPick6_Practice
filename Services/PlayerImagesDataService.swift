//
//  PlayerImagesDataService.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation
import SwiftUI
import Combine


class PlayerImagesDataService {
    // 1. One shared instance for the whole app
    static let shared = PlayerImagesDataService()
    // Private init prevents making extra copies
    private init() {}
    
    private let fileManager = LocalFileManager.instance
    private let FMFolderName: String = "PlayerImages"
    private var cancellables = Set<AnyCancellable>()
    private var ramCache = NSCache<NSString, UIImage>()

    
    
    // 2. Pass the URL and Name into the function, not the Init
    func getImage(urlString: String?, displayName: String, completion: @escaping (UIImage?) -> Void) { // escaping closure that takes in a UIImage? ?
        
        // 1. Check RAM Cache First
        if let cachedImage = ramCache.object(forKey: displayName as NSString) {
            completion(cachedImage)
            return
        }
        
        if let imageData = fileManager.get(imageName: displayName, folderName: FMFolderName) {
                // 2. DOWNSAMPLE HERE
                let smallImage = downsample(data: imageData, to: CGSize(width: 150, height: 150))
                completion(smallImage)
                return
            }
        
        // Otherwise, Download
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> UIImage? in
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else { return nil }
                return UIImage(data: data)
            }
            .replaceError(with: nil)
            .sink { [weak self] downloadedImage in
                
                guard let image = downloadedImage else { return }
                guard let FMimageName = self?.FMFolderName else { return }

                // Save to Disk for next time
                self?.fileManager.save(image: image, imageName: displayName, folderName: self?.FMFolderName ?? "")
                completion(downloadedImage) // passing closure through...
            }
            .store(in: &cancellables)
    }
    
    
    
    func downsample(data: Data, to pointSize: CGSize) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else { return nil }
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * UIScreen.main.scale
        
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true, // This is what saves the RAM!
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }
        return UIImage(cgImage: downsampledImage)
    }
}




//class PlayerImagesDataService {
//    
//    
//    @Published var playerImage: UIImage?
//    
//    
//    let player : PlayerModel
//    var cancellables: Set<AnyCancellable> = []
//    
////    let cacheManager = CacheManager.instance
//    let fileManager = LocalFileManager.instance
////    let imageCacheKey : String
//    let FMimageName: String
//    let FMFolderName: String = "PlayerImages"
//
//    
//    init(player: PlayerModel) {
//        self.player = player
//        self.FMimageName = player.displayName ?? "unkown"
//        getImage()
//    }
//    
//    
//    func getImage() {
//        // eventually will check FM or Cache first then call download
//        if let image = fileManager.get(imageName: FMimageName, folderName: FMFolderName) {
//            self.playerImage = image
//            print("got player image from FM")
//        } else {
//            downloadImage()
//            print("downloading player image")
//        }
//    }
//    
//    func downloadImage() {
//        
//        guard let urlString = player.image else { return }
//        guard let url = URL(string: urlString) else { return }
//        
//        
//        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .tryMap { (data, response) -> UIImage? in
//                guard
//                    let response = response as? HTTPURLResponse,
//                        response.statusCode >= 200 && response.statusCode < 300
//                else {
//                    throw URLError(.badServerResponse)
//                }
//                return UIImage(data: data) ?? nil
//            }
//            .sink(receiveCompletion: NetworkingManager.handleSinkCompletion, receiveValue: { [weak self] receivedImageData in
//                
//                guard let receivedImageData = receivedImageData else { return }
//                guard let FMimageName = self?.FMimageName else { return }
//                guard let FMfolderName = self?.FMFolderName else { return }
//                
//                // update own publisher
//                self?.playerImage = receivedImageData
//                // save to FM after download
//                self?.fileManager.save(image: receivedImageData, imageName: FMimageName, folderName: FMfolderName) // adding to cache
//                print("added player image FM")
//            })
//            .store(in: &cancellables)
//    }
//}
