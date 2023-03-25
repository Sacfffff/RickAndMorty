//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import UIKit

final class RMSearchView: UIView {

    var selectedOption : ((RMSearchInputViewViewModel.DynamicOptions) -> Void)?
    var selectedLocation : ((RMLocation) -> Void)?
    
    private let viewModel : RMSearchViewViewModel
    
    private let noResultView = RMNoSearchResultView()
    private let resultInputView = RMSearchInputView()
    private let resultsView = RMSearchResultsView()
    
    
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
        
        
        resultsView.delegate = self
        
        self.setupHandlers()
        
        self.addSubviews(resultsView, noResultView, resultInputView)
        
    }
    
    
    private func setupHandlers() {
        
        viewModel.registerOptionChange { [weak self] option, value in
            self?.resultInputView.update(with: option, value: value)
        }
        viewModel.registerSearchResultHandler { [weak self] result in
            DispatchQueue.main.async {
                self?.resultsView.update(with: result)
                self?.noResultView.isHidden = true
                self?.resultsView.isHidden = false
            }
        }
        viewModel.registerNoSearchResultHandler { [weak self] in
            DispatchQueue.main.async {
                self?.noResultView.isHidden = false
                self?.resultsView.isHidden = true
            }
        }
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
                
                //resultsView
                resultsView.leftAnchor.constraint(equalTo: leftAnchor),
                resultsView.rightAnchor.constraint(equalTo: rightAnchor),
                resultsView.bottomAnchor.constraint(equalTo: bottomAnchor),
                resultsView.topAnchor.constraint(equalTo: resultInputView.bottomAnchor)
               
                
            ])
        
    }
    
}

//MARK: -  extension UICollectionViewDelegate

extension RMSearchView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: -extension  UICollectionViewDataSource

extension RMSearchView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

//MARK: - extension RMSearchInputViewDelegate

extension RMSearchView : RMSearchInputViewDelegate {
    
    func rmSearchInputViewDidTappedSearchKeybordButton(_ inputView: RMSearchInputView) {
        
        self.viewModel.executeSearch()
        
    }
    
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearchText text: String) {
        
        self.viewModel.set(query: text)
        
    }
    
    
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelect option: RMSearchInputViewViewModel.DynamicOptions) {
        
        selectedOption?(option)
        
    }

    
}

//MARK: - RMSearchInputViewDelegate

extension RMSearchView : RMSearchResultsViewDelegate {
    
    func rmSearchResultsView(_ resultView: RMSearchResultsView, didSelectLocationAt index: Int) {
        
        guard let locationModel = viewModel.locationSearchResults(at: index) else { return }
        
        self.selectedLocation?(locationModel)
        
    }
    
    
}
