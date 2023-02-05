//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import Foundation

final class RMSearchViewViewModel {
    
    let config : RMSearchViewController.Config
    
    private var optionMap: [RMSearchInputViewViewModel.DynamicOptions: String] = [:]
    private var optionMapUpdateBlock : ((RMSearchInputViewViewModel.DynamicOptions, String)->Void)?
    
    private var searchText : String = ""
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    
    func set(query text: String) {
        
        self.searchText = text
        
    }
    
    
    func set(value: String, for option: RMSearchInputViewViewModel.DynamicOptions) {
        
        optionMap[option] = value
        self.optionMapUpdateBlock?(option,value)
        
    }
    
    
    func registerOptionChange(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOptions, String)->Void)) {
        
        self.optionMapUpdateBlock = block
        
    }
    
    
    func executeSearch() {
        
        
        
    }
    
}
