//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 4.01.23.
//

import UIKit

/// View for single character info
class RMCharacterDetailView: UIView {
    
    private let _collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    weak var colectionView : UICollectionView? {
        return _collectionView
    }
    
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private let viewModel: RMCharacterDetailViewModelProtocol
    
    init(frame: CGRect, viewModel: RMCharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    private func setupView() {
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] index, _ in
            self?.createSectionFor(for: index)
        })
        _collectionView.collectionViewLayout = layout
        _collectionView.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharacterPhotoCollectionViewCell.self)")
        _collectionView.register(RMCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharacterInfoCollectionViewCell.self)")
        _collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharacterEpisodeCollectionViewCell.self)")
        _collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(spinner, _collectionView)
    }
    
    private func createSectionFor(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let sectionType = viewModel.sections[sectionIndex]
        let section : NSCollectionLayoutSection
        switch sectionType {
        case .photo:
            section = viewModel.createPhotoSectionLayout()
        case .episodes:
            section = viewModel.createEpisodesSectionLayout()
        case .information:
            section = viewModel.createInformationSectionLayout()
        }
        
        return section
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //spinner
                spinner.widthAnchor.constraint(equalToConstant: 100.0),
                spinner.heightAnchor.constraint(equalToConstant: 100.0),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                //collectionView
                _collectionView.topAnchor.constraint(equalTo: topAnchor),
                _collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                _collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                _collectionView.rightAnchor.constraint(equalTo: rightAnchor),
                
            ])
    }
    
}
