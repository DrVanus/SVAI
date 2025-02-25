//
//  Untitled.swift
//  StoryVault AI 2
//
//  Created by DM on 2/24/25.
//

import SwiftUI

// MARK: - Library Screen with Reading Progress

struct LibraryView: View {
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                List {
                    if library.savedStories.isEmpty {
                        Text("No saved stories yet")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach($library.savedStories) { $item in
                            NavigationLink(destination: LibraryDetailView(item: $item)) {
                                LibraryRow(item: item)
                            }
                        }
                        .onDelete { offsets in
                            library.savedStories.remove(atOffsets: offsets)
                        }
                    }
                }
            }
            .navigationBarTitle("Library", displayMode: .inline)
            .toolbar {
                EditButton()
            }
        }
    }
}

struct LibraryDetailView: View {
    @Binding var item: LibraryItem
    
    var body: some View {
        Form {
            Section(header: Text("Story Info")) {
                Text("Title: \(item.title)")
                HStack {
                    Text("Reading Progress: \(Int(item.readingProgress * 100))%")
                    Spacer()
                    Slider(value: $item.readingProgress, in: 0...1, step: 0.01)
                }
                
                // "Mark as Completed" sets readingProgress to 1.0
                Button("Mark as Completed") {
                    item.readingProgress = 1.0
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .navigationTitle("Library Detail")
    }
}

/// Row with a progress bar
struct LibraryRow: View {
    let item: LibraryItem
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "book.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                ProgressView(value: item.readingProgress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .brandPrimary))
                    .frame(width: 100)
            }
        }
        .padding(.vertical, 4)
    }
}
