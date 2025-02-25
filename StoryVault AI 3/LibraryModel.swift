import SwiftUI

struct LibraryItem: Identifiable {
    let id = UUID()
    var title: String
    var readingProgress: Double // 0...1
}

class LibraryModel: ObservableObject {
    @Published var savedStories: [String] = []
    @Published var lastSegmentID: String? = nil
    
    // For demonstration, you can also keep an array of LibraryItem if you want:
    // @Published var savedLibraryItems: [LibraryItem] = []
    
    func addStory(title: String) {
        if !savedStories.contains(title) {
            savedStories.append(title)
        }
    }
}
