//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 13.01.23.
//

import UIKit

protocol RMEpisodeDetailViewDelegate : AnyObject {
    
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter)
    
}

final class RMEpisodeDetailView: UIView {
    
    weak var delegate : RMEpisodeDetailViewDelegate?

    private var viewModel : RMEpisodeViewViewModelProtocol? {
        didSet {
            spinner.stopAnimating()
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.collectionView.alpha = 1
            }
        }
    }
    
    private let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    func setup(with viewModel: RMEpisodeViewViewModelProtocol) {
        
        self.viewModel = viewModel
       
        
    }
    
    private func configureUI() {
        
        self.backgroundColor = .systemBackground
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        addSubview(spinner)
        
        let layout = UICollectionViewCompositionalLayout { [weak self] section, _ in
            return self?.layout(for: section)
        }
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alpha = 0
        collectionView.register(RMEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMEpisodeInfoCollectionViewCell.self)")
        collectionView.register(RMCharactersCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharactersCollectionViewCell.self)")
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
    }
    

    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            
            [
                //collection
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                collectionView.rightAnchor.constraint(equalTo: rightAnchor),
                
                //spinner
                spinner.heightAnchor.constraint(equalToConstant: 100),
                spinner.widthAnchor.constraint(equalToConstant: 100),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            ]
            
        )
    }

}

//MARK: -  UICollectionViewDelegate

extension RMEpisodeDetailView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let viewModel = viewModel, let character = viewModel.character(at: indexPath.row) else { return  }
       
        let section = viewModel.cellViewModels[indexPath.section]
        
        switch section {
            
        case .information:
            break
        case .characters:
            delegate?.rmEpisodeDetailView(self, didSelect: character)
        }
        
    }
    
}

//MARK: -  UICollectionViewDataSource

extension RMEpisodeDetailView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let viewModel = viewModel else { return 0  }
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sections = viewModel?.cellViewModels else { return 0  }
       
        let section = sections[section]
        
        switch section {
            
        case .information(viewModels: let viewModels):
            return viewModels.count
        case .characters(viewModels: let viewModels):
            return viewModels.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sections = viewModel?.cellViewModels else { return .init() }
        
        let section = sections[indexPath.section]
        
        switch section {
            
        case .information(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMEpisodeInfoCollectionViewCell.self)", for: indexPath) as? RMEpisodeInfoCollectionViewCell else { return .init() }
            cell.setup(with: viewModels[indexPath.row])
            return cell
        case .characters(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharactersCollectionViewCell.self)", for: indexPath) as? RMCharactersCollectionViewCell else { return .init() }
            cell.setup(viewModel: viewModels[indexPath.row])
            return cell
        }
    }
    
    
}


extension RMEpisodeDetailView {
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {return createInfoSection() }
        
        switch sections[section] {
            
        case .information:
            return createInfoSection()
        case .characters:
            return createCharactersLayout()
        }
      
    }
    
    private func createInfoSection() -> NSCollectionLayoutSection {
        
        let width : CGFloat = 1
        var height : CGFloat = 1
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(height)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        height = 80
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .absolute(height)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
    }
    
    private func createCharactersLayout() -> NSCollectionLayoutSection {
        
        var width : CGFloat = UIDevice.isIPhone ? 0.5 : 0.25
        var height : CGFloat = 1
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        height = UIDevice.isIPhone ? 260 : 320
        width = 1.0
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .absolute(height)),
                                                       subitems: UIDevice.isIPhone ? [item, item] : [item, item, item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
        
    }
    
}

extension RMEpisodeDetailView {
    
    enum SectionType {
        
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharactersCollectionViewCellViewModel])
        
    }
    
}
