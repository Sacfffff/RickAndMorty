//
//  RMSearchResultsView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 5.03.23.
//

import UIKit

protocol RMSearchResultsViewDelegate : AnyObject {
    
    func rmSearchResultsView(_ resultView: RMSearchResultsView, didSelectLocationAt index: Int)
    
}

/// Shows search results UI ( table or collection as needed)
class RMSearchResultsView: UIView {
    
    weak var delegate : RMSearchResultsViewDelegate?
    
    private var locationCellViewModels : [RMLocationTableViewCellViewModel] = []
    
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
        
        self.viewModel = model
        
    }
    
    
    private func setup() {
        
        isHidden = true
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: "\(RMLocationTableViewCell.self)")
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        self.addSubviews(tableView)
        
    }
    
    
    private func proceedViewModel() {
        
        guard let viewModel else { return }
        
        switch viewModel {
            
        case .characters(let charactersViewModel):
            self.setupCollectionView()
        case .locations(let locationViewModel):
            self.setupTableView(model: locationViewModel)
        case .episodes(let episodesViewModel):
            self.setupCollectionView()
        }
        
    }
    
    
    private func setupCollectionView() {
        
    }
    
    
    private func setupTableView(model: [RMLocationTableViewCellViewModel]) {
        
        self.locationCellViewModels = model
        self.tableView.isHidden = false
        self.tableView.reloadData()
        
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

//MARK: - extension UITableViewDelegate

extension RMSearchResultsView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        self.delegate?.rmSearchResultsView(self, didSelectLocationAt: indexPath.row)
        
    }
    
}

//MARK: - extension UITableViewDataSource

extension RMSearchResultsView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        locationCellViewModels.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMLocationTableViewCell.self)", for: indexPath) as? RMLocationTableViewCell else { fatalError() }
        
        cell.update(with: locationCellViewModels[indexPath.row])
        
        return cell
        
    }
    
    
}
