//
//  RMCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.12.22.
//

import UIKit

protocol RMCharacterViewViewModelProtocol : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var reloadData : (()->Void)? {get set}
    func getAllCharacters()
    
}

final class RMCharacterViewViewModel : NSObject, RMCharacterViewViewModelProtocol {
    
    var reloadData: (() -> Void)?
    
    private var characters : [RMCharacter] = [] {
        didSet {
           characters.forEach{
              let model =  RMCharactersCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageURL: URL(string: $0.image))
               cellViewModel.append(model)
            }
        }
    }
    private var cellViewModel : [RMCharactersCollectionViewCellViewModel] = []
    
    func getAllCharacters() {
        RMService.shared.execute(RMService.listOfCharactersRequests, expecting: RMGetAllCharactersResponce.self) { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let responceModel):
                self?.characters = responceModel.results
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            }
        }
    }
}

//MARK: - extension CharacterListView : UICollectionViewDataSource
extension RMCharacterViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharactersCollectionViewCell.self)", for: indexPath) as? RMCharactersCollectionViewCell else { return .init() }
        cell.apply(viewModel: cellViewModel[indexPath.row])
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
