
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
        // Minimal branching story
        let jsonString = """
        [
            {
                "id": "page1",
                "text": "You're at a fork in the road. Which way do you go?",
                "choices": [
                    {"id": "c1", "text": "Go Left", "destination": "pageLeft"},
                    {"id": "c2", "text": "Go Right", "destination": "pageRight"}
                ]
            },
            {
                "id": "pageLeft",
                "text": "You went left and discovered a hidden treasure! The End.",
                "choices": []
            },
            {
                "id": "pageRight",
                "text": "You went right and encountered a fierce beast! The End.",
                "choices": []
            }
        ]
        """
        let data = Data(jsonString.utf8)
        do {
            let segmentsArray = try JSONDecoder().decode([StorySegment].self, from: data)
            self.segments = Dictionary(uniqueKeysWithValues: segmentsArray.map { ($0.id, $0) })
        } catch {
            print("Error decoding story JSON: \(error)")
        }
    }
}
