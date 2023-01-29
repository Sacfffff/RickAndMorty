//
//  RMLocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 27.01.23.
//

import Foundation

final class RMLocationTableViewCellViewModel {
  
    var name : String {
        location.name
    }
    
    var type : String {
        "Type \(location.type)"
    }
    
    var dimension : String {
        location.dimension
    }
    
    private let location : RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    
}

extension RMLocationTableViewCellViewModel: Hashable, Equatable {
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(location.id)
        
    }
    

    
}
