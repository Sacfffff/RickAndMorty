//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import UIKit

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    private let titleContainer : UIView = UIView()
    private let value : UILabel = UILabel()
    private let title : UILabel = UILabel()
    private let icon : UIImageView = UIImageView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        title.textColor = nil
        value.text = nil
        icon.image = nil
        icon.tintColor = nil
    }
    
    private func setup() {
        
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        value.translatesAutoresizingMaskIntoConstraints = false
        value.font = .systemFont(ofSize: 22, weight: .light)
        value.numberOfLines = 0
        
        titleContainer.backgroundColor = .secondarySystemBackground
        titleContainer.translatesAutoresizingMaskIntoConstraints = false
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20, weight: .medium)
        titleContainer.addSubview(title)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        
        contentView.addSubviews(value,titleContainer, icon)

    }
    
    func configure(with viewModel: RMCharacterInfoCellViewModelProtocol) {
        title.text = viewModel.title
        value.text = viewModel.displayValue
        icon.image = viewModel.iconImage
        icon.tintColor = viewModel.tintColor
        title.textColor = viewModel.tintColor
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //titleContainer
                titleContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
                titleContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                titleContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                titleContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                
                //title
                title.leftAnchor.constraint(equalTo: titleContainer.leftAnchor),
                title.rightAnchor.constraint(equalTo: titleContainer.rightAnchor),
                title.topAnchor.constraint(equalTo: titleContainer.topAnchor),
                title.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
                
                //icon
                icon.heightAnchor.constraint(equalToConstant: 30),
                icon.widthAnchor.constraint(equalToConstant: 30),
                icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
                icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
                
                //value
                value.leftAnchor.constraint(equalTo: icon.rightAnchor,constant: 10),
                value.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                value.topAnchor.constraint(equalTo: contentView.topAnchor),
                value.bottomAnchor.constraint(equalTo: titleContainer.topAnchor),
                
            ])
    }
}
