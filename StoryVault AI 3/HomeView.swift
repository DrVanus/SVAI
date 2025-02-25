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
                    
                    // Recently Read section
                    if let lastID = library.lastSegmentID,
                       let lastItem = library.savedStories.last {
                        Text("Recently Read")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        HStack(spacing: 12) {
                            Text(lastItem.title)
                                .foregroundColor(.white)
                            Button("Continue") {
                                // Implement navigation to the last segment if desired.
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
                    
                    // Featured Stories Section
                    Text("Featured Stories")
                        .font(.headline)
                        .foregroundColor(.white)
                        .scaleEffect(showFeaturedStories ? 1.0 : 0.8)
                        .opacity(showFeaturedStories ? 1.0 : 0.0)
                    
                    if showFeaturedStories {
                        FeaturedStoriesRowView(stories: featuredRow1, rowWidth: $rowWidth1)
                            .frame(height: 140)
                    }
                    
                    // More Adventures Section
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
