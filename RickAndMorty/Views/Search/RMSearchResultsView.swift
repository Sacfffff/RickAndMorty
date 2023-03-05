//
//  RMSearchResultsView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 5.03.23.
//

import UIKit

/// Shows search results UI ( table or collection as needed)
class RMSearchResultsView: UIView {
    
    private var viewModel : RMSearchResultType? {
        didSet {
            self.proceedViewModel()
        }
    }
    
    private let tableView : UITableView = UITableView()
    
    
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
    
    
    func update(with model: RMSearchResultType) {
        
    }
    
    
    private func setup() {
        
        isHidden = true
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: "\(RMLocationTableViewCell.self)")
        tableView.isHidden = true
        
        self.addSubviews(tableView)
        
    }
    
    
    private func proceedViewModel() {
        
        guard let viewModel else { return }
        
        switch viewModel {
            
        case .characters(let charactersViewModel):
            self.setupCollectionView()
        case .locations(let locationViewModel):
            self.setupTableView()
        case .episodes(let episodesViewModel):
            self.setupCollectionView()
        }
        
    }
    
    
    private func setupCollectionView() {
        
    }
    
    
    private func setupTableView() {
        
        self.tableView.isHidden = false
        
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //tableView
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.leftAnchor.constraint(equalTo: leftAnchor),
                tableView.rightAnchor.constraint(equalTo: rightAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
            ])
        
    }

}
