//
//  LibraryView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        NavigationView {
            someView
                .navigationTitle("Library")
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    private var someView: some View {
        List {
            // Add your library items here
        }
    }
}

struct LibraryRow: View {
    let story: LibraryModel.SavedStory
    
    var body: some View {
        HStack {
            Text(story.title)
                .foregroundColor(.white)
            Spacer()
            Text(story.genre)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct LibraryDetailView: View { // Ensure this is not redefined elsewhere
    let story: LibraryModel.SavedStory
    
    var body: some View {
        Text("Details for `\(story.title)")
            .foregroundColor(.white)
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle(story.title)
    }
}

// Ensure LibraryDetailView is not redefined elsewhere in the file
// Remove any duplicate definitions of LibraryDetailView if they exist

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .preferredColorScheme(.dark)
            .environmentObject(LibraryModel())
    }
}
