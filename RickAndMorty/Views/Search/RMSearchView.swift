//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import UIKit

final class RMSearchView: UIView {

    private let viewModel : RMSearchViewViewModel
    
    private let noResultView = RMNoSearchResultView()
    
    
    init(viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        
    }
    
    private func setup() {
        
        self.backgroundColor = .systemBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(noResultView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //noResultView
                noResultView.widthAnchor.constraint(equalToConstant: 150),
                noResultView.heightAnchor.constraint(equalToConstant: 150),
                noResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
                noResultView.centerYAnchor.constraint(equalTo: centerYAnchor),
                
               
                
            ])
        
    }
    
}

//MARK: - UICollectionViewDelegate

extension RMSearchView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension RMSearchView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}
