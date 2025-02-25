import SwiftUI

struct LibraryItem: Identifiable {
    let id = UUID()
    var title: String
    var readingProgress: Double // 0...1
}

class LibraryModel: ObservableObject {
    @Published var savedStories: [String] = []
    @Published var lastSegmentID: String? = nil
    
    func addStory(title: String) {
        if !savedStories.contains(title) {
            savedStories.append(title)
        }
    }
}
