//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 16.01.23.
//

import UIKit


/// Configure controller to search
class RMSearchViewController: UIViewController {
    
    private var config : Config
    
    init(config: Config) {
        
        self.config = config
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
        
        title = "Search"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
    }
    
}

extension RMSearchViewController {
    
    struct Config {
        
        enum ConfigType {
            case episode
            case characters
            case location
        }
        
        let type : ConfigType
    }
    
}
