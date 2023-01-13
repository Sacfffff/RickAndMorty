//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import Foundation

/// Type of HTTP Request
enum HTTPMethod : String {
    case get = "GET"
}

/// Object represents a single API call
final class RMRequest {
    
    
    /// API Constant
    struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    let endpoint : RMEndpoint
    
    /// Path Components for API, if any
    private let pathComponents : [String]
    
    /// Query arguments for API, if any
    private let queryParameters : [URLQueryItem]
    
    
    /// Constructed url for api request in string format
    private var urlString : String {
        var string = Constants.baseURL
        string.append("/")
        string.append(endpoint.rawValue)
        
        if !pathComponents.isEmpty {
            pathComponents.forEach{ string.append("/\($0)") }
        }
        
        if !queryParameters.isEmpty {
            string.append("?")
            let argumentString = queryParameters.compactMap{
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            
            string.append(argumentString)
        }
        
        return string
    }
    
    /// Computed and constructed url
    public var url : URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod : HTTPMethod = .get
    
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint:Ttarget endpoint
    ///   - pathComponents: collection of the path components
    ///   - queryParameters: collection of quary parameters
    public init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    /// Attemt to create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        
        let string = url.absoluteString
        if !string.contains(RMRequest.Constants.baseURL) {
            return nil
        }
        
        let trimmedString = string.replacingOccurrences(of: "\(RMRequest.Constants.baseURL)/", with: "")
        if trimmedString.contains("/") {
            let components = trimmedString.components(separatedBy: "/")
            if !components.isEmpty {
                var pathComponents : [String] = []
                
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let rmEndPoint = RMEndpoint(rawValue: components[0]) {
                    self.init(endpoint: rmEndPoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmedString.contains("?") {
            let components = trimmedString.components(separatedBy: "?")
            if !components.isEmpty, let rmEndPoint = RMEndpoint(rawValue: components[0]), components.count >= 2 {
                let queryItemsString = components[1]
                
                let queryItems : [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                
                self.init(endpoint: rmEndPoint,queryParameters: queryItems)
                return
            }
        }
        
        return nil
    }
    
}
