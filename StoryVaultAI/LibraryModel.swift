//
//  LibraryModel.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

class LibraryModel: ObservableObject {
    @Published var savedStories: [SavedStory] = []
    
    struct SavedStory: Identifiable {
        let id = UUID()
        let title: String
        let genre: String
    }
    
    func addStory(title: String, genre: String) {
        let newStory = SavedStory(title: title, genre: genre)
        savedStories.append(newStory)
    }
    
    func removeStory(at offsets: IndexSet) {
        savedStories.remove(atOffsets: offsets)
    }
}
