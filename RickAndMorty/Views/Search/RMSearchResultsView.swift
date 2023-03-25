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
    
    private let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    weak var delegate : RMSearchResultsViewDelegate?
    
    private var locationCellViewModels : [RMLocationTableViewCellViewModel] = []
    private var collectionsCellViewModels : [any Hashable] = []
    
    private var viewModel : RMSearchResultViewModel? {
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
    
    
    func update(with model: RMSearchResultViewModel) {
        
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
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = layout
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharacterEpisodeCollectionViewCell.self)")
        collectionView.register(RMCharactersCollectionViewCell.self, forCellWithReuseIdentifier: "\(RMCharactersCollectionViewCell.self)")
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(RMFooterLoadingCollectionReusableView.self)")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubviews(tableView, collectionView)
        
    }
    
    
    private func proceedViewModel() {
        
        guard let viewModel else { return }
        
        switch viewModel.result {
            
        case .characters(let charactersViewModel):
            self.collectionsCellViewModels = charactersViewModel
            self.setupCollectionView()
        case .locations(let locationViewModel):
            self.setupTableView(model: locationViewModel)
        case .episodes(let episodesViewModel):
            self.collectionsCellViewModels = episodesViewModel
            self.setupCollectionView()
        }
        
    }
    
    
    private func setupCollectionView() {
        
        self.collectionView.isHidden = false
        self.tableView.isHidden = true
        
        collectionView.reloadData()
        
    }
    
    
    private func setupTableView(model: [RMLocationTableViewCellViewModel]) {
        
        self.locationCellViewModels = model
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
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
                
                //collectionView
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                collectionView.rightAnchor.constraint(equalTo: rightAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
            ])
        
    }

}

//MARK: - extension UICollectionViewDataSource, UICollectionViewDelegate

extension RMSearchResultsView :  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionsCellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let models = collectionsCellViewModels[indexPath.row]
        
        if let model = models as? RMCharactersCollectionViewCellViewModel {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharactersCollectionViewCell.self)", for: indexPath) as? RMCharactersCollectionViewCell else { fatalError() }
            cell.setup(viewModel: model)
            return cell
            
        } else if let model = models as? RMCharacterEpisodeCellViewModel {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharacterEpisodeCollectionViewCell.self)", for: indexPath) as? RMCharacterEpisodeCollectionViewCell else { fatalError() }
            cell.setup(with:  model)
            return cell
        }
        
        return .init()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds : CGRect = collectionView.bounds
        let width : CGFloat
        let height : CGFloat
        
        if collectionsCellViewModels[indexPath.row] is RMCharactersCollectionViewCellViewModel {
            width = (bounds.width - 30) / 2
            height = width * 1.5
            
        } else {
            width = bounds.width - 20
            height = 100
        }
        
        return CGSize(width: width, height: height)
    }
    
}

//MARK: - extension UITableViewDataSource, UITableViewDelegate

extension RMSearchResultsView : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        self.delegate?.rmSearchResultsView(self, didSelectLocationAt: indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        locationCellViewModels.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RMLocationTableViewCell.self)", for: indexPath) as? RMLocationTableViewCell else { fatalError() }
        
        cell.update(with: locationCellViewModels[indexPath.row])
        
        return cell
        
    }
    
    
}

//MARK: - UIScrollViewDelegate

extension RMSearchResultsView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel,
              !locationCellViewModels.isEmpty,
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
                self?.viewModel?.getAdditionalLocations { newResults in
                    self?.tableView.tableFooterView = nil
                    self?.locationCellViewModels = newResults
                    self?.tableView.reloadData()
                }
                
            }
            
            t.invalidate()
            
        }
       
    }

    
    private func showLoadingIndicator() {
        
        let footer = RMTableLoadingFooterView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        tableView.tableFooterView = footer
        
    }
    
}
