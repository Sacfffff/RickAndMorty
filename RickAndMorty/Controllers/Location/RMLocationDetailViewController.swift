//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 29.01.23.
//

import UIKit

/// View Controller to show details about single location
final class RMLocationDetailViewController: UIViewController {

    private let location : RMLocation
    
    private var viewModel : RMLocationDetailViewViewModel
    private var detailView : RMLocationDetailView = RMLocationDetailView()

    init(location: RMLocation) {
        
        self.location = location
        let url = URL(string: location.url)
        viewModel = RMLocationDetailViewViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
    private func setup() {
        
        self.view.backgroundColor = .systemBackground
        title = location.name
        navigationItem.largeTitleDisplayMode = .never
        
        detailView.delegate = self
        view.addSubview(detailView)
        
        viewModel.update = { [weak self] in
            if let self {
                self.detailView.setup(with: self.viewModel)
            }
        }
        viewModel.getLocationData()
        
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

extension RMLocationDetailViewController : RMLocationDetailViewDelegate {
    
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        
        let characterVC = RMCharacterDetailViewController(viewModel: RMCharacterDetailViewModel(character: character))
        
        navigationController?.pushViewController(characterVC, animated: true)
        
    }
    
    
}
