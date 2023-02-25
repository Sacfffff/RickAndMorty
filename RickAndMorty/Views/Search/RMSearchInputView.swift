//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 30.01.23.
//

import UIKit

protocol RMSearchInputViewDelegate : AnyObject {
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelect option: RMSearchInputViewViewModel.DynamicOptions)
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearchText text: String)
    func rmSearchInputViewDidTappedSearchKeybordButton(_ inputView: RMSearchInputView)
    
}

/// View for top part of search screen with search bar
final class RMSearchInputView: UIView {
    
    weak var delegate : RMSearchInputViewDelegate?
    
    private var viewModel : RMSearchInputViewViewModel? {
        
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else { return }
            
            createOptionsSelectionViews(options: viewModel.options)
            
        }
        
    }
    
    private let searchBar : UISearchBar = UISearchBar()
    private let stackView = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupConstraints()
        
    }
    
    
    func update(with model: RMSearchInputViewViewModel) {
        
        self.viewModel = model
        searchBar.placeholder = model.searchPlaceholderText

    }
    
    
    func update(with option: RMSearchInputViewViewModel.DynamicOptions, value: String) {
        
        guard let options = viewModel?.options, let index = options.firstIndex(of: option), let button = stackView.arrangedSubviews[index] as? UIButton else { return }
        
        button.setAttributedTitle(NSAttributedString(string: value.prefix(1).capitalized + value.dropFirst(), attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor : UIColor.link]), for: .normal)
        
    }
    
    
    func createOptionsSelectionViews(options: [RMSearchInputViewViewModel.DynamicOptions]) {
    
        options.enumerated().forEach{
            let button = UIButton()
            button.backgroundColor = .secondarySystemBackground
            button.layer.cornerRadius = 8
            button.setAttributedTitle(NSAttributedString(string: $1.rawValue, attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor : UIColor.label]), for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.addTarget(self, action: #selector(optionButtonDidTap(_:)), for: .touchUpInside)
            button.tag = $0
            stackView.addArrangedSubview(button)
            
        }
        
    }
    
    func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    
    private func setup() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        addSubview(searchBar)
        
       
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 8
        addSubview(stackView)
        
    }
    
    
    @objc func optionButtonDidTap(_ sender: UIButton) {
        
        guard let options = viewModel?.options else { return }
        
        delegate?.rmSearchInputView(self, didSelect: options[sender.tag])
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                //searchBar
                searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                searchBar.leftAnchor.constraint(equalTo: leftAnchor),
                searchBar.rightAnchor.constraint(equalTo: rightAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: 55),
                
                //stackView
                stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
                stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
                stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
            ])
        
    }
    
}

//MARK: - extension UISearchBarDelegate

extension RMSearchInputView : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        delegate?.rmSearchInputViewDidTappedSearchKeybordButton(self)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        delegate?.rmSearchInputView(self, didChangeSearchText: searchText)
        
    }
    
}
