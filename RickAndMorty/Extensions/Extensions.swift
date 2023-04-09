//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 28.12.22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        
        views.forEach{
            self.addSubview($0)
        }
    }
}

extension UIDevice {

    static let isIPhone = UIDevice.current.userInterfaceIdiom == .phone
    
}
