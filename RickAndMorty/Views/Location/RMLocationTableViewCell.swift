//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 27.01.23.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {
    
    private let name : UILabel = UILabel()
    private let type : UILabel = UILabel()
    private let dimension : UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
       
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        name.text = nil
        type.text = nil
        dimension.text = nil
        
    }
    
    func update(with model: RMLocationTableViewCellViewModel) {
        
        name.text = model.name
        type.text = model.type
        dimension.text = model.dimension
        
    }
    
    private func setup() {
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 20, weight: .medium)
        
        type.translatesAutoresizingMaskIntoConstraints = false
        type.font = .systemFont(ofSize: 15, weight: .regular)
        type.textColor = .secondaryLabel
        
        dimension.translatesAutoresizingMaskIntoConstraints = false
        dimension.font = .systemFont(ofSize: 15, weight: .light)
        dimension.textColor = .secondaryLabel
        
        self.accessoryType = .disclosureIndicator
        
        contentView.addSubviews(name, type, dimension)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            
            [
                //name
                name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                
                //type
                type.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
                type.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                type.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                
                //dimension
                dimension.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 10),
                dimension.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                dimension.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                dimension.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)

                
                
            ]
            
        )
    }
    
}
