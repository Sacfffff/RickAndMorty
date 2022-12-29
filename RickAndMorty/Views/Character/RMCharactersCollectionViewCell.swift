//
//  RMCharactersCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 29.12.22.
//

import UIKit

/// Single cell for a character
final class RMCharactersCollectionViewCell: UICollectionViewCell {
    
    private let imageView : UIImageView = UIImageView()
    private let name : UILabel = UILabel()
    private let status : UILabel = UILabel()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        name.text = nil
        status.text = nil
    }
    
    func apply(viewModel: RMCharactersCollectionViewCellViewModel) {
        
        name.text = viewModel.characterName
        status.text = viewModel.characterStatusText
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureUI() {
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 18, weight: .medium)
        name.textColor = .label
        
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = .systemFont(ofSize: 16, weight: .regular)
        status.textColor = .secondaryLabel
        
        contentView.addSubviews(imageView, name, status)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
 
                //status
                status.heightAnchor.constraint(equalToConstant: 40),
                status.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
                status.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
                status.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
                
                //name
                name.heightAnchor.constraint(equalToConstant: 40),
                name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
                name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
                name.bottomAnchor.constraint(equalTo: status.topAnchor, constant: -3),
                
                //imageView
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -3),
                imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                
            ])
        
    }
}
