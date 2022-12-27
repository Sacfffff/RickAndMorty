//
//  RMGetCharactersResponce.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 27.12.22.
//

import Foundation

struct RMGetAllCharactersResponce : Codable {
   
    let info : RMGetAllCharactersResponceInfo
    let results : [RMCharacter]
    
}

struct RMGetAllCharactersResponceInfo : Codable {
    
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
}
