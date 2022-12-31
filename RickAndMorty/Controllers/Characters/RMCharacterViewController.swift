//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
    
    private let characterListView : RMCharacterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setup() {
        
        characterListView.delegate = self
        view.addSubview(characterListView)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //characterListView
                characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                
            ])
    }
}

//MARK: - extension RMCharacterViewController : RMCharacterListViewDelegate

extension RMCharacterViewController : RMCharacterListViewDelegate {
    
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        
        let viewModel = RMCharacterDetailViewModel(character: character)
        let detailVc = RMCharacterDetailViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(detailVc, animated: true)
    }
}
