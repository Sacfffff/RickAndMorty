//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 31.12.22.
//

import UIKit

/// Controller to show info about single character
class RMCharacterDetailViewController: UIViewController {

    private var viewModel : RMCharacterDetailViewModelProtocol
    
    init(viewModel: RMCharacterDetailViewModelProtocol) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .never
    }
    

    

}
