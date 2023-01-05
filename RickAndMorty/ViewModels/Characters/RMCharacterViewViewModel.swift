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
    var didLoadMoreCharacters : (([IndexPath]) -> Void)? {get set}
    
    var shouldShowLoadMoreIndicator : Bool {get}
    
    func getAllCharacters()
    
}

/// View Model to hundle character list view logic
final class RMCharacterViewViewModel : NSObject, RMCharacterViewViewModelProtocol {
    
    var reloadData: (() -> Void)?
    var didSelectCharacter : ((RMCharacter)->Void)?
    var didLoadMoreCharacters : (([IndexPath]) -> Void)?
    
    var shouldShowLoadMoreIndicator : Bool {
        apiInfo?.next != nil
    }
    
    private var characters : [RMCharacter] = [] {
        didSet {
           characters.forEach{
              let model =  RMCharactersCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageURL: URL(string: $0.image))
               
               if !cellViewModel.contains(model) {
                   cellViewModel.append(model)
               }
            }
        }
    }
    private var cellViewModel : [RMCharactersCollectionViewCellViewModel] = []
    private var apiInfo : RMGetAllCharactersResponceInfo?
    private var isLoadingMoreCharacters : Bool = false
    
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
    func getAdditionalCharacters(url: URL) {
        
        guard !isLoadingMoreCharacters else { return }
        
        isLoadingMoreCharacters = true
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponce.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let model):
                let moreResults = model.results
                self.apiInfo = model.info
                
                let newCount = moreResults.count
                let total = self.characters.count + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd : [IndexPath] = Array(startingIndex..<(startingIndex + newCount))
                    .compactMap{ IndexPath(row: $0, section: 0) }
                self.characters.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    self.didLoadMoreCharacters?(indexPathsToAdd)
                }
                 self.isLoadingMoreCharacters = false
            case .failure(_):
                self.isLoadingMoreCharacters = false
            }
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(RMFooterLoadingCollectionReusableView.self)", for: indexPath) as? RMFooterLoadingCollectionReusableView else { fatalError("unsupported") }
        
        footer.startAnimating()
        
        return footer
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 100)
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
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModel.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            let footerHeightPlusBuffer : CGFloat = 120
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - footerHeightPlusBuffer) {
                self?.getAdditionalCharacters(url: url)
               
            }
            
            t.invalidate()
        }
    }
}
