//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

/// Controller to show and search for Episodes
final class RMEpisodesViewController: UIViewController {
    
    private let episodeListView : RMEpisodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episodes"
        
        setup()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setup() {
        
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonDidTap))
        
    }
    
    @objc private func searchButtonDidTap() {
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //episodeListView
                episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                
            ])
    }
}

//MARK: - extension RMCharacterViewController : RMCharacterListViewDelegate

extension RMEpisodesViewController : RMEpisodeListViewDelegate {
    
    func rmEpisodeListViewListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        
        let detailVC = RMEpisodeViewController(url: URL(string: episode.url))
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
