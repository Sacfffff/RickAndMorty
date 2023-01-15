//
//  RMService.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import Foundation
import Combine

/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    private let cacheManager = RMAPICacheManager()
    
    ///Privatized constructor
    private init () {}
    
    enum ServiceError : Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - expecting: Type, which you expecting
    ///   - completion: Callback data or error
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        if let cacheData = cacheManager.cacheResponse(for: request.endpoint, url: request.url) {
            
            do{
                let result = try JSONDecoder().decode(type.self, from: cacheData)
                completion(.success(result))
            }  catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            return completion(.failure(RMService.ServiceError.failedToCreateRequest))
            
        }
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return completion(.failure(error ?? RMService.ServiceError.failedToGetData))
            }
            
            do {
                
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setResponse(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod.rawValue
        
        return request
    }
    
}

extension RMService {
    
    public static let listOfCharactersRequest : RMRequest = RMRequest(endpoint: .character)
    public static let listOfEpisidesRequest : RMRequest = RMRequest(endpoint: .episode)
}
