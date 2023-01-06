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
        case .information:
            items = 3
        case .episodes:
            items = 10
        }
        
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
    
    
}
