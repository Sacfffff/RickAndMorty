//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import UIKit

final class RMSearchInputView: UIView {
    
    private var viewModel : RMSearchInputViewViewModel? {
        
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else { return }
            
            createOptionsSelectionViews(options: viewModel.options)
            
        }
        
    }
    
    private let searchBar : UISearchBar = UISearchBar()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        
    }
    
    
    func update(with model: RMSearchInputViewViewModel) {
        
        self.viewModel = model
        
        searchBar.placeholder = model.searchPlaceholderText
        
    }
    
    
    func createOptionsSelectionViews(options: [RMSearchInputViewViewModel.DynamicOptions]) {
        
        options.forEach{
            
            print($0.rawValue)
            
        }
        
    }
    
    private func setup() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        addSubview(searchBar)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //searchBar
                searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                searchBar.leftAnchor.constraint(equalTo: leftAnchor),
                searchBar.rightAnchor.constraint(equalTo: rightAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: 55),
                
            ])
        
    }
    
}
