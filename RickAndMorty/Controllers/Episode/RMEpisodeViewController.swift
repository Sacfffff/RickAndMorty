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

    init(url: URL?){
        
        viewModel = RMEpisodeViewViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        
        title = "Episode"
        view.backgroundColor = .systemBackground
    }

}
