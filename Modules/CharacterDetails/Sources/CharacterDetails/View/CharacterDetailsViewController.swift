//
//  File 2.swift
//  
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation
import UIKit
import Combine

class CharacterDetailsViewController: UIViewController {
    private var viewModel: CharacterDetailsViewModelProtocol
    public var cancellables: Set<AnyCancellable> = .init()
    
    let tableView = UITableView()
    
    init(viewModel: CharacterDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupBackButton()
    }
    
    func bind() {
        viewModel.uiModel.$sections.sink { [weak self] list in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.reuseIdentifier)
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)    }
    
    func setupBackButton() {
           let backButton = UIButton(type: .custom)
           backButton.setImage(UIImage(systemName: "arrowshape.turn.up.backward"), for: .normal)
           backButton.backgroundColor = .lightGray
           backButton.tintColor = .white
           backButton.layer.cornerRadius = 25
           backButton.clipsToBounds = true
           backButton.frame = CGRect(x: 16, y: 40, width: 50, height: 50)
           backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
           view.addSubview(backButton)
       }
    
    @objc func backButtonTapped() {
           dismiss(animated: true, completion: nil)
       }
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.uiModel.sections.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let item = viewModel.uiModel.sections[indexPath.row]
          
          switch item {
          case .image(let imageName):
              let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: indexPath) as! ImageTableViewCell
              cell.configure(with: imageName)
              return cell
              
          case .description(let name, let species, let gender, let status):
              let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.reuseIdentifier, for: indexPath) as! DescriptionTableViewCell
              let item = viewModel.uiModel.characterItem
              cell.configure(
                with: name,
                species: species,
                gender: gender,
                status: status
              )
              return cell
              
          case .location(let location):
              let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as! LocationTableViewCell
              cell.configure(with: location)
              return cell
          }
      }
}
