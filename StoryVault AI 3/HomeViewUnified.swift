//
//  HomeViewUnified.swift
//  StoryVault AI 3
//
//  Created by DM on 2/24/25.
//

import SwiftUI

// MARK: - Color Extensions & Styles
extension Color {
    static let brandPrimary = Color.purple
    static let brandSecondary = Color.orange
}

/// Slight scale on press
struct ScaleOnPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

/// A “luxury” button style with a gold→purple gradient background
struct LuxuryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.85, green: 0.72, blue: 0.53), // gold
                        .brandPrimary
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(10)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Animated Background & Wave Shapes
struct AnimatedGradientBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        let gradient1 = [Color.black, Color.indigo.opacity(0.8)]
        let gradient2 = [Color.purple, Color.blue.opacity(0.8)]
        
        LinearGradient(
            gradient: Gradient(colors: animateGradient ? gradient1 : gradient2),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

struct TopWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addCurve(
            to: CGPoint(x: rect.width, y: 0),
            control1: CGPoint(x: rect.width * 0.3, y: rect.height * 0.3),
            control2: CGPoint(x: rect.width * 0.7, y: -rect.height * 0.3)
        )
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct BottomWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height),
            control1: CGPoint(x: rect.width * 0.3, y: rect.height * 0.8),
            control2: CGPoint(x: rect.width * 0.7, y: rect.height * 1.2)
        )
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}

// MARK: - RowWidthKey
struct RowWidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        let next = nextValue()
        if next > value { value = next }
    }
}

// MARK: - Featured Story Data Models
struct FeaturedStory: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
}

// (Optional) If you have a detail view for featured stories
struct FeaturedStoryDetailView: View {
    @EnvironmentObject var library: LibraryModel
    let story: FeaturedStory
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .indigo]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(systemName: story.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .background(Color.brandPrimary.opacity(0.2))
                    .cornerRadius(12)
                
                Text(story.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                Text(story.description)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("Add to Library") {
                    library.addStory(title: story.title)
                }
                .buttonStyle(.borderedProminent)
                .tint(.brandPrimary)
            }
            .padding()
        }
        .navigationBarTitle(story.title, displayMode: .inline)
    }
}

// MARK: - FeaturedStoriesRowView
struct FeaturedStoriesRowView: View {
    let stories: [FeaturedStory]
    @Binding var rowWidth: CGFloat
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(stories) { story in
                        NavigationLink(destination: FeaturedStoryDetailView(story: story).environmentObject(library)) {
                            VStack(spacing: 8) {
                                Image(systemName: story.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white)
                                    .background(Color.brandPrimary.opacity(0.2))
                                    .cornerRadius(12)
                                Text(story.title)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 80)
                        }
                        .buttonStyle(ScaleOnPressStyle())
                    }
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: RowWidthKey.self, value: proxy.size.width)
                    }
                )
                .onPreferenceChange(RowWidthKey.self) { newValue in
                    rowWidth = newValue
                }
                .padding(.leading, leadingPadding(for: geo.size.width, rowWidth: rowWidth))
                .padding(.trailing, trailingPadding(for: geo.size.width, rowWidth: rowWidth))
            }
        }
    }
    
    private func leadingPadding(for screenWidth: CGFloat, rowWidth: CGFloat) -> CGFloat {
        let leftover = screenWidth - rowWidth
        return leftover > 0 ? leftover / 2 : 0
    }
    private func trailingPadding(for screenWidth: CGFloat, rowWidth: CGFloat) -> CGFloat {
        leadingPadding(for: screenWidth, rowWidth: rowWidth)
    }
}

// MARK: - LibraryModel (Placeholder for demonstration)
class LibraryModel: ObservableObject {
    @Published var savedStories: [String] = []
    @Published var lastSegmentID: String? = nil
    
    func addStory(title: String) {
        if !savedStories.contains(title) {
            savedStories.append(title)
        }
    }
}

// MARK: - HomeView
struct HomeViewUnified: View {
    @EnvironmentObject var library: LibraryModel
    
    @State private var showButton = false
    @State private var showFeaturedStories = false
    @State private var rowWidth1: CGFloat = 0
    @State private var rowWidth2: CGFloat = 0
    
    private let featuredRow1: [FeaturedStory] = [
        FeaturedStory(title: "Beowulf", imageName: "book.fill", description: "Epic battles with Grendel"),
        FeaturedStory(title: "Knights of Everdawn", imageName: "book.fill", description: "Medieval fantasy & prophecy"),
        FeaturedStory(title: "Frankenstein", imageName: "book.fill", description: "Classic horror & creation"),
        FeaturedStory(title: "Treasure Island", imageName: "book.fill", description: "A pirate adventure on the high seas")
    ]
    
    private let featuredRow2: [FeaturedStory] = [
        FeaturedStory(title: "Dracula", imageName: "book.fill", description: "Gothic vampire terror"),
        FeaturedStory(title: "The War of the Worlds", imageName: "book.fill", description: "Martian invasion from H.G. Wells"),
        FeaturedStory(title: "Aesop’s Fables", imageName: "book.fill", description: "Timeless moral tales"),
        FeaturedStory(title: "Sherlock Holmes", imageName: "book.fill", description: "Classic detective expansions")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
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
                    
                    // CTA
                    if showButton {
                        NavigationLink(destination: Text("WriteYourOwnStoryView placeholder")) {
                            Text("Write Your Own Story")
                        }
                        .buttonStyle(LuxuryButtonStyle())
                        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
                    }
                    
                    // Recently Read
                    if let lastID = library.lastSegmentID,
                       let lastItem = library.savedStories.last {
                        Text("Recently Read")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 12) {
                            Text(lastItem)
                                .foregroundColor(.white)
                            Button("Continue") {
                                // Could navigate to the lastSegmentID if desired
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
                    NavigationLink(destination: Text("BeowulfAdventureView placeholder")) {
                        Text("AI Adventure (Beta)")
                            .font(.body)
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    // Featured Stories
                    Text("Featured Stories")
                        .font(.headline)
                        .foregroundColor(.white)
                        .scaleEffect(showFeaturedStories ? 1.0 : 0.8)
                        .opacity(showFeaturedStories ? 1.0 : 0.0)
                    
                    if showFeaturedStories {
                        FeaturedStoriesRowView(stories: featuredRow1, rowWidth: $rowWidth1)
                            .frame(height: 140)
                    }
                    
                    // More Adventures
                    Text("More Adventures")
                        .font(.headline)
                        .foregroundColor(.white)
                        .scaleEffect(showFeaturedStories ? 1.0 : 0.8)
                        .opacity(showFeaturedStories ? 1.0 : 0.0)
                    
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

// MARK: - Preview
struct HomeViewUnified_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewUnified()
            .environmentObject(LibraryModel())
    }
}
