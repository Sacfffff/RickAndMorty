//
//  RMEpisodeInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 18.01.23.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    
    private var blurView : UIVisualEffectView = UIVisualEffectView()
    private let imageView : UIImageView = UIImageView()
    
    private let title : UILabel = UILabel()
    private let value : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        value.text = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        
        imageView.frame = contentView.bounds
        blurView.frame = imageView.bounds
        
    }
    
    func setup(with model: RMEpisodeInfoCollectionViewCellViewModel) {
        
        title.text = model.title
        value.text = model.value
        
    }
    
    private func configureUI() {
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 20, weight: .medium)
        
        value.translatesAutoresizingMaskIntoConstraints = false
        value.font = .systemFont(ofSize: 20, weight: .medium)
        value.textAlignment = .right
        value.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "episode")
        
        let blurEffect = UIBlurEffect(style: .prominent)
        blurView.alpha = 0.5
        blurView.effect = blurEffect
        
        contentView.addSubviews(imageView, blurView, title, value)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            
            [
                
                
                
                //title
                title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
                title.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
                
                //value
                value.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                value.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                value.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
                value.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
                
                
            ]
            
        )
    }
    
}

