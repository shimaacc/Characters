//
//  File.swift
//  
//
//  Created by Shimaa Elsisi on 25.10.2024.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ImageTableViewCell"
    
    func configure(with imageName: String) {
        let swiftUIView = ImageCellView(imageURL: imageName)
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

struct ImageCellView: View {
    let imageURL: String
    
    var body: some View {
        KFImage(URL(string: imageURL))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: UIScreen.main.bounds.height * 0.4)
            .clipped()
            .cornerRadius(20)
    }
}
