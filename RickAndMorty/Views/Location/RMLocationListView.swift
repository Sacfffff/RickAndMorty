//
//  RMLocationListView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.01.23.
//

import UIKit

protocol RMLocationListViewDelegate : AnyObject {
    
    func rmLocationListView(_ locationView: RMLocationListView, didSelect location: RMLocation)
    
}

final class RMLocationListView: UIView {
    
    weak var delegate : RMLocationListViewDelegate?
    
    private let tableView : UITableView = UITableView(frame: .zero, style: .grouped)
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private var viewModel : RMLocationListViewViewModelProtocol?  {
        
        didSet {
            
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            
            UIView.animate(withDuration: 0.3) { 
                self.tableView.alpha = 1
            }
            
            viewModel?.registerPaginationDidFinishBlock({ [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.tableFooterView = nil
                }
            })
            
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
        tableView.alpha = 0
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: "\(RMLocationTableViewCell.self)")
        tableView.isHidden = true
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.dataSource = self
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(tableView, spinner)
        
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

//MARK: - UITableViewDelegate

extension RMLocationListView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let location = viewModel?.location(at: indexPath.row) else { fatalError() }
        
        delegate?.rmLocationListView(self, didSelect: location)
    }
    
}

//MARK: - UITableViewDataSource

extension RMLocationListView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellViewModel = viewModel?.cellViewModels[indexPath.row] else { fatalError() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMLocationTableViewCell.self)", for: indexPath) as? RMLocationTableViewCell else { fatalError() }
        
        cell.update(with: cellViewModel)
        
        
        return cell

    }
    
    
}

//MARK: - UIScrollViewDelegate

extension RMLocationListView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel,
              !viewModel.cellViewModels.isEmpty,
              viewModel.hasMoreResults else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            let footerHeightPlusBuffer : CGFloat = 120
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - footerHeightPlusBuffer) {
                DispatchQueue.main.async {
                    self?.showLoadingIndicator()
                }
                self?.viewModel?.getAdditionalLocations()
               
            }
            
            t.invalidate()
        }
    }

    
    private func showLoadingIndicator() {
        
        let footer = RMTableLoadingFooterView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        tableView.tableFooterView = footer
        
    }
    
}
