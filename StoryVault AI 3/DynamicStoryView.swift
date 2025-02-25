import SwiftUI

struct DynamicStoryView: View {
    let segmentID: String
    @EnvironmentObject var storyManager: StoryManager
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        Group {
            if let segment = storyManager.segments[segmentID] {
                ScrollView {
                    SegmentView(segment: segment)
                }
                .navigationBarTitle("Story", displayMode: .inline)
                .onAppear {
                    library.lastSegmentID = segmentID
                }
            } else {
                MissingSegmentView(segmentID: segmentID)
            }
        }
    }
}

// MARK: - SegmentView
struct SegmentView: View {
    let segment: StorySegment
    
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text(segment.text)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(UIColor.secondarySystemBackground))
                )
                .shadow(radius: 2)
                .padding(.horizontal)
            
            if segment.choices.isEmpty {
                HStack(spacing: 16) {
                    Button("Restart Story") {
                        // Implement restart logic if desired
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button {
                        library.addStory(title: segment.text)
                    } label: {
                        Label("Bookmark this Story", systemImage: "heart.fill")
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            } else {
                ForEach(segment.choices) { choice in
                    NavigationLink(destination: DynamicStoryView(segmentID: choice.destination)) {
                        Text(choice.text)
                    }
                    .padding()
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            
            Spacer()
        }
        .padding(.top)
    }
}

// MARK: - MissingSegmentView
struct MissingSegmentView: View {
    let segmentID: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Story segment not found for ID:")
                .font(.headline)
            Text(segmentID)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button("Go Back") {
                // Implement pop or navigation if desired
            }
            .padding()
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}
