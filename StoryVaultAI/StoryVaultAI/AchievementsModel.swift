//
//  Achievement.swift
//  StoryVaultAI
//
//  Created by DM on 2/26/25.
//


import SwiftUI

/// Represents a single achievement the user can unlock.
struct Achievement: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isUnlocked: Bool
}

/// The data model that holds all achievements and provides logic for unlocking them.
class AchievementsModel: ObservableObject {
    @Published var achievements: [Achievement] = [
        Achievement(title: "Spooky Fan",
                    description: "Read 3 horror stories",
                    isUnlocked: false),
        Achievement(title: "Treasure Hunter",
                    description: "Complete 5 adventure stories",
                    isUnlocked: false),
        Achievement(title: "Library Explorer",
                    description: "Finish 50% of your saved library",
                    isUnlocked: false)
    ]
    
    /// Call this whenever a user finishes a story (progress = 1.0) to check if new achievements unlock.
    func checkAchievements(library: LibraryModel) {
        // Count completed horror stories
        let horrorTitles = ["Dracula", "Frankenstein", "Carmilla", "Jekyll and Hyde"]
        let horrorCompleted = library.savedStories.filter {
            $0.readingProgress == 1.0 && horrorTitles.contains($0.title)
        }.count
        if horrorCompleted >= 3 {
            unlock(title: "Spooky Fan")
        }
        
        // Count completed adventure stories
        let adventureTitles = ["Treasure Island", "The Count of Monte Cristo", "The Odyssey", "Robinson Crusoe"]
        let adventureCompleted = library.savedStories.filter {
            $0.readingProgress == 1.0 && adventureTitles.contains($0.title)
        }.count
        if adventureCompleted >= 5 {
            unlock(title: "Treasure Hunter")
        }
        
        // Check overall completion ratio
        if !library.savedStories.isEmpty {
            let total = library.savedStories.count
            let completed = library.savedStories.filter { $0.readingProgress == 1.0 }.count
            if Double(completed) / Double(total) >= 0.5 {
                unlock(title: "Library Explorer")
            }
        }
    }
    
    private func unlock(title: String) {
        if let index = achievements.firstIndex(where: { $0.title == title }) {
            if !achievements[index].isUnlocked {
                achievements[index].isUnlocked = true
            }
        }
    }
}
