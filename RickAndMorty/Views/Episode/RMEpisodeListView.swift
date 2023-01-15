//
//  RMEpisodeListView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 14.01.23.
//

import UIKit

protocol RMEpisodeListViewDelegate : AnyObject {
    
    func rmEpisodeListViewListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode)
}

/// View that handles showing list of epidodes, loader, ets.
final class RMEpisodeListView: UIView {
    
    var delegate : RMEpisodeListViewDelegate?

    private let viewModel : RMEpisodeListViewViewModelProtocol = RMEpisodeListViewViewModel()
    
    private let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        configureUI()
        spinner.startAnimating()
        viewModel.getAllEpisodes()
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharacterEpisodeCollectionViewCell.self)")
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(RMFooterLoadingCollectionReusableView.self)")
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
        setupViewModel()
        
        addSubviews(collectionView, spinner)
    }
    
    private func setupViewModel() {
        
        viewModel.reloadData = { [weak self] in
            self?.spinner.stopAnimating()
            self?.collectionView.reloadData()
            self?.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.4) {
                self?.collectionView.alpha = 1
            }
        }
        
        viewModel.didSelectEpisode = { [weak self] episode in
            if let self {
                self.delegate?.rmEpisodeListViewListView(self, didSelectEpisode: episode)
            }
        }
        
        viewModel.didLoadMoreEpisodes = { [weak self] newIndexPaths in
            self?.collectionView.performBatchUpdates({
                self?.collectionView.insertItems(at: newIndexPaths)
            })
        }
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
