//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import UIKit

class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    private let imageView : UIImageView = UIImageView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    private func configureUI() {
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
    }
    
    func setup(with viewModel: RMCharacterPhotoCellViewModelProtocol) {
        
        viewModel.getImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        }
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //imageView
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                
            ])

        
    }

}
