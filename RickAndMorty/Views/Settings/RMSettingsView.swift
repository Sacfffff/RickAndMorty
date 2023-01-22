//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 22.01.23.
//

import SwiftUI

struct RMSettingsView: View {
    
    private let viewModel : RMSettingsViewModel
    
    init(model: RMSettingsViewModel) {
        self.viewModel = model
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(6)
                        
                }
                
                Text(viewModel.title)
                    .padding(.leading, 10)
            
            }.padding(.bottom, 3)
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(model: RMSettingsViewModel(cellViewModels: RMSettingsOption.allCases.compactMap{ RMSettingsCellViewModel(type: $0) }))
    }
}
