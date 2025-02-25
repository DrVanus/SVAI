
import SwiftUI

// MARK: - Dynamic Story View

struct DynamicStoryView: View {
    let segmentID: String
    @EnvironmentObject var storyManager: StoryManager
    @EnvironmentObject var library: LibraryModel
    
    var body: some View {
        if let segment = storyManager.segments[segmentID] {
            ScrollView {
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
                        Button("Restart Story") {}
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
            .navigationBarTitle("Story", displayMode: .inline)
            .onAppear {
                library.lastSegmentID = segmentID
            }
        } else {
            Text("Story segment not found.")
                .foregroundColor(.secondary)
        }
    }
}
