//
//  CharacterTableViewCell.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit
import SwiftUI

@available(iOS 16.0, *)
class CharacterTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CharacterTableViewCell"
    
    var characterImage: String? {
         didSet {
             updateUI()
         }
     }
     
     var characterName: String? {
         didSet {
             updateUI()
         }
     }
     
     var characterStatus: String? {
         didSet {
             updateUI()
         }
     }
     
     private func updateUI() {
         guard let image = characterImage, let name = characterName, let status = characterStatus else { return }
         
         self.contentConfiguration = UIHostingConfiguration {
             CharacterRowView(image: image, name: name, status: status)
         }
     }
 }


struct CharacterRowView: View {
    let image: String
    let name: String
    let status: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 10)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(status)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
    }
}
