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
    
    private var searchResultHandler : (() -> Void)?
    
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
    
    
    func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    func executeSearch() {

        var queryParams : [URLQueryItem] = [URLQueryItem(name: "name", value: searchText)]
        
        queryParams.append(contentsOf: optionMap.compactMap{
            URLQueryItem(name: $0.key.queryArgument, value: $0.value)
        })
        
        let request = RMRequest(endpoint: config.type.endPoint, queryParameters: queryParams)
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponce.self) { result in
            switch result {
            case .success(let model):
                print(model.info.count)
            case .failure(let error):
                break
            }
        }
        
    }
    
}
