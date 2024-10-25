//
//  CharacterTableViewCell.swift
//  
//
//  Created by Shimaa Elsisi on 23.10.2024.
//

import UIKit
import SwiftUI
import Kingfisher


class CharacterTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CharacterTableViewCell"
    
    var imageUrl: URL?
    var characterName: String?
    var characterStatus: String?
    
    func configure(with imageUrl: URL, characterName: String, characterStatus: String) {
        self.imageUrl = imageUrl
        self.characterName = characterName
        self.characterStatus = characterStatus
        selectionStyle = .none
        
        self.contentConfiguration = UIHostingConfiguration {
            CharacterRowView(imageUrl: imageUrl, name: characterName, status: characterStatus)
        }
    }
 }


struct CharacterRowView: View {
    let imageUrl: URL
    let name: String
    let status: String

    var body: some View {
        HStack(alignment: .top) {
            KFImage(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                .padding(.trailing, 10)
                .padding(.leading, 10) 
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(status)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .alignmentGuide(.top) { _ in 0 }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.7)
        )
        .cornerRadius(10)
    }
}
