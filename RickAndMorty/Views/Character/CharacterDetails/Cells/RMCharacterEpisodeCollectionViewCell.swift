//
//  RMCharacterEpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 7.01.23.
//

import UIKit

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    private var blurView : UIVisualEffectView = UIVisualEffectView()
    private let imageView : UIImageView = UIImageView()
    
    private let episode : UILabel = UILabel()
    private let name : UILabel = UILabel()
    private let airDate : UILabel = UILabel()
    
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
        
        imageView.frame = contentView.bounds
        blurView.frame = imageView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        name.text = nil
        episode.text = nil
        airDate.text = nil
    }
    
    func configure(with viewModel: RMCharacterEpisodeCellViewModelProtocol) {
        
        var varViewModel = viewModel
        
        varViewModel.update = { [weak self] data in
            self?.name.text = data.name
            self?.episode.text = "Episode: \(data.episode)"
            self?.airDate.text = "Airned on: \(data.airDate)"
        }
        varViewModel.getEpisode()
        
    }
    
    private func setup() {
        
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "rick-and-morty")
        
        let blurEffect = UIBlurEffect(style: .dark)
        blurView.alpha = 0.5
        blurView.effect = blurEffect
        
        episode.translatesAutoresizingMaskIntoConstraints = false
        episode.font = .systemFont(ofSize: 20, weight: .semibold)

        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 22, weight: .regular)
        
        airDate.translatesAutoresizingMaskIntoConstraints = false
        airDate.font = .systemFont(ofSize: 20, weight: .light)
        
        contentView.addSubviews(imageView, blurView, episode, name, airDate)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //episode
                episode.topAnchor.constraint(equalTo: contentView.topAnchor),
                episode.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                episode.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                episode.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
                
                //name
                name.topAnchor.constraint(equalTo: episode.bottomAnchor),
                name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                name.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
                
                //airDate
                airDate.topAnchor.constraint(equalTo: name.bottomAnchor),
                airDate.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                airDate.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                airDate.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
                
                
            ])
        
    }
}
