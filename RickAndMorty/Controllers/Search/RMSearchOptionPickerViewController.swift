//
//  RMSearchOptionPickerViewController.swift
//  RickAndMorty
//
//  Created by Aleks Kravtsova on 4.02.23.
//

import UIKit

class RMSearchOptionPickerViewController: UIViewController {

    private let option : RMSearchInputViewViewModel.DynamicOptions
    private let selectionBlock : ((String) -> Void)
    
    private let tableView : UITableView = UITableView()
    
    init(option: RMSearchInputViewViewModel.DynamicOptions, selectionBlock: @escaping (String) -> Void) {
        self.option = option
        self.selectionBlock = selectionBlock
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                
                //tableView
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                
               
                
            ])
        
    }

}

//MARK: - UITableViewDelegate

extension RMSearchOptionPickerViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let choice = option.choices[indexPath.row]
        
        dismiss(animated: true) { [weak self] in
            self?.selectionBlock(choice)
        }
    }
}

//MARK: - UITableViewDataSource

extension RMSearchOptionPickerViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.choices.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let choice = option.choices[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = choice.capitalized
        cell.contentConfiguration = configuration
        return cell
    }
    
    
}
