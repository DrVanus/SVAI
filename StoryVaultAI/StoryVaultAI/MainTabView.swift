//
//  ContentView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            LibraryView()
                .tabItem {
                    // Changed from "book.fill" to "book.closed.fill"
                    Image(systemName: "book.closed.fill")
                    Text("Library")
                }
            
            MarketplaceView()
                .tabItem {
                    // Kept "books.vertical.fill" for Marketplace
                    Image(systemName: "books.vertical.fill")
                    Text("Marketplace")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
