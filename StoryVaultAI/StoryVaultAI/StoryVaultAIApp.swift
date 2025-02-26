//
//  StoryVaultAIApp.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

@main
struct StoryVaultAIApp: App {
    @StateObject private var library = LibraryModel()
    @StateObject private var storyManager = StoryManager()
    @StateObject private var achievementsModel = AchievementsModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(library)
                .environmentObject(storyManager)
                .environmentObject(achievementsModel)
        }
    }
}
