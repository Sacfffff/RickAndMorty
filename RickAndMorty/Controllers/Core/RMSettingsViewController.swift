//
//  RMSettingViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit
import SwiftUI
import SafariServices

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    private var settingsSwiftUIController : UIHostingController<RMSettingsView>?
    
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
        
        let settingsSwiftUIController = UIHostingController(rootView: RMSettingsView(model: RMSettingsViewModel(cellViewModels: RMSettingsOption.allCases.compactMap{ RMSettingsCellViewModel(type: $0) { [weak self] in  self?.handleOption(option: $0)} })))
        addChild(settingsSwiftUIController)
        
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.settingsSwiftUIController = settingsSwiftUIController
        
    }
    
    private func handleOption(option: RMSettingsOption) {
        guard Thread.current.isMainThread else { return }
        
        if let url = option.targetURL {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        } else if option == .rateApp {
            
        }
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //settingsSwiftUIController
                settingsSwiftUIController!.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                settingsSwiftUIController!.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                settingsSwiftUIController!.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                settingsSwiftUIController!.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
                
            ])
    }

}
