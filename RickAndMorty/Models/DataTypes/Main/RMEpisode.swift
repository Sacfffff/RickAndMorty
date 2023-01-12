//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import Foundation

struct RMEpisode : Codable {
    
    private enum CodingKeys : String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
    
    let id : Int
    let name : String
    let airDate : String
    let episode : String
    let characters : [String]
    let url : String
    let created : String
}
