//
//  CharacterListViewController.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit
import Combine

class CharacterListViewController: UIViewController {
    private var viewModel: CharacterListViewModelProtocol
    public var cancellables: Set<AnyCancellable> = .init()

    let tableView = UITableView()

    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .white
        setupTableView()
        bind()
    }
    
    func bind() {
        viewModel.uiModel.$characterList.sink { [weak self] list in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)

        viewModel.uiModel.$selectedFilterItem.dropFirst().sink { [weak self] item in
            guard let self else { return }
            viewModel.didApplyFilterType()
        }.store(in: &cancellables)
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        tableView.register(FilterHeaderCell.self, forHeaderFooterViewReuseIdentifier: FilterHeaderCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.uiModel.characterList.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        let character = viewModel.uiModel.characterList[indexPath.row]
        if let imageUrl = URL(string: character.image ?? "") {
            cell.configure(
                with: imageUrl,
                characterName: character.title,
                characterStatus: character.species
            )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FilterHeaderCell") as! FilterHeaderCell
        cell.configure(charactersStatuses: viewModel.uiModel.characterStatusesList, onStatusSelected: { item in
            self.viewModel.uiModel.selectedFilterItem = item
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelctItem(at: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.checkIfReachedEndOfPage(for: indexPath.item)
    }
}
