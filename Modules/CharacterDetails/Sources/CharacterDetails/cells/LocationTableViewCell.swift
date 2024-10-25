//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation
import UIKit
import SwiftUI

class LocationTableViewCell: UITableViewCell {
    static let reuseIdentifier = "LocationTableViewCell"
    
    func configure(with location: String) {
        let swiftUIView = LocationCellView(location: location)
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

struct LocationCellView: View {
    let location: String
    
    var body: some View {
        Text("Location: \(location)")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}
