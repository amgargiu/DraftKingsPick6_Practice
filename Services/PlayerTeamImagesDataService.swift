//
//  TeamImagesDataService.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/8/26.
//

import Foundation
import SwiftUI
import Combine



class PlayerTeamImagesDataService: ObservableObject {
    // 1. One shared instance for the whole app
    static let shared = PlayerTeamImagesDataService()
    @Published var teamdict: [String: UIImage] = [:]
    
    // Private init prevents making extra copies
    private init() {
    }
    
    private let fileManager = LocalFileManager.instance
    private let FMFolderName: String = "PlayerTeamImages"
    private var cancellables = Set<AnyCancellable>()
    private var ramCache = NSCache<NSString, UIImage>()

    
    func getTeamImages(urlString: String?, displayTeam: String, completion: @escaping (UIImage?) -> Void) {
        
        
        // 1. Check RAM Cache First
            // The cache stores UIImages, NOT Data.
            if let cachedImage = ramCache.object(forKey: displayTeam as NSString) {
                print("Using RAM Cache for: \(displayTeam) image")
                // NO DOWNSAMPLING NEEDED. It's already an image!
                teamdict[displayTeam] = cachedImage
                completion(cachedImage)
                return
            }
        
        // Check File Manager First
        if let imageData = fileManager.get(imageName: displayTeam, folderName: FMFolderName) {
            // This takes the 2MB of Data and turns it into a 100KB UIImage
            print("Using FM for \(displayTeam) image")
            let smallImage = downsample(data: imageData, to: CGSize(width: 150, height: 150))
            teamdict[displayTeam] = smallImage
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
                guard let FMFolderName = self?.FMFolderName else { return }
                
                let smallImage = self?.downsample(data: image.pngData() ?? Data(), to: CGSize(width: 150, height: 150)) ?? image
                    
                DispatchQueue.main.async {
                    // 2. Save the SMALL version to RAM
                    self?.teamdict[displayTeam] = smallImage
                    print("added \(displayTeam) to teamdict")
                    
                    // 3. Save the SMALL version to Disk
                    self?.fileManager.save(image: smallImage, imageName: displayTeam, folderName: FMFolderName)
                    
                    completion(smallImage)
                }
                
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


//class PlayerTeamImagesDataService {
//    
//    @Published var playerTeamImage: UIImage?
//    let player : PlayerModel
//    var cancellables: Set<AnyCancellable> = []
//    
//    let cacheManager = CacheManager.instance
//    let imageCacheKey: String
//
//    
//    init(player: PlayerModel) {
//        self.player = player
//        self.imageCacheKey = player.team ?? "unkown"
//        getImage()
//    }
//    
//    
//    func getImage() {
//        // eventually will check FM or Cache first then call download
//        if let image = cacheManager.get(key: imageCacheKey) {
//            self.playerTeamImage = image
//            print("got player team image from cache \(imageCacheKey)")
//        } else {
//            downloadImage()
//            print("downloading player team image \(imageCacheKey)")
//        }
//    }
//    
//    func downloadImage() {
//        
//        guard let urlString = player.teamImage else { return }
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
//                guard let receivedImageData = receivedImageData else { return }
//                guard let imageCacheKey = self?.imageCacheKey else { return }
//                self?.playerTeamImage = receivedImageData
//                self?.cacheManager.add(key: imageCacheKey, image: receivedImageData) // adding to cache
//                print("added player team image to cache \(imageCacheKey)")
//            })
//            .store(in: &cancellables)
//    }
//    
//    
//}
