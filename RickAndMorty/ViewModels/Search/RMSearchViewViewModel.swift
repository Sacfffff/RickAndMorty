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
    
    private var searchResultHandler : ((RMSearchResultViewModel) -> Void)?
    private var noSearchResultHandler : (() -> Void)?
    
    private var searchText : String = ""
    
    private var searcResultsModel : Codable?
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    
    func locationSearchResults(at index: Int) -> RMLocation? {
        
        guard let locationModel = searcResultsModel as? RMGetAllLocationsResponce else { return nil }
        
        return locationModel.results[index]
        
    }
    
    func episodeSearchResults(at index: Int) -> RMEpisode? {
        
        guard let episodeModel = searcResultsModel as? RMGetAllEpisodesResponce else { return nil }
        
        return episodeModel.results[index]
        
    }
    
    
    func characterSearchResults(at index: Int) -> RMCharacter? {
        
        guard let characterModel = searcResultsModel as? RMGetAllCharactersResponce else { return nil }
        
        return characterModel.results[index]
        
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
    
    
    func registerSearchResultHandler(_ block: @escaping (RMSearchResultViewModel) -> Void) {
        self.searchResultHandler = block
    }
    
    
    func registerNoSearchResultHandler(_ block: @escaping () -> Void) {
        self.noSearchResultHandler = block
    }
    
    
    func executeSearch() {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        var queryParams : [URLQueryItem] = [URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]
        
        queryParams.append(contentsOf: optionMap.compactMap{
            URLQueryItem(name: $0.key.queryArgument, value: $0.value)
        })
        
        let request = RMRequest(endpoint: config.type.endPoint, queryParameters: queryParams)
        
        makeSearchAPICall(config.type.searchResultType, request: request)

    }
    
    private func makeSearchAPICall<T : RMGetAllResponceType>(_ type: T.Type, request: RMRequest) {
        
        RMService.shared.execute(request, expecting: type) { [weak self] result in
            switch result {
            case .success(let model):
                let factory = RMSearchResultFactory(model: model)
                if let type = factory.getType() {
                    self?.searcResultsModel = model
                    self?.searchResultHandler?(RMSearchResultViewModel(result: type, next: factory.getInfo()))
                } else {
                    self?.noSearchResultHandler?()
                }
            case .failure(_):
                self?.noSearchResultHandler?()
            }
        }
        
    }
    
}
