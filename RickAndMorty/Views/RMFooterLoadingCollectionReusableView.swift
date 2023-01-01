//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 1.01.23.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        spinner.startAnimating()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //spinner
                spinner.widthAnchor.constraint(equalToConstant: 100.0),
                spinner.heightAnchor.constraint(equalToConstant: 100.0),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                
            ])
    }
}
