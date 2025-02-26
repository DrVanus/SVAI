//
//  StoryVaultAIApp.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

@main
struct StoryVaultAI5App: App {
    @StateObject private var library = LibraryModel()
    @StateObject private var storyManager = StoryManager()
    @AppStorage("darkMode") private var darkMode = false
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(library)
                .environmentObject(storyManager)
                .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}
