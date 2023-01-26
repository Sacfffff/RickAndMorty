//
//  RMLocationListView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.01.23.
//

import UIKit

final class RMLocationListView: UIView {
    
    private let tableView : UITableView = UITableView()
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private var viewModel : RMLocationListViewViewModelProtocol?  {
        
        didSet {
            
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.tableView.alpha = 1
            }
            
        }
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
        spinner.startAnimating()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    func update(with model: RMLocationListViewViewModelProtocol) {
        
        self.viewModel = model
        
    }
    
    private func setup() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.alpha = 0
        tableView.isHidden = true
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(spinner, tableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //spinner
                spinner.widthAnchor.constraint(equalToConstant: 100.0),
                spinner.heightAnchor.constraint(equalToConstant: 100.0),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                //tableView
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                tableView.leftAnchor.constraint(equalTo: leftAnchor),
                tableView.rightAnchor.constraint(equalTo: rightAnchor),
            ])
    }

  
}
