//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 31.12.22.
//

import UIKit


enum SectionType {
    
    case photo(viewModel: RMCharacterPhotoCellViewModelProtocol)
    case information(viewModel: [RMCharacterInfoCellViewModelProtocol])
    case episodes(viewModel: [RMCharacterEpisodeCellViewModelProtocol])
}

protocol RMCharacterDetailViewModelProtocol {
    
    var title : String {get}
    var sections : [SectionType] {get}
    
    func createPhotoSectionLayout() -> NSCollectionLayoutSection
    func createInformationSectionLayout() -> NSCollectionLayoutSection
    func createEpisodesSectionLayout() -> NSCollectionLayoutSection
}

final class RMCharacterDetailViewModel : RMCharacterDetailViewModelProtocol {
    
    var sections : [SectionType] = []
    
    var title : String {
        character.name.uppercased()
    }
    
    private var requestURL : URL? {
        URL(string: character.url)
    }
    
    private let character : RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
        setupSections()
    }
    
    
    private func setupSections() {
        
        sections =
        [
            .photo(viewModel: RMCharacterPhotoCellViewModel(imageURL: URL(string: character.image))),
            .information(viewModel:
            [
                RMCharacterInfoCellViewModel(value: character.status.rawValue, title: "Status"),
                RMCharacterInfoCellViewModel(value: character.gender.rawValue, title: "Gender"),
                RMCharacterInfoCellViewModel(value: character.type, title: "Type"),
                RMCharacterInfoCellViewModel(value: character.species, title: "Species"),
                RMCharacterInfoCellViewModel(value: character.origin.name, title: "Origin"),
                RMCharacterInfoCellViewModel(value: character.location.name, title: "Location"),
                RMCharacterInfoCellViewModel(value: character.created, title: "Created"),
                RMCharacterInfoCellViewModel(value: "\(character.episode.count)", title: "Total Episodes"),
                
           
            ]),
            .episodes(viewModel: character.episode.compactMap{ RMCharacterEpisodeCellViewModel(episodeDataURL: URL(string: $0))})
        ]
    }
    
    //MARK: - Layout
    
    
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let width : CGFloat = 1
        var height : CGFloat = 1
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        height = 0.5
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height)),
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createInformationSectionLayout() -> NSCollectionLayoutSection {
        
        var width : CGFloat = 0.5
        var height : CGFloat = 1
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        height = 150
        width = 1.0
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .absolute(height)),
                                                     subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        
        var width : CGFloat = 1
        var height : CGFloat = 1
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        
        height = 150
        width = 0.8
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .absolute(height)),
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
}
