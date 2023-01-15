//
//  RMGetEpisodesResponce.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 15.01.23.
//

import Foundation

struct RMGetAllEpisodesResponce : Codable {
   
    let info : RMGetAllEpisodesResponceInfo
    let results : [RMEpisode]
    
}

struct RMGetAllEpisodesResponceInfo : Codable {
    
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
}
