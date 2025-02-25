
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
    
    init() {
        loadBasicSegments()
    }
    
    func loadBasicSegments() {
        // Attempt to locate the "story.json" file in the main bundle.
        guard let url = Bundle.main.url(forResource: "story", withExtension: "json") else {
            print("Error: Could not find story.json file in bundle.")
            return
        }
        
        do {
            // Read the contents of the JSON file.
            let data = try Data(contentsOf: url)
            // Decode the JSON into an array of StorySegment.
            let segmentsArray = try JSONDecoder().decode([StorySegment].self, from: data)
            // Create a dictionary with segment IDs as keys.
            self.segments = Dictionary(uniqueKeysWithValues: segmentsArray.map { ($0.id, $0) })
        } catch {
            print("Error decoding story JSON: \(error)")
        }
    }
}
