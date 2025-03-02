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
                    Label("Home", systemImage: "house.fill")
                }
            
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "book.closed.fill")
                }
            
            MarketplaceView()
                .tabItem {
                    Label("Marketplace", systemImage: "books.vertical.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            WriteYourOwnStoryView()
                .tabItem {
                    Label("Write", systemImage: "pencil")
                }
        }
        .accentColor(.purple) // Match your app’s theme
        .environmentObject(LibraryModel()) // Provide LibraryModel to the entire tab view hierarchy
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .preferredColorScheme(.dark)
            .environmentObject(LibraryModel()) // Add for previews
    }
}
