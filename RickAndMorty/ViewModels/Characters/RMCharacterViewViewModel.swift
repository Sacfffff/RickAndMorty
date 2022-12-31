//
//  RMCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 26.12.22.
//

import UIKit

protocol RMCharacterViewViewModelProtocol : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var reloadData : (()->Void)? {get set}
    var didSelectCharacter : ((RMCharacter)->Void)? {get set}
    
    var shouldShowMoreIndicator : Bool {get}
    
    func getAllCharacters()
    
}

/// View Model to hundle character list view logic
final class RMCharacterViewViewModel : NSObject, RMCharacterViewViewModelProtocol {
    
    var reloadData: (() -> Void)?
    var didSelectCharacter : ((RMCharacter)->Void)?
    
    var shouldShowMoreIndicator : Bool {
        apiInfo?.next != nil
    }
    
    private var characters : [RMCharacter] = [] {
        didSet {
           characters.forEach{
              let model =  RMCharactersCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageURL: URL(string: $0.image))
               cellViewModel.append(model)
            }
        }
    }
    private var cellViewModel : [RMCharactersCollectionViewCellViewModel] = []
    private var apiInfo : RMGetAllCharactersResponceInfo?
    
    /// Fetch initial set of characters(20)
    func getAllCharacters() {
        RMService.shared.execute(RMService.listOfCharactersRequests, expecting: RMGetAllCharactersResponce.self) { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let responceModel):
                self?.characters = responceModel.results
                self?.apiInfo = responceModel.info
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            }
        }
    }
    
    /// Paginate if additional characters are needed
    func getAdditionalCharacters () {
        
    }
    
}

//MARK: - extension RMCharacterViewViewModel : UICollectionViewDataSource
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


//MARK: - extension RMCharacterViewViewModel : UICollectionViewDelegateFlowLayout
extension RMCharacterViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width : CGFloat = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}


//MARK: - extension RMCharacterViewViewModel : UICollectionViewDelegate
extension RMCharacterViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        didSelectCharacter?(character)
    }
    
}

//MARK: - extension RMCharacterViewViewModel : UIScrollViewDelegate
extension RMCharacterViewViewModel {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowMoreIndicator else { return }
    }
}
