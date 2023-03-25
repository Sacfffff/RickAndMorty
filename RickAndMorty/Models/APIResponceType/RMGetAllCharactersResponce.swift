//
//  RMGetCharactersResponce.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 27.12.22.
//

import Foundation

protocol RMGetAllResponceType : Codable {
    
    associatedtype ResponceInfoType
    associatedtype ResultType
    
    var info : ResponceInfoType { get }
    var results : [ResultType] { get }
    
}

struct RMGetAllCharactersResponce : RMGetAllResponceType {
   
    let info : RMGetAllCharactersResponceInfo
    let results : [RMCharacter]
    
}

struct RMGetAllCharactersResponceInfo : Codable {
    
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
    
}
