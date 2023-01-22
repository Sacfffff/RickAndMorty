//
//  RMSettingViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit
import SwiftUI

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    private let settingsSwiftUIController = UIHostingController(rootView: RMSettingsView(model: RMSettingsViewModel(cellViewModels: RMSettingsOption.allCases.compactMap{ RMSettingsCellViewModel(type: $0) })))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
    
    private func setup() {
        
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        addChild(settingsSwiftUIController)
        
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //settingsSwiftUIController
                settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
                
            ])
    }

}
