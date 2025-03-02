//
//  FeaturedStoryViews.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct FeaturedLibraryDetailView: View { // Renamed from LibraryDetailView
    @Binding var item: LibraryItem

    var body: some View {
        VStack {
            // Background ring
            .background(Color.brandPrimary.opacity(0.2))
            .cornerRadius(12)
            Text(item.title)
                .foregroundColor(.white)
            Text(item.description)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            Button("Add to Library") {
                item.readingProgress = 1.0
                library.addStory(title: item.title, genre: item.genre) // Updated to include genre
            }
            .tint(.brandPrimary)
            .padding()
            .navigationBarTitle(item.title, displayMode: .inline)
        }
    }
}

struct FeaturedLibraryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedLibraryDetailView(item: .constant(LibraryItem(title: "Sample Story", description: "Sample description", readingProgress: 0.5, genre: "Fantasy"))) // Added genre for preview
            .preferredColorScheme(.dark)
            .environmentObject(LibraryModel())
    }
}
