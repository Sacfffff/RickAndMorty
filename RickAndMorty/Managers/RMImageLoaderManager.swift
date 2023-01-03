//
//  ImageLoaderManager.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 3.01.23.
//

import Foundation

final class RMImageLoaderManager {
    
    static let shared = RMImageLoaderManager()
    
    private init() {}
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    /// Get image content with url
    /// - Parameters:
    ///   - url: Source url
    ///   - completion: Callback
    func downloadImage(with url: URL, completion: @escaping (Result<Data, Error>)->Void) {
        
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else  {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(data))
        }.resume()
    }
}
