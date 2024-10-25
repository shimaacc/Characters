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
    
    func configure(with description: String) {
        let swiftUIView =   DescriptionCellView(description: "This is the description.",
                                                label1: "elf",
                                                label2: ".",
                                                label3: "male")
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
    let description: String
    let label1: String
    let label2: String
    let label3: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(description)
                .font(.body)
                .padding(.bottom, 5)

            HStack(spacing: 3) {
                Text(label1)
                    .padding()

                Text(label2)
                    .padding()

                Text(label3)
                    .padding()
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .cornerRadius(8)
    }
}
