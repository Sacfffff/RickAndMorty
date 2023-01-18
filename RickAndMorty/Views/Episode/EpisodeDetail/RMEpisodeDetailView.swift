//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 13.01.23.
//

import UIKit

final class RMEpisodeDetailView: UIView {

    private var viewModel : RMEpisodeViewViewModelProtocol? {
        didSet {
            spinner.stopAnimating()
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alpha = 0
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
    }
    
}

//MARK: -  UICollectionViewDataSource

extension RMEpisodeDetailView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}


extension RMEpisodeDetailView {
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        
        let width : CGFloat = 1
        var height : CGFloat = 1
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .fractionalHeight(height)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        height = 100
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
}

fileprivate extension RMEpisodeDetailView {
    
    enum SectionType {
        
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharactersCollectionViewCellViewModel])
        
    }
    
}
