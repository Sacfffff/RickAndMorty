//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 14.01.23.
//

import UIKit

protocol RMEpisodeListViewViewModelProtocol : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var reloadData : (()->Void)? {get set}
    var didSelectEpisode : ((RMEpisode)->Void)? {get set}
    var didLoadMoreEpisodes : (([IndexPath]) -> Void)? {get set}
    
    var shouldShowLoadMoreIndicator : Bool {get}
    
    func getAllEpisodes()
    
}

/// View Model to hundle episodes list view logic
final class RMEpisodeListViewViewModel : NSObject, RMEpisodeListViewViewModelProtocol {
    
    var reloadData: (() -> Void)?
    var didSelectEpisode : ((RMEpisode)->Void)?
    var didLoadMoreEpisodes : (([IndexPath]) -> Void)?
    
    var shouldShowLoadMoreIndicator : Bool {
        apiInfo?.next != nil
    }
    
    private var episodes : [RMEpisode] = [] {
        didSet {
           episodes.forEach{
               let model =  RMCharacterEpisodeCellViewModel(episodeDataURL: URL(string: $0.url))
               
               if !cellViewModel.contains(model) {
                   cellViewModel.append(model)
               }
            }
        }
    }
                                                            
    private var cellViewModel : [RMCharacterEpisodeCellViewModel] = []
    private var apiInfo : RMGetAllEpisodesResponceInfo?
    private var isLoadingMoreEpisodes : Bool = false
    
    /// Fetch initial set of episodes(20)
    func getAllEpisodes() {
        RMService.shared.execute(RMService.listOfEpisidesRequest, expecting: RMGetAllEpisodesResponce.self) { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let responceModel):
                self?.episodes = responceModel.results
                self?.apiInfo = responceModel.info
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            }
        }
    }
    
    /// Paginate if additional episodes are needed
    func getAdditionalEpisodes(url: URL) {
        
        guard !isLoadingMoreEpisodes else { return }
        
        isLoadingMoreEpisodes = true
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreEpisodes = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllEpisodesResponce.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let model):
                let moreResults = model.results
                self.apiInfo = model.info
                
                let newCount = moreResults.count
                let total = self.episodes.count + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd : [IndexPath] = Array(startingIndex..<(startingIndex + newCount))
                    .compactMap{ IndexPath(row: $0, section: 0) }
                self.episodes.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    self.didLoadMoreEpisodes?(indexPathsToAdd)
                }
                 self.isLoadingMoreEpisodes = false
            case .failure(_):
                self.isLoadingMoreEpisodes = false
            }
        }
        
    }
    
}

//MARK: - extension RMEpisodeListViewViewModel : UICollectionViewDataSource
extension RMEpisodeListViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(RMCharacterEpisodeCollectionViewCell.self)", for: indexPath) as? RMCharacterEpisodeCollectionViewCell else { return .init() }
        cell.setup(with: cellViewModel[indexPath.row])
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


//MARK: - extension RMEpisodeListViewViewModel : UICollectionViewDelegateFlowLayout
extension RMEpisodeListViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        let width : CGFloat = bounds.width - 20
        return CGSize(width: width, height: 100)
    }
}


//MARK: - extension RMEpisodeListViewViewModel : UICollectionViewDelegate
extension RMEpisodeListViewViewModel {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        didSelectEpisode?(episode)
    }
    
}

//MARK: - extension RMEpisodeListViewViewModel : UIScrollViewDelegate
extension RMEpisodeListViewViewModel {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreEpisodes,
              !cellViewModel.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            let footerHeightPlusBuffer : CGFloat = 120
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - footerHeightPlusBuffer) {
                self?.getAdditionalEpisodes(url: url)
               
            }
            
            t.invalidate()
        }
    }
}
