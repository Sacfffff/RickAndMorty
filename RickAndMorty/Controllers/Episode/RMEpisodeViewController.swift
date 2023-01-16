//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 12.01.23.
//

import UIKit

/// View Controller to show details about single episode
final class RMEpisodeViewController: UIViewController {
    
    private var viewModel : RMEpisodeViewViewModelProtocol
    private var detailView : RMEpisodeDetailView = RMEpisodeDetailView()

    init(url: URL?){
        
        viewModel = RMEpisodeViewViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        
        title = "Episode"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonDidTapped))
        
        view.addSubview(detailView)
    }
    
    @objc private func shareButtonDidTapped() {
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //detailView
                detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                
            ])
    }

}
