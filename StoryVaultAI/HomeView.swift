//
//  HomeView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct HomeView: View {
    // Define your book data structure, conforming to Equatable
    struct Book: Equatable { // Added Equatable conformance
        let title: String
        let genre: String
        let coverImage: String // Name of the image in Assets.xcassets (e.g., "cover_alice_wonderland_home")
        
        // Implement Equatable by defining ==
        static func ==(lhs: Book, rhs: Book) -> Bool {
            return lhs.title == rhs.title &&
                   lhs.genre == rhs.genre &&
                   lhs.coverImage == rhs.coverImage
        }
    }
    
    // Sample book data for featured stories (replace with your actual featured books)
    let featuredBooks: [Book] = [
        Book(title: "Alice's Adventures in Wonderland", genre: "Fantasy", coverImage: "cover_alice_wonderland_home"),
        Book(title: "The Wonderful Wizard of Oz", genre: "Fantasy", coverImage: "cover_wizard_of_oz_home"),
        Book(title: "Dracula", genre: "Horror/Gothic", coverImage: "cover_dracula_home")
    ]
    
    // State for controlling the preview pop-up
    @State private var showPreview = false
    @State private var selectedBook: Book?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Featured Stories Carousel with Animations
                    TabView {
                        ForEach(featuredBooks, id: \.title) { book in
                            FeaturedBookView(book: book)
                                .onTapGesture {
                                    selectedBook = book
                                    showPreview = true
                                }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 450)
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .animation(.easeInOut, value: featuredBooks)
                    
                    // AI Adventure (Beta) Section
                    VStack(spacing: 10) {
                        Text("AI Adventure (Beta)")
                            .foregroundColor(.white)
                            .font(.headline)
                        NavigationLink(destination: AIBetaAdventureView()) {
                            Text("Try the Beta Experience")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.purple.opacity(0.7))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    // "Write Your Own Story" Button
                    NavigationLink(destination: WriteYourOwnStoryView()) {
                        Text("Write Your Own Story")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple.opacity(0.7))
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    // "View All" Button to Navigate to Marketplace
                    NavigationLink(destination: MarketplaceView()) {
                        Text("View All Stories")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple.opacity(0.7))
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    // Genre Quick Links
                    HStack(spacing: 10) {
                        ForEach(["Fantasy", "Adventure", "Horror/Gothic", "Romance"], id: \.self) { genre in
                            NavigationLink(destination: BooksByGenreView(genre: genre)) {
                                Text(genre)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.purple.opacity(0.7))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                    
                    // Placeholder for Recent Activity or Achievements
                    Text("Recent Activity & Achievements Coming Soon")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(10)
                }
                .padding()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle("StoryVault AI")
            .sheet(isPresented: $showPreview) {
                if let book = selectedBook {
                    PreviewView(book: book)
                }
            }
        }
    }
}

// Custom view for each featured book in the carousel, with animations
struct FeaturedBookView: View {
    let book: HomeView.Book
    
    var body: some View {
        Group {
            if let uiImage = UIImage(named: book.coverImage) {
                VStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 450)
                        .cornerRadius(12)
                        .scaleEffect(1.0) // Base scale for animation
                        .animation(.easeInOut(duration: 0.3), value: uiImage)
                    Text(book.title)
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 300, height: 450)
                    .cornerRadius(12)
                    .overlay(Text("No Cover").foregroundColor(.white))
            }
        }
        .onAppear {
            if UIImage(named: book.coverImage) == nil {
                print("Failed to load image: \(book.coverImage)")
            }
        }
    }
}

// Preview view for showing a sample AI interaction
struct PreviewView: View {
    let book: HomeView.Book
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Preview: \(book.title)")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                
                // Sample AI Interaction (Placeholder for choice-based narrative)
                Text("Choose your path in this AI adventure:")
                    .foregroundColor(.white)
                    .font(.headline)
                
                VStack(spacing: 10) {
                    Button("Explore the Rabbit Hole") {
                        // Placeholder for AI logic
                        print("Selected: Explore the Rabbit Hole for \(book.title)")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple.opacity(0.7))
                    .cornerRadius(10)
                    
                    Button("Follow the White Rabbit") {
                        // Placeholder for AI logic
                        print("Selected: Follow the White Rabbit for \(book.title)")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple.opacity(0.7))
                    .cornerRadius(10)
                    
                    Button("Stay Above Ground") {
                        // Placeholder for AI logic
                        print("Selected: Stay Above Ground for \(book.title)")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple.opacity(0.7))
                    .cornerRadius(10)
                }
                .padding()
                
                Button("Close Preview") {
                    // Dismiss the preview (handled by sheet)
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.red.opacity(0.7))
                .cornerRadius(10)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        // Dismiss the preview (handled by sheet)
                    }
                }
            }
        }
    }
}

// Placeholder view for AI Adventure (Beta)
struct AIBetaAdventureView: View {
    var body: some View {
        Text("AI Adventure Beta Experience")
            .foregroundColor(.white)
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle("AI Adventure (Beta)")
    }
}

// Placeholder view for books by genre (to be implemented fully later)
struct BooksByGenreView: View {
    let genre: String
    
    var body: some View {
        Text("Books in \(genre)")
            .foregroundColor(.white)
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationTitle(genre)
    }
}
