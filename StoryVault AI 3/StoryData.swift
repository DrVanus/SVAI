import SwiftUI

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

class StoryManager: ObservableObject {
    @Published var segments: [String: StorySegment] = [:]
    @Published var errorMessage: String? = nil
    
    init() {
        loadBasicSegments()
    }
    
    func loadBasicSegments() {
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
            self.errorMessage = nil
        } catch {
            let message = "Error decoding story JSON: \(error)"
            print(message)
            self.errorMessage = message
            fallbackToDefaultData()
        }
    }
    
    func fallbackToDefaultData() {
        // Minimal fallback if loading fails
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
