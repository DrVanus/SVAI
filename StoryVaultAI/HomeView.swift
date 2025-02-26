//
//  HomeView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var library: LibraryModel
    
    // Animate the button & featured stories
    @State private var showButton = false
    @State private var showFeaturedStories = false
    
    // Track widths for each row to center them
    @State private var rowWidth1: CGFloat = 0
    @State private var rowWidth2: CGFloat = 0
    
    // 8 public-domain classics (4 in each row)
    private let featuredRow1: [FeaturedStory] = [
        FeaturedStory(
            title: "The Wonderful Wizard of Oz",
            imageName: "book.fill",
            description: "Dorothy’s magical journey in Oz"
        ),
        FeaturedStory(
            title: "Alice’s Adventures in Wonderland",
            imageName: "book.fill",
            description: "Alice’s whimsical journey down the rabbit hole"
        ),
        FeaturedStory(
            title: "Treasure Island",
            imageName: "book.fill",
            description: "Pirate adventure with Long John Silver"
        ),
        FeaturedStory(
            title: "Pride and Prejudice",
            imageName: "book.fill",
            description: "Jane Austen’s witty romance"
        )
    ]
    
    private let featuredRow2: [FeaturedStory] = [
        FeaturedStory(
            title: "Dracula",
            imageName: "book.fill",
            description: "Seminal vampire horror"
        ),
        FeaturedStory(
            title: "Frankenstein",
            imageName: "book.fill",
            description: "Mary Shelley’s horror / early sci-fi"
        ),
        FeaturedStory(
            title: "The Adventures of Sherlock Holmes",
            imageName: "book.fill",
            description: "Iconic detective cases"
        ),
        FeaturedStory(
            title: "The Count of Monte Cristo",
            imageName: "book.fill",
            description: "Epic betrayal and revenge"
        )
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Animated gradient background
                AnimatedGradientBackground()
                
                // Top wave
                VStack {
                    TopWaveShape()
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 160)
                        .offset(y: -80)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                
                // Bottom wave
                VStack {
                    Spacer()
                    BottomWaveShape()
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 200)
                        .offset(y: 80)
                }
                .edgesIgnoringSafeArea(.bottom)
                
                // Main content
                VStack(spacing: 24) {
                    Spacer()
                    
                    // Title & tagline
                    VStack(spacing: 8) {
                        Text("StoryVault AI")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        
                        Text("Unlock Your Imagination")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    // CTA: "Write Your Own Story"
                    if showButton {
                        NavigationLink(destination: WriteYourOwnStoryView()) {
                            Text("Write Your Own Story")
                        }
                        .buttonStyle(LuxuryButtonStyle())
                        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
                    }
                    
                    // Recently Read logic
                    if let lastID = library.lastSegmentID,
                       let lastItem = library.savedStories.last {
                        Text("Recently Read")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 12) {
                            Text(lastItem.title) // or just lastItem if it’s a String
                                .foregroundColor(.white)
                            Button("Continue") {
                                // Potentially navigate to DynamicStoryView(segmentID: lastID) or similar
                            }
                            .font(.caption).bold()
                            .buttonStyle(BorderlessButtonStyle())
                            .padding(4)
                            .background(Color.brandPrimary)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                    
                    // AI Adventure (Beta)
                    NavigationLink(destination: BeowulfAdventureView()) {
                        Text("AI Adventure (Beta)")
                            .font(.body)
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    // "Featured Stories" label
                    Text("Featured Stories")
                        .font(.headline)
                        .foregroundColor(.white)
                        .scaleEffect(showFeaturedStories ? 1.0 : 0.8)
                        .opacity(showFeaturedStories ? 1.0 : 0.0)
                    
                    // Row 1
                    if showFeaturedStories {
                        FeaturedStoriesRowView(stories: featuredRow1, rowWidth: $rowWidth1)
                            .frame(height: 140)
                    }
                    
                    // "More Adventures" label
                    Text("More Adventures")
                        .font(.headline)
                        .foregroundColor(.white)
                        .scaleEffect(showFeaturedStories ? 1.0 : 0.8)
                        .opacity(showFeaturedStories ? 1.0 : 0.0)
                    
                    // Row 2
                    if showFeaturedStories {
                        FeaturedStoriesRowView(stories: featuredRow2, rowWidth: $rowWidth2)
                            .frame(height: 140)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.easeIn(duration: 1.0)) {
                    showButton = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        showFeaturedStories = true
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
