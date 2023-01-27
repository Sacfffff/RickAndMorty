//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 27.01.23.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .systemBackground
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func update(with model: RMLocationTableViewCellViewModel) {
        
    }
    
}
