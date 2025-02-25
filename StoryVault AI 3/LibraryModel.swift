
import SwiftUI

// MARK: - Library Model (Reading Progress)

struct LibraryItem: Identifiable {
    let id = UUID()
    var title: String
    var readingProgress: Double // 0...1
}

class LibraryModel: ObservableObject {
    @Published var savedStories: [LibraryItem] = []
    @Published var lastSegmentID: String? = nil
    
    func addStory(title: String) {
        if !savedStories.map({ $0.title }).contains(title) {
            let newItem = LibraryItem(title: title, readingProgress: 0.0)
            savedStories.append(newItem)
        }
    }
}
