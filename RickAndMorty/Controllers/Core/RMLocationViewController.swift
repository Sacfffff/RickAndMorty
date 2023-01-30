//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {
    
    private var viewModel : RMLocationListViewViewModelProtocol = RMLocationListViewViewModel()
    
    private let locationListView = RMLocationListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Locations"
        
        setup()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
        
    }
    private func setup() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonDidTap))
        
        viewModel.delegate = self
        viewModel.getLocations()
        
        locationListView.delegate = self
        view.addSubview(locationListView)
        
    }
    
    @objc private func searchButtonDidTap() {
        let vc = RMSearchViewController(config: .init(type: .location))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //locationListView
                locationListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                locationListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                locationListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                locationListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                
            ])
    }

}

extension RMLocationViewController : RMLocationListViewDelegate {
    
    func rmLocationListView(_ locationView: RMLocationListView, didSelect location: RMLocation) {
        
        let vc = RMLocationDetailViewController(location: location)
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    

}

extension RMLocationViewController : RMLocationListViewViewModelDelegate {
    
    func rmDidGetLocations() {
        locationListView.update(with: self.viewModel)
    }

    
}
