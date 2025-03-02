//
//  BookRow.swift
//  StoryVaultAI
//
//  Created by DM on 3/1/25.
//

import SwiftUI

struct BookRow: View {
    let book: Book
    
    var body: some View {
        HStack {
            // If coverName is nil, fallback to "default-book-icon"
            Image(book.coverName ?? "default-book-icon")
                .resizable()
                .frame(width: 60, height: 90)
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            Text(book.title)
                .font(.headline)
                .padding(.leading, 8)
        }
        .padding(.vertical, 4)
    }
}

struct BookRow_Previews: PreviewProvider {
    static var previews: some View {
        BookRow(
            book: Book(
                title: "Treasure Island",
                author: "Robert Louis Stevenson",
                coverName: "cover_treasure_island"
            )
        )
    }
}
