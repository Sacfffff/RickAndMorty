//
//  RMSettingViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 24.12.22.
//

import UIKit

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    private let viewModel = RMSettingsViewModel(cellViewModels: RMSettingsOption.allCases.compactMap{ RMSettingsCellViewModel(type: $0) })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
    }


}
