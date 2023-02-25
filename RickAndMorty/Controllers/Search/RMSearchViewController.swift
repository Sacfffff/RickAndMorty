//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 16.01.23.
//

import UIKit


/// Configure controller to search
class RMSearchViewController: UIViewController {
    
    private let viewModel : RMSearchViewViewModel
    
    private let searchView : RMSearchView
    
    init(config: Config) {
        
        self.viewModel = RMSearchViewViewModel(config: config)
        self.searchView = RMSearchView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchView.presentKeyboard()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
        
    }
    
    private func setup() {
        
        title = viewModel.config.type.rawValue
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        searchView.selectedOption = { [weak self] option in
            let vc = RMSearchOptionPickerViewController(option: option) { [weak self] selection in
                DispatchQueue.main.async {
                    self?.viewModel.set(value: selection, for: option)
                }
            }
            vc.sheetPresentationController?.prefersGrabberVisible = true
            vc.sheetPresentationController?.detents = [.medium()]
            self?.present(vc, animated: true)
        }
        view.addSubview(searchView)
        
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //searchView
                searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                
               
                
            ])
        
    }
    
}

extension RMSearchViewController {
    
    /// Configuration for search session
    struct Config {
        
        enum ConfigType : String {
            case episode = "Search Episodes"
            case characters = "Search Character"
            case location = "Search Location"
            
            var endPoint : RMEndpoint {
                
                let endPont : RMEndpoint
                
                switch self {
                    
                case .episode:
                    endPont = .episode
                case .characters:
                    endPont = .character
                case .location:
                    endPont = .location
                }
                
                return endPont
                
            }
            
        }
        
        let type : ConfigType
    }
    
}
