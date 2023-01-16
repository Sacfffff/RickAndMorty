//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Locations"
        
        setup()
    }
    
    private func setup() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonDidTap))
        
    }
    
    @objc private func searchButtonDidTap() {
        
    }

}
