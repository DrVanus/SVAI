
import SwiftUI

// MARK: - Home Screen with Hidden Nav Bar

struct HomeView: View {
    @EnvironmentObject var library: LibraryModel
    
    @State private var showButton = false
    @State private var showFeaturedStories = false
    @State private var rowWidth1: CGFloat = 0
    @State private var rowWidth2: CGFloat = 0
    
    private let featuredRow1: [FeaturedStory] = [
        FeaturedStory(title: "Beowulf", imageName: "book.fill",
                      description: "Epic battles with Grendel"),
        FeaturedStory(title: "Knights of Everdawn", imageName: "book.fill",
                      description: "Medieval fantasy & prophecy"),
        FeaturedStory(title: "Frankenstein", imageName: "book.fill",
                      description: "Classic horror & creation"),
        FeaturedStory(title: "Treasure Island", imageName: "book.fill",
                      description: "A pirate adventure on the high seas")
    ]
    
    private let featuredRow2: [FeaturedStory] = [
        FeaturedStory(title: "Dracula", imageName: "book.fill",
                      description: "Gothic vampire terror"),
        FeaturedStory(title: "The War of the Worlds", imageName: "book.fill",
                      description: "Martian invasion from H.G. Wells"),
        FeaturedStory(title: "Aesop’s Fables", imageName: "book.fill",
                      description: "Timeless moral tales"),
        FeaturedStory(title: "Sherlock Holmes", imageName: "book.fill",
                      description: "Classic detective expansions")
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
                        NavigationLink(destination: WriteYourOwnStoryView()) {
                            Text("Write Your Own Story")
                        }
                        .buttonStyle(LuxuryButtonStyle())
                        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
                    }
                    
                    // If there's a lastSegmentID, show a “Recently Read” inline
                    if let lastID = library.lastSegmentID,
                       let lastItem = library.savedStories.last {
                        Text("Recently Read")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 12) {
                            Text(lastItem.title)
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
                    NavigationLink(destination: BeowulfAdventureView()) {
                        Text("AI Adventure (Beta)")
                            .font(.body)
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    // Row 1
                    Text("Featured Stories")
                        .font(.headline)
                        .foregroundColor(.white)
                        .scaleEffect(showFeaturedStories ? 1.0 : 0.8)
                        .opacity(showFeaturedStories ? 1.0 : 0.0)
                    
                    if showFeaturedStories {
                        geometryRow(for: featuredRow1, rowWidth: $rowWidth1)
                            .frame(height: 140)
                    }
                    
                    // Row 2
                    Text("More Adventures")
                        .font(.headline)
                        .foregroundColor(.white)
                        .scaleEffect(showFeaturedStories ? 1.0 : 0.8)
                        .opacity(showFeaturedStories ? 1.0 : 0.0)
                    
                    if showFeaturedStories {
                        geometryRow(for: featuredRow2, rowWidth: $rowWidth2)
                            .frame(height: 140)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
            .navigationBarHidden(true) // Hide nav bar label
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
    
    private func geometryRow(for stories: [FeaturedStory], rowWidth: Binding<CGFloat>) -> some View {
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
                    rowWidth.wrappedValue = newValue
                }
                .padding(.leading, leadingPadding(for: geo.size.width, rowWidth: rowWidth.wrappedValue))
                .padding(.trailing, trailingPadding(for: geo.size.width, rowWidth: rowWidth.wrappedValue))
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
