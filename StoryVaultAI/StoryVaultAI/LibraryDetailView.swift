//
//  LibraryDetailView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct LibraryDetailView: View {
    @Binding var item: LibraryItem
    
    var body: some View {
        ZStack {
            // Subtle background color
            Color(uiColor: .systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 24) {
                    Spacer().frame(height: 40)
                    
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.brandPrimary)
                    
                    Text(item.title)
                        .font(.title2.bold())
                    
                    // Read-only progress
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Reading Progress: \(Int(item.readingProgress * 100))%")
                            .font(.subheadline)
                        
                        ProgressView(value: item.readingProgress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .brandPrimary))
                            .frame(width: 200)
                    }
                    .padding(.horizontal)
                    
                    // Mark as Completed sets progress to 100%
                    Button("Mark as Completed") {
                        item.readingProgress = 1.0
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    // Optional remove from library
                    Button(role: .destructive) {
                        // The parent view handles actual removal if needed
                    } label: {
                        Text("Remove from Library")
                    }
                    
                    Spacer().frame(height: 40)
                }
                .padding()
            }
        }
        .navigationTitle("Library Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
