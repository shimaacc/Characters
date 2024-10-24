//
//  CharacterListViewController.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit
import Combine

@available(iOS 16.0, *)
class CharacterListViewController: UIViewController {
    private var viewModel: CharacterListViewModelProtocol
    public var cancellables: Set<AnyCancellable> = .init()

    let tableView = UITableView()

    //TODO: add this in builder
    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind()
    }
    
    func bind() {
        //TODO: replace sink, dispatch with uisink
        viewModel.uiModel.$characterList.sink { [weak self] list in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)

    }
}

@available(iOS 16.0, *)

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.uiModel.characterList.count
        }
        
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
            let character = viewModel.uiModel.characterList[indexPath.row]
            cell.characterImage = "star.fill"
            cell.characterName = character.title
            cell.characterStatus = character.species
            return cell
        }
}
