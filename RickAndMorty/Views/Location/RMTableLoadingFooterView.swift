//
//  RMTableLoadingFooterView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 11.03.23.
//

import UIKit

final class RMTableLoadingFooterView: UIView {

    private let spinner : UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
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
    
    
    private func setup() {
        
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        addSubview(spinner)
        
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            
            [
                //spinner
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                spinner.widthAnchor.constraint(equalToConstant: 55),
                spinner.heightAnchor.constraint(equalToConstant: 55),
                
            ]
            
        )
    }

}
