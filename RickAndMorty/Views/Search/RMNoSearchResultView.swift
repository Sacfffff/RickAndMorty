//
//  RMNoSearchResultView-=.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import UIKit

final class RMNoSearchResultView: UIView {

    private let viewModel = RMNoSearchResultViewViewModel()
    
    private let iconView : UIImageView = UIImageView()
    private let title : UILabel = UILabel()
    
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
        
        isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleToFill
        iconView.tintColor = .tertiaryLabel
        iconView.image = viewModel.image
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.text = viewModel.title
        
        addSubviews(title, iconView)
        
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //iconView
                iconView.widthAnchor.constraint(equalToConstant: 90),
                iconView.heightAnchor.constraint(equalToConstant: 90),
                iconView.topAnchor.constraint(equalTo: topAnchor),
                iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                //title
                title.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
                title.leftAnchor.constraint(equalTo: leftAnchor),
                title.rightAnchor.constraint(equalTo: rightAnchor),
                title.bottomAnchor.constraint(equalTo: bottomAnchor),
                
            ])
        
    }

}
