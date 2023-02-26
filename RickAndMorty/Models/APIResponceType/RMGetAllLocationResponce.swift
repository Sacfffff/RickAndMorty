//
//  RMGetAllLocationResponce.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 27.01.23.
//

import Foundation

struct RMGetAllLocationsResponce : RMGetAllResponceType {
   
    let info : RMGetAllLocationssResponceInfo
    let results : [RMLocation]
    
}

struct RMGetAllLocationssResponceInfo : Codable {
    
    let count : Int
    let pages : Int
    let next : String?
    let prev : String?
    
}
