//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 13.01.23.
//

import Foundation

/// Managers in memory session sciped API caches
final class RMAPICacheManager {
    
    private var cacheDictionary : [RMEndpoint : NSCache<NSString, NSData>] = RMEndpoint.allCases.reduce(into: [:]) { $0[$1] = NSCache<NSString, NSData>() }
    
    private var cache = NSCache<NSString, NSData>()
    
    init() {
        
    }
    
    func setResponse(for endPoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endPoint], let url = url else { return }
        
        let key = url.absoluteString as NSString
        
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    func cacheResponse(for endPoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endPoint], let url = url else { return nil }
        
        let key = url.absoluteString as NSString
        
        return targetCache.object(forKey: key) as? Data
    }
}
