////
////  File.swift
////  
////
////  Created by Shimaa Elsisi on 25.10.2024.
////

import Foundation
import UIKit
import SwiftUI
import Common

class FilterHeaderCell: UITableViewHeaderFooterView {
    static let reuseIdentifier = "FilterHeaderCell"
    var charactersStatuses: [String] = []

    var onStatusSelected: ((String?) -> Void)?
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(charactersStatuses: [String], onStatusSelected: @escaping (String?) -> Void) {
        self.charactersStatuses = charactersStatuses
        self.onStatusSelected = onStatusSelected
        updateUI()
    }

    private func setupUI() {
        self.contentConfiguration = makeHostingConfiguration(with: [])
    }

    private func updateUI() {
        self.contentConfiguration = makeHostingConfiguration(with: charactersStatuses)
    }

    private func makeHostingConfiguration(with statuses: [String]) -> UIHostingConfiguration<HorizontalCollectionView, EmptyView> {
        UIHostingConfiguration {
            HorizontalCollectionView(charactersStatuses: statuses) { selectedItem in
                self.onStatusSelected?(selectedItem)
            }
        }
    }
}

struct HorizontalCollectionView: View {
    let charactersStatuses: [String]
    @State private var selectedItem: String? // Track the selected item
    var onStatusSelected: (String?) -> Void // Closure to notify selection
    
    init(charactersStatuses: [String], onStatusSelected: @escaping (String?) -> Void) {
        self.charactersStatuses = charactersStatuses
        self.onStatusSelected = onStatusSelected
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(charactersStatuses, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(self.selectedItem == item ? Color.gray : Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)                        )
                        .foregroundColor(self.selectedItem == item ? Color.white : Color.gray)
                        .onTapGesture {
                            var selectedItem = self.selectedItem == item ? nil : item
                            self.onStatusSelected(selectedItem)
                            
                            self.selectedItem = selectedItem
                        }
                }
            }
        }
    }
}
