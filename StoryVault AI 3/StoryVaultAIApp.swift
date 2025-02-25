
import SwiftUI

// MARK: - App Entry

@main
struct StoryVaultAIApp: App {
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
