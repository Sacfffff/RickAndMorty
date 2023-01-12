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
    
    private let detailView : RMCharacterDetailView
    
    init(viewModel: RMCharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }

    private func setupView() {
        
        view.backgroundColor = .secondarySystemBackground
        title = viewModel.title
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        detailView.colectionView?.delegate = self
        detailView.colectionView?.dataSource = self
        view.addSubview(detailView)
        
    }
    
    
    @objc private func didTapShare() {
        
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //detailView
                detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                
            ])
    }

}

//MARK: - extension UICollectionViewDelegate

extension RMCharacterDetailViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        switch viewModel.sections[indexPath.section] {
           
        case .photo, .information:
           break
        case .episodes:
            let episodeString = self.viewModel.episodes[indexPath.row]
            guard let episodeURL =  URL(string: episodeString) else { return }
            navigationController?.pushViewController(RMEpisodeViewController(url: episodeURL), animated: true)
            
        }
    }
}

//MARK: - extension UICollectionViewDataSource
extension RMCharacterDetailViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let items : Int
        
        switch viewModel.sections[section] {
           
        case .photo:
            items = 1
        case .information(let infoModel):
            items = infoModel.count
        case .episodes(let episodesModel):
            items = episodesModel.count
        }
        
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch viewModel.sections[indexPath.section] {
           
        case .photo(let photoModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharacterPhotoCollectionViewCell.self)", for: indexPath) as? RMCharacterPhotoCollectionViewCell else { return .init() }
            cell.configure(with: photoModel)
            return cell
        case .information(let infoModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharacterInfoCollectionViewCell.self)", for: indexPath) as? RMCharacterInfoCollectionViewCell else { return .init() }
            cell.configure(with: infoModel[indexPath.row])
            return cell
        case .episodes(let episodesModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharacterEpisodeCollectionViewCell.self)", for: indexPath) as? RMCharacterEpisodeCollectionViewCell else { return .init() }
            cell.configure(with: episodesModel[indexPath.row])
            return cell
        }
            
        }
}
