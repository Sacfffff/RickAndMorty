//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        RMService.shared.execute(RMService.listOfCharactersRequests, expecting: RMGetAllCharactersResponce.self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
    }
    
  
}
