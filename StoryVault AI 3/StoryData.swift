import SwiftUI

// MARK: - Dynamic Story Data

struct StorySegment: Identifiable, Codable, Hashable {
    let id: String
    let text: String
    let choices: [Choice]
}

struct Choice: Identifiable, Codable, Hashable {
    let id: String
    let text: String
    let destination: String
}

// MARK: - Story Manager

class StoryManager: ObservableObject {
    @Published var segments: [String: StorySegment] = [:]
    // New published property for error messages.
    @Published var errorMessage: String? = nil
    
    init() {
        loadBasicSegments()
    }
    
    func loadBasicSegments() {
        // Locate the story.json file in the main bundle.
        guard let url = Bundle.main.url(forResource: "story", withExtension: "json") else {
            let message = "Error: Could not find story.json file in bundle."
            print(message)
            self.errorMessage = message
            fallbackToDefaultData()
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let segmentsArray = try JSONDecoder().decode([StorySegment].self, from: data)
            self.segments = Dictionary(uniqueKeysWithValues: segmentsArray.map { ($0.id, $0) })
            // Clear any previous error message on success.
            self.errorMessage = nil
        } catch {
            let message = "Error decoding story JSON: \(error)"
            print(message)
            self.errorMessage = message
            fallbackToDefaultData()
        }
    }
    
    func fallbackToDefaultData() {
        // Fallback data in case loading fails.
        let defaultJSON = """
        [
            {
                "id": "defaultPage",
                "text": "Default story text. There was an error loading the story data.",
                "choices": []
            }
        ]
        """
        if let data = defaultJSON.data(using: .utf8),
           let segmentsArray = try? JSONDecoder().decode([StorySegment].self, from: data) {
            self.segments = Dictionary(uniqueKeysWithValues: segmentsArray.map { ($0.id, $0) })
        }
    }
}
