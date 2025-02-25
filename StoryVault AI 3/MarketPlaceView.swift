//
//  Untitled 10.swift
//  StoryVault AI 2
//
//  Created by DM on 2/24/25.
//

import SwiftUI

struct MarketplaceView: View {
    private let items: [MarketplaceItem] = [
        MarketplaceItem(name: "Public Domain Classics Pack", description: "Fully legal stories", price: "$2.99"),
        MarketplaceItem(name: "Beowulf Campaign", description: "Epic expansions from the Old English poem", price: "$3.99"),
        MarketplaceItem(name: "Treasure Island Pack", description: "Pirate expansions", price: "$3.99"),
        MarketplaceItem(name: "Dracula Adventures", description: "Gothic expansions", price: "$2.49"),
        MarketplaceItem(name: "Steampunk Worlds", description: "Victorian clockwork expansions", price: "$2.99")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.1), .blue.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                List(items) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Price: \(item.price)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(6)
                }
            }
            .navigationBarTitle("Marketplace", displayMode: .inline)
        }
    }
}

struct MarketplaceItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: String
}
