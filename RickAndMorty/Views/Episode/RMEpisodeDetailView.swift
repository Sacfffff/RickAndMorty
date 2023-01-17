//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 13.01.23.
//

import UIKit

final class RMEpisodeDetailView: UIView {

    private var viewModel : RMEpisodeViewViewModelProtocol?
    
    private let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    func setup(with viewModel: RMEpisodeViewViewModelProtocol) {
        
        self.viewModel = viewModel
       
        
    }
    
    private func configureUI() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            
            [
                
                
            ]
        )
    }

}
