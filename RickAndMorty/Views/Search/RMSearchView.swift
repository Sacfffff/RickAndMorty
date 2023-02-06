//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import UIKit

final class RMSearchView: UIView {

    var selectedOption : ((RMSearchInputViewViewModel.DynamicOptions) -> Void)?
    var didBeginSearch : (() -> Void)?
    
    private let viewModel : RMSearchViewViewModel
    
    private let noResultView = RMNoSearchResultView()
    private let resultInputView = RMSearchInputView()
    
    
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
    
    func presentKeyboard() {
        resultInputView.presentKeyboard()
    }
    
    private func setup() {
        
        self.backgroundColor = .systemBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        
        resultInputView.delegate = self
        resultInputView.update(with: .init(type: viewModel.config.type))
        
        viewModel.registerOptionChange { [weak self] option, value in
            self?.resultInputView.update(with: option, value: value)
        }
        resultInputView.didBeginSearch = { [weak self] in
            self?.didBeginSearch?()
        }
        self.addSubviews(noResultView, resultInputView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //noResultView
                noResultView.widthAnchor.constraint(equalToConstant: 150),
                noResultView.heightAnchor.constraint(equalToConstant: 150),
                noResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
                noResultView.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                //resultInputView
                resultInputView.topAnchor.constraint(equalTo: topAnchor),
                resultInputView.leftAnchor.constraint(equalTo: leftAnchor),
                resultInputView.rightAnchor.constraint(equalTo: rightAnchor),
                resultInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 85 : 110),
               
                
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

//MARK: - RMSearchInputViewDelegate

extension RMSearchView : RMSearchInputViewDelegate {
    
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelect option: RMSearchInputViewViewModel.DynamicOptions) {
        
        selectedOption?(option)
        
    }

    
}

