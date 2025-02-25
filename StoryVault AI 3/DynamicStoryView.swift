import SwiftUI

// MARK: - Dynamic Story View

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
                // Display a friendly error view if segment is missing.
                MissingSegmentView(segmentID: segmentID)
            }
        }
    }
}

// MARK: - Reusable Component: SegmentView

struct SegmentView: View {
    let segment: StorySegment
    
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
                // When there are no choices, provide restart and bookmark options.
                HStack(spacing: 16) {
                    Button("Restart Story") {
                        // Implement restart logic if desired.
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
                // Display each choice as a navigation link.
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
    
    // To use library in SegmentView, we either inject it or access via environment.
    @EnvironmentObject var library: LibraryModel
}

// MARK: - Reusable Component: MissingSegmentView

struct MissingSegmentView: View {
    let segmentID: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Story segment not found for ID:")
                .font(.headline)
            Text(segmentID)
                .font(.subheadline)
                .foregroundColor(.secondary)
            // Optionally, add a button to navigate back or retry.
            Button("Go Back") {
                // Implement navigation pop action if needed.
            }
            .padding()
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}
