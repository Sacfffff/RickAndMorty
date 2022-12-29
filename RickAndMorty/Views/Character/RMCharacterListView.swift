//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 28.12.22.
//

import UIKit


/// View that handles showing list of characters, loader, ets.
final class RMCharacterListView: UIView {

    private let viewModel : RMCharacterViewViewModelProtocol = RMCharacterViewViewModel()
    
    private let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        configureUI()
        spinner.startAnimating()
        viewModel.getAllCharacters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func configureUI() {
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharactersCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharactersCollectionViewCell.self)")
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.spinner.stopAnimating()
            
            self?.collectionView.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self?.collectionView.alpha = 1
            }
        }
        
        addSubviews(collectionView, spinner)
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
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            ])
    }
}
