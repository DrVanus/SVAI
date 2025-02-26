//
//  FeaturedStoriesRowView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

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
        return leadingPadding(for: screenWidth, rowWidth: rowWidth)
    }
}

struct FeaturedStoriesRowView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedStoriesRowView(stories: [
            FeaturedStory(title: "Beowulf", imageName: "book.fill", description: "Epic battles"),
            FeaturedStory(title: "Dracula", imageName: "book.fill", description: "Gothic terror")
        ], rowWidth: .constant(200))
        .environmentObject(LibraryModel())
    }
}
