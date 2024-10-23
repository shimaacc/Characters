//
//  CharacterListViewController.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit

class CharacterListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var viewModel: CharacterListViewModelProtocol
    
    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }


}

private extension CharacterListViewController {
//    func setupTableView() {
//        tableView.register(
//            UINib(nibName: CharacterTableViewCell.reuseIdentifier, bundle: nil),
//            forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier
//        )
//        tableView.separatorStyle = .none
//    }
    
    private func bind() {
    }

}
