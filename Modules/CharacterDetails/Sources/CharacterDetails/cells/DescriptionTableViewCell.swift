//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation
import UIKit
import SwiftUI

class DescriptionTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DescriptionTableViewCell"
    
    func configure(
        with name: String,
        species: String,
        gender: String,
        status: String
    ) {
        let swiftUIView =   DescriptionCellView(
            name: name,
            species: species,
            gender: gender,
            status: status
        )
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

struct DescriptionCellView: View {
    let name: String
    let species: String
    let gender: String
    let status: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.body)
                .padding(.bottom, 5)

            HStack(spacing: 3) {
                Text(species)
                    .padding()

                Text(".")
                    .padding()
                
                Text(gender)
                    .padding()

            }
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .cornerRadius(8)
    }
}
