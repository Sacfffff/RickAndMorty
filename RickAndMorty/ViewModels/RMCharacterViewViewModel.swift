//
//  RMCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.12.22.
//

import UIKit

protocol RMCharacterViewViewModelProtocol : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func getAllCharacters()
    
}

final class RMCharacterViewViewModel : NSObject, RMCharacterViewViewModelProtocol {
    
    func getAllCharacters() {
        RMService.shared.execute(RMService.listOfCharactersRequests, expecting: RMGetAllCharactersResponce.self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
    }
}

//MARK: - extension CharacterListView : UICollectionViewDataSource
extension RMCharacterViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
}


//MARK: - extension CharacterListView : UICollectionViewDelegateFlowLayout
extension RMCharacterViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width : CGFloat = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}


//MARK: - extension CharacterListView : UICollectionViewDelegate
extension RMCharacterViewViewModel {
    
}
